control 'iam_policies' do
  impact 0.5
  title 'Ensure IAM policies utilized PoLP'
  desc 'https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege'

  aws_iam_policies(only_attached: 'true',scope: 'Local').policy_names.each do |policy|
    describe "Attached policy - #{policy} - allows *.*" do
      subject do
        aws_iam_policy(policy_name: policy)
      end
      it { should_not have_statement(Effect: 'Allow', Resource: '*', Action: '*')}
    end
  end
end

