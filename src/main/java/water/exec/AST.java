package water.exec;

import java.text.NumberFormat;
import java.text.ParsePosition;
import java.util.ArrayList;
import java.util.Arrays;

import water.*;
import water.fvec.Frame;
import water.fvec.Vec;

/** Parse a generic R string and build an AST, in the context of an H2O Cloud
 *  @author cliffc@0xdata.com
 */

// --------------------------------------------------------------------------
abstract public class AST extends Iced {
  final transient Type _t;
  AST( Type t ) { assert t != null; _t = t; }
  static AST parseCXExpr(Exec2 E ) {
    AST ast2, ast = ASTSlice.parse(E);
    if( ast == null ) return ASTAssign.parseNew(E);
    // Can find an infix: {op expr}*
    if( (ast2 = ASTApply.parseInfix(E,ast)) != null ) return ast2;
    // Can find '=' between expressions
    if( (ast2 = ASTAssign.parse    (E,ast)) != null ) return ast2;
    // Infix trinay
    if( (ast2 = ASTIfElse.parse    (E,ast)) != null ) return ast2;
    return ast;                 // Else a simple slice/expr
  }

  static AST parseVal(Exec2 E ) {
    AST ast;
    // Simple paren expression
    if( E.peek('(') )  return E.xpeek(')',E._x,parseCXExpr(E));
    if( (ast = ASTId   .parse(E)) != null ) return ast;
    if( (ast = ASTNum  .parse(E)) != null ) return ast;
    if( (ast = ASTOp   .parse(E)) != null ) return ast;
    return null;
  }
  abstract void exec(Env env);
  boolean isPosConstant() { return false; }
  protected StringBuilder indent( StringBuilder sb, int d ) {
    for( int i=0; i<d; i++ ) sb.append("  ");
    return sb.append(_t).append(' ');
  }
  public StringBuilder toString( StringBuilder sb, int d ) { return indent(sb,d).append(this); }
}

// --------------------------------------------------------------------------
class ASTStatement extends AST {
  final AST[] _asts;
  ASTStatement( AST[] asts ) { super(asts[asts.length-1]._t); _asts = asts; }

  static ASTStatement parse( Exec2 E ) {
    ArrayList<AST> asts = new ArrayList<AST>();
    while( true ) {
      AST ast = parseCXExpr(E);
      if( ast == null ) break;
      asts.add(ast);
      if( !E.peek(';') ) break;
    }
    if( asts.size()==0 ) return null;
    return new ASTStatement(asts.toArray(new AST[asts.size()]));
  }
  void exec(Env env) {
    for( int i=0; i<_asts.length-1; i++ ) {
      _asts[i].exec(env);       // Exec all statements
      env.pop();                // Pop all intermediate results
    }
    _asts[_asts.length-1].exec(env); // Return final statement as result
  }
  @Override public String toString() { return ";;;"; }
  public StringBuilder toString( StringBuilder sb, int d ) {
    for( int i=0; i<_asts.length-1; i++ )
      _asts[i].toString(sb,d+1).append(";\n");
    return _asts[_asts.length-1].toString(sb,d+1);
  }
}

// --------------------------------------------------------------------------
class ASTApply extends AST {
  final AST _args[];
  private ASTApply( AST args[], int x ) { super(args[0]._t.ret());  _args = args;  }

  // Wrap compatible but different-sized ops in reduce/bulk ops.
  static ASTApply make(AST args[],Exec2 E, int x) {
    // Make a type variable for this application
    Type ts[] = new Type[args.length];
    ts[0] = Type.unbound();
    for( int i=1; i<ts.length; i++ )
      ts[i] = args[i]._t.find();
    Type ft1 = Type.fcn(ts);
    AST fast = args[0];
    Type ft2 = fast._t.find();  // Should be a function type
    if( ft1.union(ft2) )        // Union 'em
      return new ASTApply(args,x);
    // Error handling
    if( ft2.isNotFun() )      // Oops, failed basic sanity
      E.throwErr("Function-parens following a "+ft2,x);
    if( ft2._ts.length != ts.length )
      E.throwErr("Passed "+(ts.length-1)+" args but expected "+(ft2._ts.length-1),x);
    String vars[] = (fast instanceof ASTOp) ? ((ASTOp)fast)._vars : null;
    for( int i=1; i<ts.length; i++ )
      if( !ft2._ts[i].union(args[i]._t) )
        E.throwErr("Arg "+(vars==null?("#"+i):("'"+vars[i]+"'"))+" typed as "+ft2._ts[i]+" but passed "+args[i]._t.find(),x);
    throw H2O.fail();
  }

  // Parse a prefix operator
  static AST parsePrefix(Exec2 E) {
    AST pre = parseVal(E);
    if( pre == null ) return null;
    while( true ) {
      if( pre._t.isNotFun() ) return pre; // Bail now if clearly not a function
      int x = E._x;
      if( !E.peek('(') ) return pre; // Plain op, no prefix application
      AST args[] = new AST[] { pre, null };
      int i=1;
      if( !E.peek(')') ) {
        while( true ) {
          args[i++] = parseCXExpr(E);
          if( E.peek(')') ) break;
          E.xpeek(',',E._x,null);
          if( i==args.length ) args = Arrays.copyOf(args,args.length<<1);
        }
      }
      args = Arrays.copyOf(args,i);
      pre = make(args,E,x);
    }
  }

  // Parse an infix boolean operator
  static AST parseInfix(Exec2 E, AST ast) {
    AST inf = null;
    while( true ) {
      ASTOp op = ASTOp.parse(E);
      if( op == null || op._vars.length != 3 ) return inf;
      int x = E._x;
      AST rite = ASTSlice.parse(E);
      if( rite==null ) E.throwErr("Missing expr or unknown ID",x);
      ast = inf = make(new AST[]{op,ast,rite},E,x);
    }
  }

  @Override public String toString() { return _args[0].toString()+"()"; }
  @Override public StringBuilder toString( StringBuilder sb, int d ) {
    _args[0].toString(sb,d).append("\n");
    for( int i=1; i<_args.length-1; i++ )
      _args[i].toString(sb,d+1).append('\n');
    return _args[_args.length-1].toString(sb,d+1);
  }
  // Apply: execute all arguments (including the function argument) yielding
  // the function itself, plus all normal arguments on the stack.  Then execute
  // the function, which is responsible for popping all arguments and pushing
  // the result.
  @Override void exec(Env env) {
    int sp = env._sp;
    for( AST arg : _args ) arg.exec(env);
    assert sp+_args.length==env._sp;
    env.fcn(-_args.length).apply(env,_args.length);
  }
}

// --------------------------------------------------------------------------
class ASTSlice extends AST {
  final AST _ast, _cols, _rows; // 2-D slice of an expression
  ASTSlice( Type t, AST ast, AST cols, AST rows ) {
    super(t); _ast = ast; _cols = cols; _rows = rows;
  }
  static AST parse(Exec2 E ) {
    int x = E._x;
    AST ast = ASTApply.parsePrefix(E);
    if( ast == null ) return null;
    if( !E.peek('[') ) return ast; // No slice
    if( !Type.ARY.union(ast._t) ) E.throwErr("Not an ary",x);
    if(  E.peek(']') ) return ast; // [] ===> same as no slice
    AST rows=E.xpeek(',',(x=E._x),parseCXExpr(E));
    if( rows != null && !rows._t.union(Type.dblary()) ) E.throwErr("Must be scalar or array",x);
    AST cols=E.xpeek(']',(x=E._x),parseCXExpr(E));
    if( cols != null && !cols._t.union(Type.dblary()) ) E.throwErr("Must be scalar or array",x);
    Type t =                    // Provable scalars will type as a scalar
      rows != null && rows.isPosConstant() &&
      cols != null && cols.isPosConstant() ? Type.DBL : Type.ARY;
    return new ASTSlice(t,ast,cols,rows);
  }

  @Override void exec(Env env) {
    int sp = env._sp;  _ast.exec(env);  assert sp+1==env._sp;

    // Scalar load?  Throws AIIOOB if out-of-bounds
    if( _t.isDbl() ) {
      // Known that rows & cols are simple positive constants.
      // Use them directly, throwing a runtime error if OOB.
      long row = (long)((ASTNum)_rows)._d;
      int  col = (int )((ASTNum)_cols)._d;
      Frame ary=env.popAry();
      String skey = env.key();
      double d = ary.vecs()[col-1].at(row-1);
      env.subRef(ary,skey);     // Toss away after loading from it
      env.push(d);
    } else {
      // Else It's A Big Copy.  Some Day look at proper memory sharing,
      // disallowing unless an active-temp is available, etc.
      // Eval cols before rows (R's eval order).
      Frame ary=env._ary[env._sp-1];  // Get without popping
      Object cols = select(ary.numCols(),_cols,env);
      Object rows = select(ary.numRows(),_rows,env);
      Frame fr2 = ary.deepSlice(rows,cols);
      // After slicing, pop all expressions (cannot lower refcnt till after all uses)
      if( rows!= null ) env.pop();
      if( cols!= null ) env.pop();
      if( fr2 == null ) fr2 = new Frame(); // Replace the null frame with the zero-column frame
      env.pop();                // Pop sliced frame, lower ref
      env.push(fr2);
    }
  }

  // Execute a col/row selection & return the selection.  NULL means "all".
  // Error to mix negatives & positive.  Negative list is sorted, with dups
  // removed.  Positive list can have dups (which replicates cols) and is
  // ordered.  numbers.  1-based numbering; 0 is ignored & removed.
  static Object select( long len, AST ast, Env env ) {
    if( ast == null ) return null; // Trivial "all"
    ast.exec(env);
    long cols[];
    if( !env.isAry() ) {
      int col = (int)env._d[env._sp-1]; // Peek double; Silent truncation (R semantics)
      if( col < 0 && col < -len ) col=0; // Ignore a non-existent column
      if( col == 0 ) return new long[0];
      return new long[]{col};
    }
    // Got a frame/list of results.
    // Decide if we're a toss-out or toss-in list
    Frame ary = env._ary[env._sp-1];  // Peek-frame
    if( ary.numCols() != 1 ) throw new IllegalArgumentException("Selector must be a single column: "+ary);
    Vec vec = ary.anyVec();
    // Check for a matching column of bools.
    if( ary.numRows() == len && vec.min()>=0 && vec.max()<=1 && vec.isInt() )
      return ary;    // Boolean vector selection.
    // Convert single vector to a list of longs selecting rows
    if(ary.numRows() > 100000) throw H2O.unimpl();
    cols = MemoryManager.malloc8((int)ary.numRows());
    for(int i = 0; i < cols.length; ++i){
      if(vec.isNA(i))throw new IllegalArgumentException("Can not use NA as index!");
      cols[i] = vec.at8(i);
    }
    return cols;
  }

  @Override public String toString() { return "[,]"; }
  public StringBuilder toString( StringBuilder sb, int d ) {
    indent(sb,d).append(this).append('\n');
    _ast.toString(sb,d+1).append("\n");
    if( _cols==null ) indent(sb,d+1).append("all\n");
    else      _cols.toString(sb,d+1).append("\n");
    if( _rows==null ) indent(sb,d+1).append("all");
    else      _rows.toString(sb,d+1);
    return sb;
  }
}

// --------------------------------------------------------------------------
class ASTId extends AST {
  final String _id;
  final int _depth;             // *Relative* lexical depth of definition
  final int _num;               // Number/slot in the lexical scope
  ASTId( Type t, String id, int d, int n ) { super(t); _id=id; _depth=d; _num=n; }
  // Parse a valid ID, or return null;
  static ASTId parse(Exec2 E) {
    int x = E._x;
    String var = E.isID();
    if( var == null ) return null;
    // Built-in ops parse as ops, not vars
    if( ASTOp.OPS.containsKey(var) ) { E._x=x; return null; }
    // See if pre-existing
    for( int d=E.lexical_depth(); d >=0; d-- ) {
      ArrayList<ASTId> asts = E._env.get(d);
      for( int i=asts.size()-1; i >=0; i-- ) {
        ASTId id = asts.get(i);
        if( var.equals(id._id) )
          // Return an ID with a relative lexical depth and same slot#
          return new ASTId(id._t,id._id,E.lexical_depth()-d,id._num);
      }
    }
    // Never see-before ID?  Treat as a bad parse
    E._x=x;
    return null;
  }
  // Parse a NEW valid ID, or return null;
  static String parseNew(Exec2 E) {
    int x = E._x;
    String id = E.isID();
    if( id == null ) return null;
    // Built-in ops parse as ops, not vars
    if( ASTOp.OPS.containsKey(id) ) { E._x=x; return null; }
    return id;
  }
  @Override void exec(Env env) {
    // Local scope?  Grab from the stack.
    if( _depth ==0 ) {
      env.push_slot(_depth,_num);
      return;
    }
    // Nested scope?  need to grab from the nested-scope closure
    ASTFunc fcn = env.fcnScope(_depth);
    fcn._env.push_slot(_depth-1,_num,env);
  }
  @Override public String toString() { return _id; }
}

// --------------------------------------------------------------------------
class ASTAssign extends AST {
  final AST _lhs;
  final AST _eval;
  ASTAssign( AST lhs, AST eval ) { super(lhs._t); _lhs=lhs; _eval=eval; }
  // Parse a valid LHS= or return null
  static ASTAssign parse(Exec2 E, AST ast) {
    int x = E._x;
    // Allow '=' and '<-' assignment
    if( !E.peek('=') ) {
      if( !(E.peek('<') && E.peek('-')) ) { E._x=x; return null; }
    }
    AST ast2=ast;
    ASTSlice slice= null;
    if( (ast instanceof ASTSlice) ) // Peek thru slice op
      ast2 = (slice=(ASTSlice)ast)._ast;
    // Must be a simple in-scope ID
    if( !(ast2 instanceof ASTId) ) E.throwErr("Can only assign to ID (or slice)",x);
    AST eval = parseCXExpr(E);
    if( eval == null ) E.throwErr("Missing RHS",x);
    ASTId id = (ASTId)ast2;
    boolean partial = slice != null && (slice._cols != null || slice._rows != null);
    if( partial ) {             // Partial slice assignment?
      if( eval._t.isFcn() ) E.throwErr("Assigning a "+eval._t+" into '"+id._id+"' which is a "+id._t,x);
      if(  E.lexical_depth()> 0 ) throw H2O.unimpl(); // Must copy whole array locally, before updating the local copy
    }

    if( id._depth > 0 ) {       // Shadowing an outer scope?
      // Inner-scope assignment to a new local
      ast = id = extend_local(E,eval._t,id._id);
    } else {                    // Overwriting same scope
      if( E.lexical_depth()>0 ) { // Inner scope?
        if( !ast._t.union(eval._t) ) // Disallow type changes in local scope in functions.
          E.throwErr("Assigning a "+eval._t+" into '"+id._id+"' which is a "+id._t,x);
      } else {                  // Outer scope; can change type willy-nilly
        if( !partial && !ast._t.union(eval._t) ) {
          ArrayList<ASTId> vars = E._env.get(0);
          ASTId id2 = new ASTId(eval._t,id._id,0,id._num);
          vars.set(id2._num,id2);
          ast = id2;
        }
      }
    }

    return new ASTAssign(ast,eval);
  }
  // Parse a valid LHS= or return null - for a new variable
  static ASTAssign parseNew(Exec2 E) {
    int x = E._x;
    String var = ASTId.parseNew(E);
    if( var == null ) return null;
    if( !E.peek('=') ) {        // Not an assignment
      if( !(E.peek('<') && E.peek('-')) ) { // The other assignment operator
        if( Exec2.isLetter(var.charAt(0) ) ) E.throwErr("Unknown var "+var,x);
        E._x=x; return null;      // Let higher parse levels sort it out
      }
    }
    x = E._x;
    AST eval = parseCXExpr(E);
    if( eval == null ) E.throwErr("Missing RHS",x);
    // Extend the local environment by the new name
    return new ASTAssign(extend_local(E,eval._t,var),eval);
  }
  static ASTId extend_local( Exec2 E, Type t, String var ) {
    ArrayList<ASTId> vars = E._env.get(E.lexical_depth());
    ASTId id = new ASTId(t,var,0,vars.size());
    vars.add(id);
    return id;
  }

  @Override void exec(Env env) {
    _eval.exec(env);            // RHS before LHS (R eval order)
    if( _lhs instanceof ASTId ) {
      ASTId id = (ASTId)_lhs;
      env.tos_into_slot(id._depth,id._num,id._id);
      return;
    }
    // Peel apart a slice assignment
    ASTSlice slice = (ASTSlice)_lhs;
    ASTId id = (ASTId)slice._ast;
    assert id._depth==0;        // Can only modify in the local scope.
    // Simple assignment using the slice syntax
    if( slice._rows==null & slice._cols==null ) {
      env.tos_into_slot(id._depth,id._num,id._id);
      return;
    }
    // Pull the LHS off the stack; do not lower the refcnt
    Frame ary = env.frId(id._depth,id._num);
    // Pull the RHS off the stack; do not lower the refcnt
    Frame ary_rhs=null;  double d=Double.NaN;
    if( env.isDbl() ) d = env.popDbl(); else ary_rhs = env.popAry();

    // Typed as a double ==> the row & col selectors are simple constants
    if( slice._t == Type.DBL ) { // Typed as a double?
      assert ary_rhs==null;
      long row = (long)((ASTNum)slice._rows)._d;
      int  col = (int )((ASTNum)slice._cols)._d;
      ary.vecs()[col].set(row,d);
      env.push(d);
      return;
    }

    // Execute the slice LHS selection operators
    Object cols = ASTSlice.select(ary.numCols(),slice._cols,env);
    Object rows = ASTSlice.select(ary.numRows(),slice._rows,env);

    // Partial row assignment?
    if( rows != null ) throw H2O.unimpl();
    assert cols != null; // all/all assignment uses simple-assignment

    // Convert constant into a whole vec
    if( ary_rhs == null )
      ary_rhs = new Frame(env.addRef(ary.anyVec().makeCon(d)));
    // Make sure we either have 1 col (repeated) or exactly a matching count
    long[] cs = (long[]) cols;  // Columns to act on
    if( ary_rhs.numCols() != 1 && 
        ary_rhs.numCols() != cs.length )
      throw new IllegalArgumentException("Can only assign to a matching set of columns; trying to assign "+ary_rhs.numCols()+" cols over "+cs.length+" cols");
    // Replace the LHS cols with the RHS cols
    Vec rvecs[] = ary_rhs.vecs();
    Futures fs = null;
    for( long i : cs ) {
      int cidx = (int)i-1;      // Convert 1-based to 0-based
      Vec rv = env.addRef(rvecs[rvecs.length==1?0:cidx]);
      if( cidx == ary.numCols() ) ary.add("C"+cidx,rv);
      else fs = env.subRef(ary.replace(cidx,rv),fs);
    }
    if( fs != null )  fs.blockForPending();

    // After slicing, pop all expressions (cannot lower refcnt till after all uses)
    if( rows!= null ) env.pop();
    if( cols!= null ) env.pop();
    env.subRef(ary_rhs,null);
    env.push(ary);
  }
  @Override public String toString() { return "="; }
  @Override public StringBuilder toString( StringBuilder sb, int d ) {
    indent(sb,d).append(this).append('\n');
    _lhs.toString(sb,d+1).append('\n');
    _eval.toString(sb,d+1);
    return sb;
  }
}

// --------------------------------------------------------------------------
class ASTNum extends AST {
  static final NumberFormat NF = NumberFormat.getInstance();
  static { NF.setGroupingUsed(false); }
  final double _d;
  ASTNum(double d) { super(Type.DBL); _d=d; }
  // Parse a number, or throw a parse error
  static ASTNum parse(Exec2 E) {
    ParsePosition pp = new ParsePosition(E._x);
    Number N = NF.parse(E._str,pp);
    if( pp.getIndex()==E._x ) return null;
    assert N instanceof Double || N instanceof Long;
    E._x = pp.getIndex();
    double d = (N instanceof Double) ? (double)(Double)N : (double)(Long)N;
    return new ASTNum(d);
  }
  boolean isPosConstant() { return _d >= 0; }
  @Override void exec(Env env) { env.push(_d); }
  @Override public String toString() { return Double.toString(_d); }
}
