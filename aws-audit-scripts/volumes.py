import boto3
import configparser

config = configparser.ConfigParser()
config.read('config.ini')
profile = config.get('aws_config','profile')
region = config.get('aws_config','region')
session = boto3.Session(profile_name=profile)

ec2 = session.client('ec2', region_name=region)

response = ec2.describe_volumes()

for r in response['Volumes']:
    if r['State'] == 'available':
        print(r['VolumeId'])


