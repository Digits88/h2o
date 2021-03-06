import unittest, random, sys
sys.path.extend(['.','..','py'])
import h2o, h2o_cmd, h2o_rf, h2o_hosts, h2o_import as h2i

# make a dict of lists, with some legal choices for each. None means no value.
# assume poker1000 datset

# we can pass ntree thru kwargs if we don't use the "trees" parameter in runRF
# only classes 1-7 in the 55th col
# don't allow None on ntree..causes 50 tree default!
print "Temporarily not using binLimit=1 to 4"
# RFView.html?
# data_key=poker1000.hex&
# model_key=model&ntree=50&
# response_variable=10&
# class_weights=
# &out_of_bag_error_estimate=false
#
# RF.html?
# data_key=poker1000.hex&
# response_variable=10&
# ntree=50&
# stat_type=ENTROPY&
# class_weights=0%3D1.0&
# model_key=model&
# out_of_bag_error_estimate=0&
# features=&
# ignore=&
# sample=67&
# bin_limit=1024&
# depth=2147483647&
# seed=784834182943470027&
# parallel=1&
# exclusive_split_limit=

paramDict = {
    'exclusive_split_limit': [None,1,2,3,4],
    'response_variable': [None,54],
    'class_weights': [None,'1=2','2=2','3=2','4=2','5=2','6=2','7=2'],
    'ntree': [1,3,7,19],
    'model_key': ['model_keyA', '012345', '__hello'],
    'out_of_bag_error_estimate': [None,0,1],
    'stat_type': [None, 'ENTROPY', 'GINI'],
    'depth': [None, 1,10,20,100],
    'bin_limit': [None,5,10,100,1000],
    'parallel': [1],
    'ignore': [None,0,1,2,3,4,5,6,7,8,9],
    'sample': [None,20,40,60,80,90], # don't use 100 if oobe error reporting
    'seed': [None,'0','1','11111','19823134','1231231'],
    'features': [1,3,5,7,9,11,13,17,19,23,37,53],
    'sampling_strategy': [None, 'RANDOM', 'STRATIFIED_LOCAL' ],
    'strata_samples': [
        None,
        "1=5",
        "2=3",
        "1=1,2=1,3=1,4=1,5=1,6=1,7=1",
        "1=99,2=99,3=99,4=99,5=99,6=99,7=99", # 100 seems to cause zero results
        "1=0,2=0,3=0,4=0,5=0,6=0,7=0",
        ]
    }

class Basic(unittest.TestCase):
    def tearDown(self):
        h2o.check_sandbox_for_errors()

    @classmethod
    def setUpClass(cls):
        global SEED, localhost
        # SEED = h2o.setup_random_seed()
        SEED = 7066883810153380318
        localhost = h2o.decide_if_localhost()
        if (localhost):
            h2o.build_cloud(node_count=1, java_heap_GB=10)
        else:
            h2o_hosts.build_cloud_with_hosts(node_count=1, java_heap_GB=10)

    @classmethod
    def tearDownClass(cls):
        h2o.tear_down_cloud()

    def test_rf_params_rand2_7066883810153380318(self):
        csvPathname = 'UCI/UCI-large/covtype/covtype.data'
        for trial in range(10):
            # params is mutable. This is default.
            params = {'ntree': 23, 'parallel': 1, 'features': 7}
            colX = h2o_rf.pickRandRfParams(paramDict, params)
            kwargs = params.copy()
            # adjust timeoutSecs with the number of trees
            timeoutSecs = 30 + ((kwargs['ntree']*20) * max(1,kwargs['features']/15) * (kwargs['parallel'] and 1 or 3))
            parseResult = h2i.import_parse(bucket='datasets', path=csvPathname, schema='put', timeoutSecs=timeoutSecs)
            h2o_cmd.runRF(parseResult=parseResult, timeoutSecs=timeoutSecs, **kwargs)
            print "Trial #", trial, "completed"

if __name__ == '__main__':
    h2o.unit_main()
