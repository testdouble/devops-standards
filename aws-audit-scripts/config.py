class Recorders:
    def __init__(self, session):
        client = session.client('config')
        self.recorders = client.describe_configuration_recorders()

    def list_recorders(self):
        # Output the bucket names
        if len(self.recorders['ConfigurationRecorders']) > 0:
            print('Existing recorders:')
            for recorder in self.recorders['ConfigurationRecorders']:
                print(recorder)
                print(f'Name: {recorder["name"]}')
                print(f'All Supported: {recorder["recordingGroup"]["allSupported"]}')
        else:
            print("Config not enabled")