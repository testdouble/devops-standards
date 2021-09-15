class Queues:
    def __init__(self, session):
        client = session.client('sqs')
        self.queues = client.list_queues()

    def list_queues(self):
        if len(self.queues['QueueUrls']) > 0:
            print('Existing queues:')
            for queue in self.queues['QueueUrls']:
                print(f'Queue: {queue}')
        else:
            print("No queues found")