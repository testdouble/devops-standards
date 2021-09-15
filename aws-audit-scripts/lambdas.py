class Functions:
    def __init__(self, session):
        client = session.client('lambda')
        self.functions = client.list_functions()

    def list_functions(self):
        if len(self.functions['Functions']) > 0:
            print('Existing Lambdas:')
            for function in self.functions['Functions']:
                print(f'Name: {function["FunctionName"]}')
                print(f'Runtime: {function["Runtime"]}')

        else:
            print("No Lambdas found")


class Applications:
    def __init__(self, session):
        client = session.client('serverlessrepo')
        self.apps = client.list_applications()

    def list_applications(self):
        if len(self.apps['Applications']) > 0:
            print('Existing Serverless Applications:')
            for app in self.apps['Applications']:
                print(f'Id: {function["ApplicationId"]}')

        else:
            print("No Serverless Applications found")
