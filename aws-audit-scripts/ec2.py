class Instances:
    def __init__(self, session):
        self.client = session.client('ec2')
        self.response = self.client.describe_instances()
        self.amis = set()

    def list_instances(self):
        if len(self.response['Reservations']) > 0:
            for reservation in self.response['Reservations']:
                print('EC2 instances:')
                for instance in reservation['Instances']:
                    if instance['State']['Name'] == "running":
                        print('Running EC2 instance:')
                        print(f'Identifier: {instance["InstanceId"]}')
                        print(f'InstanceType: {instance["InstanceType"]}')
                        print(f'ImageId: {instance["ImageId"]}')
                        self.amis.add(instance['ImageId'])
        else:
            print("No EC2 Instances Found")

    def list_unused_amis(self):
        #refactor to DRY
        if len(self.amis) > 0:
            response = self.client.describe_images()
            for r in response['Images']:
                if r['ImageId'] not in self.amis:
                    print("Unused AMI " + r['ImageId'])
                else:
                    print("No unused AMIs")
        else:
            for reservation in self.response['Reservations']:
                for instance in reservation['Instances']:
                    print('Running EC2 instances:')
                    if i['State']['Name'] == "running":
                        self.amis.add(instance['ImageId'])
            response = self.client.describe_images()
            for r in response['Images']:
                if r['ImageId'] not in self.amis:
                    print("Unused AMI " + r['ImageId'])
                else:
                    print("No unused AMIs")

    def count_instances(self):
        print("EC2 Instance Count (all states):")
        print(len(self.response['Reservations']))

    def list_unused_security_groups(self):
        sgs = self.client.describe_security_groups()
        all_sgs = set([sg['GroupName'] for sg in sgs['SecurityGroups']])
        # print(all_sgs)
        inssgs = set([sg['GroupName'] for ins in self.response['Reservations'] for sg in ins['Groups']])
        # print(inssgs)
        unused_sgs = all_sgs - inssgs
        for sg in unused_sgs:
            print("Unused security group found: " + sg)

    def days_old(self,date):
        from dateutil.parser import parse
        import datetime
        get_date_obj = parse(date)
        date_obj = get_date_obj.replace(tzinfo=None)
        diff = datetime.datetime.now() - date_obj
        return diff.days

    def list_old_amis(self):
        age = 30
        amis = self.client.describe_images(Owners=[
            'self'
        ])
        for ami in amis['Images']:
            create_date = ami['CreationDate']
            ami_id = ami['ImageId']
            #print(ami['ImageId'], ami['CreationDate'])
            day_old = self.days_old(create_date)
            if day_old > age:
                print("AMI Older than 30 days found -> " + ami_id + " - create_date = " + create_date)
                # deregister the AMI
               # ec2.deregister_image(ImageId=ami_id)

    def list_unused_volumes(self):
        response = self.client.describe_volumes()
        for r in response['Volumes']:
            if r['State'] == 'available':
                print(r['VolumeId'] + " is not in use")

