control 'security_groups' do
  impact 0.5
  title 'Ensure No Critical Ports open to 0.0.0.0'
  desc 'https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html'

  aws_security_groups.group_ids.each do |id|
    describe "Security Group - #{id} " do
      subject do
        aws_security_group(group_id: id)
      end
      it { should_not allow_in(port: 22, ipv4_range: '0.0.0.0/0') }
      it { should_not allow_in(port: 1433, ipv4_range: '0.0.0.0/0') }
      it { should_not allow_in(port: 3389, ipv4_range: '0.0.0.0/0') }
      it { should_not allow_in(port: 5432, ipv4_range: '0.0.0.0/0') }
      it { should_not allow_in(port: 3306, ipv4_range: '0.0.0.0/0') }
      it { should_not allow_in(port: 27017, ipv4_range: '0.0.0.0/0') }

    end
  end
end
