control 'cloudwatch_alarm' do
  impact 1.0
  title 'Ensure Alerts setup for critical events'
  desc 'https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudwatch-alarms-for-cloudtrail.html'

  aws_cloudtrail_trails.names.each do |name|
    describe "CloudTrail should be setup and logging" do
      subject do
        aws_cloudtrail_trail(trail_name: name)
      end
      it { should exist }
      it { should be_multi_region_trail }
      its('cloud_watch_logs_log_group_arn') { should_not be_nil }
    end

    trail_log_group_name = aws_cloudtrail_trail(trail_name: name).cloud_watch_logs_log_group_arn.scan(/log-group:(.+):/).last.first unless aws_cloudtrail_trail(trail_name: name).cloud_watch_logs_log_group_arn.nil?
    auth_failure_pattern = '{ ($.errorCode = "*UnauthorizedOperation") || ($.errorCode = "AccessDenied*") }'
    api_failure_pattern = '{ ($.errorCode = "*UnauthorizedOperation") || ($.errorCode = "AccessDenied*") }'
    iam_changes_pattern = '{($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)}'
    cloudtrail_changes_pattern = '{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }'
    describe aws_cloudwatch_log_metric_filter(pattern: auth_failure_pattern, log_group_name: trail_log_group_name) do
      it { should exist }
    end

    describe aws_cloudwatch_log_metric_filter(pattern: cloudtrail_changes_pattern, log_group_name: trail_log_group_name) do
      it { should exist }
    end

    describe aws_cloudwatch_log_metric_filter(pattern: api_failure_pattern, log_group_name: trail_log_group_name) do
      it { should exist }
    end

    describe aws_cloudwatch_log_metric_filter(pattern: iam_changes_pattern, log_group_name: trail_log_group_name) do
      it { should exist }
    end
  end
end

