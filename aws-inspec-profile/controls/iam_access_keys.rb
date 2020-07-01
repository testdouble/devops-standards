control 'iam_access_keys' do
  impact 0.5
  title 'Ensure access key management meets best practices'
  desc 'https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html'

  aws_iam_access_keys.where(active: true).entries.each do |key|
      describe key.username do
        context key do
          its('last_used_days_ago') { should be <= 90 }
        end
      end
  end

end
