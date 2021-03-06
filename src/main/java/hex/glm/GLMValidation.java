package hex.glm;

import hex.ConfusionMatrix;
import hex.glm.GLMParams.Family;

import java.text.DecimalFormat;

import water.*;
import water.api.DocGen;
import water.api.Request.API;
import water.api.RequestBuilders;

/**
 * Class for GLMValidation.
 *
 * @author tomasnykodym
 *
 */
public class GLMValidation extends Iced {
  static final int API_WEAVER = 1; // This file has auto-gen'd doc & json fields
  static public DocGen.FieldDoc[] DOC_FIELDS; // Initialized from Auto-Gen code.

  @API(help="")
  final double _ymu;
  @API(help="")
  double residual_deviance;
  @API(help="")
  double null_deviance;
  @API(help="")
  double avg_err;
  @API(help="")
  long nobs;

  @API(help="best decision threshold")
  float best_threshold;

  @API(help="")
  double auc = Double.NaN;

  @API(help="AIC")
  double aic;// internal aic used only for poisson family!
  @API(help="internal aic used only for poisson family!")
  private double _aic2;// internal aic used only for poisson family!
  @API(help="")
  final Key dataKey;
  @API(help="")
  ConfusionMatrix [] _cms;
  @API(help="")
  final GLMParams _glm;
  @API(help="")
  final private int _rank;

  public static class GLMXValidation extends GLMValidation {
    Key [] _xvalModels;
    public GLMXValidation(GLMModel mainModel, GLMModel [] xvalModels, int lambdaIdx) {
      super(mainModel._dataKey, mainModel.ymu, mainModel.glm, mainModel.rank(lambdaIdx));
      _xvalModels = new Key[xvalModels.length];
      for(int i = 0; i < xvalModels.length; ++i){
        add(xvalModels[i].validation());
        _xvalModels[i] = xvalModels[i]._selfKey;
      }
      finalize_AIC_AUC();
    }
  }
  public GLMValidation(Key dataKey, double ymu, GLMParams glm, int rank){
    _rank = rank;
    _ymu = ymu;
    _glm = glm;
    if(_glm.family == Family.binomial){
      _cms = new ConfusionMatrix[DEFAULT_THRESHOLDS.length];
      for(int i = 0; i < _cms.length; ++i)
        _cms[i] = new ConfusionMatrix(2);
    }
    this.dataKey = dataKey;
  }
  protected void regularize(double reg){avg_err = avg_err*reg;}
  public static Key makeKey(){return Key.make("__GLMValidation_" + Key.make());}
  public void add(double yreal, double ymodel){
    null_deviance += _glm.deviance(yreal, _ymu);
    if(_glm.family == Family.binomial) // clasification -> update confusion matrix too
      for(int i = 0; i < DEFAULT_THRESHOLDS.length; ++i)
        _cms[i].add((int)yreal, (ymodel >= DEFAULT_THRESHOLDS[i])?1:0);
    if(Double.isNaN(_glm.deviance(yreal, ymodel)))
      System.out.println("NaN from yreal=" + yreal + ", ymodel=" + ymodel);
    residual_deviance  += _glm.deviance(yreal, ymodel);
    ++nobs;
    avg_err += (ymodel - yreal) * (ymodel - yreal);
    if( _glm.family == Family.poisson ) { // aic for poisson
      long y = Math.round(yreal);
      double logfactorial = 0;
      for( long i = 2; i <= y; ++i )
        logfactorial += Math.log(i);
      _aic2 += (yreal * Math.log(ymodel) - logfactorial - ymodel);
    }
  }
  public void add(GLMValidation v){
    residual_deviance  += v.residual_deviance;
    null_deviance += v.null_deviance;
    avg_err = (double)nobs/(nobs+v.nobs)*avg_err +  (double)v.nobs/(nobs+v.nobs)*v.avg_err;
    nobs += v.nobs;
    _aic2 += v._aic2;
    if(_cms == null)_cms = v._cms;
    else for(int i = 0; i < _cms.length; ++i)_cms[i].add(v._cms[i]);
  }
  public final double nullDeviance(){return null_deviance;}
  public final double residualDeviance(){return residual_deviance;}
  public final long nullDOF(){return nobs-1;}
  public final long resDOF(){return nobs - _rank -1;}
  public double auc(){return auc;}
  public double aic(){return aic;}
  protected void computeAIC(){
    aic = 0;
    switch( _glm.family ) {
      case gaussian:
        aic =  nobs * (Math.log(residual_deviance / nobs * 2 * Math.PI) + 1) + 2;
        break;
      case binomial:
        aic = residual_deviance;
        break;
      case poisson:
        aic = -2*_aic2;
        break; // aic is set during the validation task
      case gamma:
      case tweedie:
        aic = Double.NaN;
        break;
      default:
        assert false : "missing implementation for family " + _glm.family;
    }
    aic += 2*_rank;
  }
  @Override
  public String toString(){
    return "null_dev = " + null_deviance + ", res_dev = " + residual_deviance + ", auc = " + auc();
  }

  protected void finalize_AIC_AUC(){
    computeAIC();
    if(_glm.family == Family.binomial)computeAUC();
  }
  /**
   * Computes area under the ROC curve. The ROC curve is computed from the confusion matrices
   * (there is one for each computed threshold). Area under this curve is then computed as a sum
   * of areas of trapezoids formed by each neighboring points.
   *
   * @return estimate of the area under ROC curve of this classifier.
   */
  double[] tprs;
  double[] fprs;
  protected void computeAUC() {
    if( _cms == null ) return;
    tprs = new double[_cms.length];
    fprs = new double[_cms.length];
    double auc = 0;           // Area-under-ROC
    double TPR_pre = 1;
    double FPR_pre = 1;
    for( int t = 0; t < _cms.length; ++t ) {
      double TPR = 1 - _cms[t].classErr(1); // =TP/(TP+FN) = true -positive-rate
      double FPR = _cms[t].classErr(0); // =FP/(FP+TN) = false-positive-rate
      auc += trapeziod_area(FPR_pre, FPR, TPR_pre, TPR);
      TPR_pre = TPR;
      FPR_pre = FPR;
      tprs[t] = TPR;
      fprs[t] = FPR;
    }
    auc += trapeziod_area(FPR_pre, 0, TPR_pre, 0);
    this.auc = Math.round(1000*auc)*0.001;
    if(_glm.family == Family.binomial){
      int best = 0;
      for(int i = 1; i < _cms.length; ++i){
        if(Math.max(_cms[i].classErr(0),_cms[i].classErr(1)) < Math.max(_cms[best].classErr(0),_cms[best].classErr(1)))
          best = i;
      }
      best_threshold = best*0.01f;
    }
  }

  private double trapeziod_area(double x1, double x2, double y1, double y2) {
    double base = Math.abs(x1 - x2);
    double havg = 0.5 * (y1 + y2);
    return base * havg;
  }






  public static double[] DEFAULT_THRESHOLDS = new double[] { 0.00, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10,
    0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.20, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29,
    0.30, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.40, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48,
    0.49, 0.50, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.60, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67,
    0.68, 0.69, 0.70, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.80, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86,
    0.87, 0.88, 0.89, 0.90, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00 };


}
