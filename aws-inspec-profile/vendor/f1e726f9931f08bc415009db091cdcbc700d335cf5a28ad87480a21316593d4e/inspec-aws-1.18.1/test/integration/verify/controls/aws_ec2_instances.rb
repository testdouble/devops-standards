aws_default_vpc_id = attribute(:aws_default_vpc_id, value: '', description: 'The AWS region default VPC ID.')
aws_vm_size = attribute(:aws_vm_size, value: '', description: 'The AWS EC2 Instance type.')
aws_instance_id = attribute(:aws_instance_id, value: '', description: 'The AWS EC2 Instance ID.')
aws_iam_profile_name_for_ec2 = attribute(:aws_iam_profile_name_for_ec2, value: '', description: "The AWS EC2 IAM profile name.")
aws_vm_name = attribute(:aws_vm_name, value: '', description: 'The AWS EC2 Instance name.')

title 'Test AWS EC2 Instances in bulk'
control 'aws-ec2-instances-1.0' do

  impact 1.0
  title 'Ensure AWS EC2 plural resource has the correct properties.'

  describe aws_ec2_instances do
    it { should exist }
    its('count') { should be <= 100 }
    its('instance_ids') { should include aws_instance_id }
    its('vpc_ids') { should include aws_default_vpc_id }
    its('instance_types') { should include aws_vm_size }
    its('iam_profiles') { should include aws_iam_profile_name_for_ec2 }
    its('names') { should include aws_vm_name }
  end
  aws_ec2_instances.where(tags: /"Name"=>/).instance_ids.each do |id|
    describe aws_ec2_instance(id) do
      it { should exist }
    end
  end
end