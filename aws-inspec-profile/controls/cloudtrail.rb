control 'cloudtrail' do
  impact 1.0
  title 'Ensure CloudTrail is setup'
  desc 'https://docs.aws.amazon.com/awscloudtrail/latest/userguide/best-practices-security.html'

  describe aws_cloudtrail_trails do
    it { should exist }
  end
  aws_cloudtrail_trails.trail_arns.each do |trail|
    bucket_name = aws_cloudtrail_trail(trail).s3_bucket_name
    describe aws_cloudtrail_trail(trail) do
      it { should be_multi_region_trail }
      it { should be_encrypted }
      it { should be_log_file_validation_enabled }
      its('cloud_watch_logs_log_group_arn') { should_not be_nil }
    end

    describe aws_s3_bucket(bucket_name) do
      it { should_not be_public }
    end
  end
end