import boto3
session = boto3.Session(profile_name='hendricks')

ec2 = session.client('ec2', region_name="us-east-1")

response = ec2.describe_snapshots()

volumes = set()

for s in response['Snapshots']:
    if s['VolumeId'] != 'Vol-90c01d4f':
        volumes.add(s["VolumeId"])

#print(volumes)
#print(len(volumes))

for v in volumes:
    response = ec2.describe_snapshots(Filters=[{'Name': 'volume-id', 'Values': [v]}])
    print(v)
    print(len(response['Snapshots']))

