import boto3
session = boto3.Session(profile_name='hendricks')

ec2 = session.client('ec2', region_name="us-east-1")

response = ec2.describe_instances()
volumes = set()
amis = set()
for r in response['Reservations']:
    for i in r['Instances']:
        if i['State']['Name'] == "running":
            print(i['InstanceId'])
            print(i['ImageId'])
            amis.add(i['ImageId'])
            # print(i['Tags'])
            # print(i['StateTransitionReason'])
            # for b in i['BlockDeviceMappings']:
            #     print(b['Ebs']['VolumeId'])
            #     volumes.add(b['Ebs']['VolumeId'])


response = ec2.describe_images()
for r in response['Images']:
    if r['ImageId'] not in amis:
        print("Unused AMI " + r['ImageId'])

# for i in amis:
#     response = ec2.describe_images(Filters=[{'Name': 'image-id', 'Values': [i]}])
#     print(i)
#     for r in response['Images']:
#         if r['Public'] == True:
#             print("PUBLIC")



# for v in volumes:
#     response = ec2.describe_snapshots(Filters=[{'Name': 'volume-id', 'Values': [v]}])
#     print(v)
#     print(len(response['Snapshots']))