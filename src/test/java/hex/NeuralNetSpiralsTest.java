package hex;

import hex.Layer.VecSoftmax;
import hex.Layer.VecsInput;
import hex.NeuralNet.Error;

import java.io.File;

import org.junit.*;

import water.*;
import water.JUnitRunner.Nightly;
import water.deploy.VM;
import water.fvec.Frame;
import water.fvec.Vec;
import water.util.Utils;

@Nightly
@Ignore
public class NeuralNetSpiralsTest extends TestUtil {
  @BeforeClass public static void stall() {
    stall_till_cloudsize(JUnitRunnerDebug.NODES);
  }

  @Test public void run() throws Exception {
    File file = new File(VM.h2oFolder(), "smalldata/neural/two_spiral.data");
    Key key = Key.make(file.getName());
    Frame frame = parseFrame(key, file);
    NeuralNet.reChunk(frame.vecs());
    Vec[] data = Utils.remove(frame.vecs(), frame.vecs().length - 1);
    Vec labels = frame.vecs()[frame.vecs().length - 1];
    VecsInput input = new VecsInput(data, null);
    VecSoftmax output = new VecSoftmax(labels, null);
    Layer[] ls = new Layer[3];
    ls[0] = input;
    ls[1] = new Layer.Tanh(50);
    ls[1].rate = .005f;
    ls[2] = output;
    ls[2].rate = .0005f;
    for( int i = 0; i < ls.length; i++ )
      ls[i].init(ls, i);

//    for( ;; ) {
    //Trainer.Direct trainer = new Trainer.Direct(ls, 1000, null);
    //trainer.run();
    Trainer.MapReduce trainer = new Trainer.MapReduce(ls, 100000, null);
    trainer.start();

//      NeuralNet.Error train = NeuralNet.eval(ls, (int) frame.numRows(), null);
//      Log.info("H2O and Reference equal, train: " + train);
//    }

    long start = System.nanoTime();
    for( ;; ) {
      try {
        Thread.sleep(2000);
      } catch( InterruptedException e ) {
        throw new RuntimeException(e);
      }

      double time = (System.nanoTime() - start) / 1e9;
      long samples = trainer.samples();
      int ps = (int) (samples / time);
      String text = (int) time + "s, " + samples + " samples (" + (ps) + "/s) ";

      Error error = NeuralNet.eval(ls, data, labels, NeuralNet.EVAL_ROW_COUNT, null);
      text += "train: " + error;
      text += ", rates: ";
      for( int i = 1; i < ls.length; i++ )
        text += String.format("%.3g", ls[i].rate(samples)) + ", ";

      System.out.println(text);
    }

//    for( int i = 0; i < ls.length; i++ )
//      ls[i].close();
//    UKV.remove(key);
  }
}
