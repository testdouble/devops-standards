class Clusters:
    def __init__(self, session):
        client = session.client('ecs')
        self.clusters = client.describe_clusters()

    def list_ecs_clusters(self):
        if len(self.clusters['clusters']) > 0:
            print('Existing ECS Cluster:')
            for cluster in self.clusters['clusters']:
                print(f'Name: {cluster["clusterName"]}')
                print(f'Active Services: {cluster["runningTasksCount"]}')
                print(f'Running Tasks: {cluster["activeServicesCount"]}')
                print(f'Status: {cluster["Status"]}')
        else:
            print("No ECS clusters found")
