import sys
import getopt
import boto3
from ec2 import Instances
from cloudtrail import Trails
from config import Recorders
from rds import Databases
from ecs import Clusters
from lambdas import Functions, Applications
from s3 import Buckets



def main(argv):
    profile = ''
    region = ''
    try:
        opts, args = getopt.getopt(argv, "p:r:h", ["profile=", "region="])
    except getopt.GetoptError:
        print
        'main.py -p <profile> -r <region>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print
            'main.py -p <profile> -r <region>'
            sys.exit()
        elif opt in ("-p", "--profile"):
            profile = arg
        elif opt in ("-r", "--region"):
            region = arg
    session = boto3.Session(profile_name=profile,region_name=region)
    s3 = Buckets(session)
    ec2 = Instances(session)
    rds = Databases(session)
    ecs = Clusters(session)
    lambda_funcs = Functions(session)
    lambda_apps = Applications(session)
    trails = Trails(session)
    recorders = Recorders(session)
    s3.list_buckets()
    ec2.list_instances()
    ec2.list_unused_security_groups()
    ec2.list_old_amis()
    #ec2.list_unused_amis()
    lambda_funcs.list_functions()
    lambda_apps.list_applications()
    ecs.list_ecs_clusters()
    rds.list_db_instances()
    rds.list_db_clusters()
    trails.list_trails()
    recorders.list_recorders()
    #ec2.unused_security_groups(ec2_client)
    #ec2.old_amis(ec2_client)
    #ec2.unused_volumes(ec2_client)
    #sts.get_account_id(sts_client)
    #ec2.list_instances(ec2_client)
    #ec2 = Instances(ec2_client)
    #ec2.count_instances()
    #s3 = Buckets(s3_client)
   # s3.list_buckets()







if __name__ == "__main__":
    main(sys.argv[1:])