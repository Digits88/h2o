package water.exec;

import java.util.ArrayList;
import water.H2O;

/** Parse a generic R string and build an AST, in the context of an H2O Cloud
 *  @author cliffc@0xdata.com
 */

// --------------------------------------------------------------------------
public class ASTFunc extends ASTOp {
  final AST _body;
  final int _tmps;
  Env _env;                     // Captured environment at each apply point
  ASTFunc( String vars[], Type vtypes[], AST body, int tmps ) { super(vars,vtypes); _body = body; _tmps=tmps; }
  @Override String opStr() { return "fun"; }
  @Override ASTOp make() { throw H2O.fail();} 
  static ASTOp parseFcn(Exec2 E ) {
    int x = E._x;
    String var = E.isID();
    if( var == null ) return null;
    if( !"function".equals(var) ) { E._x = x; return null; }
    E.xpeek('(',E._x,null);
    ArrayList<ASTId> vars = new ArrayList<ASTId>();
    if( !E.peek(')') ) {
      while( true ) {
        x = E._x;
        var = E.isID();
        if( var == null ) E.throwErr("Invalid var",x);
        for( ASTId id : vars ) if( var.equals(id._id) ) E.throwErr("Repeated argument",x);
        // Add unknown-type variable to new vars list
        vars.add(new ASTId(Type.unbound(),var,0,vars.size()));
        if( E.peek(')') ) break;
        E.xpeek(',',E._x,null);
      }
    }
    int argcnt = vars.size();   // Record current size, as body may extend
    // Parse the body
    E.xpeek('{',(x=E._x),null);
    E._env.push(vars);
    AST body = E.xpeek('}',E._x,ASTStatement.parse(E));
    if( body == null ) E.throwErr("Missing function body",x);
    E._env.pop();

    // The body should force the types.  Build a type signature.
    String xvars[] = new String[argcnt+1];
    Type   types[] = new Type  [argcnt+1];
    xvars[0] = "fun";
    types[0] = body._t;         // Return type of body
    for( int i=0; i<argcnt; i++ ) {
      ASTId id = vars.get(i);
      xvars[i+1] = id._id;
      types[i+1] = id._t;
    }
    return new ASTFunc(xvars,types,body,vars.size()-argcnt);
  }  
  
  @Override void exec(Env env) { 
    // We need to push a Closure: the ASTFunc plus captured environment.
    // Make a shallow copy (the body remains shared across all ASTFuncs).
    // Then fill in the current environment.
    ASTFunc fun = (ASTFunc)clone();
    fun._env = env.capture();
    env.push(fun);
  }
  @Override void apply(Env env, int argcnt) { 
    int res_idx = env.pushScope(argcnt-1);
    env.push(_tmps);
    _body.exec(env);
    env.tos_into_slot(1,res_idx-1,null);
    env.popScope();
  }
  @Override public StringBuilder toString( StringBuilder sb, int d ) {
    indent(sb,d).append(this).append(") {\n");
    _body.toString(sb,d+1).append("\n");
    return indent(sb,d).append("}");
  }
}
