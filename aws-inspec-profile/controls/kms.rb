control 'kms' do
  impact 1.0
  title 'Ensure Customer Managed Keys are rotated'
  desc 'https://d0.awsstatic.com/whitepapers/aws-kms-best-practices.pdf'

  aws_kms_keys.key_ids.each do |id|
    next unless aws_kms_key(key_id: id).enabled? && !aws_kms_key(key_id: id).managed_by_aws?
    describe "CMK #{id} is rotated" do
      subject do
        aws_kms_key(key_id: id)
      end
      it { should have_rotation_enabled }
    end
  end
  if aws_kms_keys.key_arns.none? { |key| aws_kms_key(key).enabled? && !aws_kms_key(key).managed_by_aws? }
    describe 'Control skipped because no enabled kms keys were found' do
      skip 'This control is skipped since the aws_kms_keys resource returned an empty coustomer managed and enabled kms key list'
    end
  end
end
