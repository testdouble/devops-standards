attributes = yaml(content: inspec.profile.file('attributes.yml')).params
control 's3' do
  impact 0.5
  title 'Ensure s3 buckets follow best practices'
  desc 'https://docs.aws.amazon.com/AmazonS3/latest/dev/security-best-practices.html'
    aws_s3_buckets.bucket_names.each do |bucket_name|
        if attributes['public_s3_exemptions'].include?(bucket_name)
          describe aws_s3_bucket(bucket_name) do
            skip "s3 bucket - #{bucket_name} is listed in public_s3_exemptions"
          end
        end
    next if attributes['public_s3_exemptions'].include?(bucket_name)

    describe "s3 bucket - #{bucket_name} " do
      subject do
        aws_s3_bucket(bucket_name)
      end
      it { should_not be_public }
    end
    end
end
