control 'iam_aws_support_role' do
  impact 0.5
  title 'Ensure AWS Support Role has been assigned'
  desc 'https://docs.aws.amazon.com/awssupport/latest/user/getting-started.html#accessing-support'

  describe aws_iam_policy(policy_name: 'AWSSupportAccess') do
    it { should be_attached }
  end
end

