class Secrets:
    def __init__(self, session):
        client = session.client('secretsmanager')
        self.secrets = client.list_secrets()

    def list_secrets(self):
        if len(self.secrets['SecretList']) > 0:
            print('Existing Secrets:')
            for secret in self.secrets['SecretList']:
                print(f'Name: {secret["Name"]}')
        else:
            print("No secrets found")