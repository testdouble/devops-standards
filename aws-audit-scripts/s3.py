class Buckets:
    def __init__(self, session):
        client = session.client('s3')
        self.buckets = client.list_buckets()

    def count_buckets(self):
        # Output the bucket names
        print('Bucket Count:')
        print(len(self.buckets))

    def list_buckets(self):
        # Output the bucket names
        if len(self.buckets['Buckets']) > 0:
            print('Existing buckets:')
            for bucket in self.buckets['Buckets']:
                print(f'  {bucket["Name"]}')
        else:
            print("No S3 buckets found")

