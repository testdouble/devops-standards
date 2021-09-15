class Databases:
    def __init__(self, session):
        client = session.client('rds')
        self.instances = client.describe_db_instances()
        self.clusters = client.describe_db_clusters()

    def list_db_instances(self):
        if len(self.instances['DBInstances']) > 0:
            print('Existing RDS instances:')
            for instance in self.instances['DBInstances']:
                print(f'Identifier: {instance["DBInstanceIdentifier"]}')
                print(f'Engine: {instance["Engine"]}')
                print(f'Engine Version: {instance["EngineVersion"]}')
                print(f'Status: {instance["DBInstanceStatus"]}')
        else:
            print("No RDS Instances Found")

    def list_db_clusters(self):
       if len(self.clusters['DBClusters']) > 0:
           print('Existing RDS Cluster:')
           for cluster in self.clusters['DBClusters']:
               print(f'Identifier: {cluster["DBClusterIdentifier"]}')
               print(f'Engine: {cluster["Engine"]}')
               print(f'Status: {cluster["Status"]}')
       else:
           print("No DB clusters found")