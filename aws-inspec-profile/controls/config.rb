control 'config' do
  impact 1.0
  title 'Ensure AWS Config is setup'
  desc 'https://aws.amazon.com/blogs/mt/aws-config-best-practices/'

  describe aws_config_recorder do
    it { should exist }
    it { should be_recording }
    it { should be_recording_all_global_types }
    it { should be_recording_all_resource_types }
  end

end