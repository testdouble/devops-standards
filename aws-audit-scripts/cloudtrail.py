class Trails:
    def __init__(self, session):
        client = session.client('cloudtrail')
        self.trials = client.describe_trails()

    def list_trails(self):
        # Output the bucket names
        if len(self.trials['trailList']) > 0:
            print('Existing trails:')
            for trail in self.trials['trailList']:
                print(f'Name: {trail["Name"]}')
                print(f'Multiregion: {trail["IsMultiRegionTrail"]}')
                print(f'S3 Bucket: {trail["S3BucketName"]}')
                print(f'Log Validation: {trail["LogFileValidationEnabled"]}')
                print(f'CloudWatch Logs ARN: {trail["CloudWatchLogsLogGroupArn"]}')
                print(f'Organization Trail: {trail["IsOrganizationTrail"]}')
        else:
            print("No Trails Found")