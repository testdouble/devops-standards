control 'iam-root-user-check' do
  impact 0.5
  title 'Ensure root user has MFA and access keys do not exist'
  desc 'https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#lock-away-credentials'
  describe aws_iam_root_user do
    it { should exist }
  end
  describe aws_iam_root_user do
    it { should have_mfa_enabled }
  end
  describe aws_iam_root_user do
    it { should_not have_access_key }
  end
end
