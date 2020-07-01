control 'iam-root-user-check' do
  impact 0.5
  title 'Ensure Iam users meet best practices'
  desc 'https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html'

   describe aws_iam_users.where( has_mfa_enabled: false, has_console_password: true) do
     it { should_not exist }
   end

  describe aws_iam_users.where(has_inline_policies: true) do
    its('usernames') { should be_empty }
  end

  describe aws_iam_users.where(has_attached_policies: true) do
    its('usernames') { should be_empty }
  end
end
