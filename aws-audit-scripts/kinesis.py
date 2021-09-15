class Streams:
    def __init__(self, session):
        client = session.client('kinesis')
        self.streams = client.list_streams()

    def list_streams(self):
        if len(self.streams['StreamNames']) > 0:
            print('Existing Kinesis Streams:')
            for stream in self.streams['StreamNames']:
                print(f'Name: {stream}')
        else:
            print("No Kinesis streams found")