yaml(content: inspec.profile.file('attributes.yml')).params
control 'iam-password-policy-check' do
  impact 0.5
  title 'Ensure Password Policy exists for the account and it follows best practices.'
  desc 'https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#configure-strong-password-policy'

  only_if ('no password policy set') do
    aws_iam_password_policy.exists?
  end

  describe aws_iam_password_policy do
    it { should exist }
  end

  describe aws_iam_password_policy do
    its('expire_passwords?') { should be true }
  end

  describe aws_iam_password_policy do
    it                             { should require_uppercase_characters }
    it                             { should require_lowercase_characters }
    it                             { should require_symbols }
    it                             { should require_numbers }
  end

  describe aws_iam_password_policy do
    its('minimum_password_length') { should be >= password_min_length }
  end

  describe aws_iam_password_policy do
    its('max_password_age_in_days') { should be >= password_max_age }
  end

  describe aws_iam_password_policy do
    it { should prevent_password_reuse }
  end

  describe aws_iam_password_policy do
    its('number_of_passwords_to_remember') { should be >= password_reuse_limit }
  end

  describe aws_iam_password_policy do
    it { should allow_users_to_change_password }
  end

end
