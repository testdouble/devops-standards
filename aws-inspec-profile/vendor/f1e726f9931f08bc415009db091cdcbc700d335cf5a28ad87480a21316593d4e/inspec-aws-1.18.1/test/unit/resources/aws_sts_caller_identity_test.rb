require 'aws-sdk-core'
require 'aws_sts_caller_identity'
require 'helper'
require_relative 'mock/aws_sts_caller_identity_mock'

class AwsStsCallerIdentityTest < Minitest::Test

  def setup
    # Given
    @mock = AwsStsCallerIdentityMock.new
    @mock_identity = @mock.identity

  end

  def test_params_not_ok
    assert_raises(ArgumentError) { AwsIamUser.new(this_param: 'not-ok') }
  end

  def test_arn
    # When
    @identity = AwsStsCallerIdentity.new(client_args: { stub_responses: true }, stub_data: @mock.stub_data(false))

    # Then
    assert_equal(@identity.arn, @mock_identity[:arn])
  end

  def test_is_gov_cloud
    # When
    @identity = AwsStsCallerIdentity.new(client_args: { stub_responses: true }, stub_data: @mock.stub_data(true))

    # Then
    assert(@identity.govcloud?)
  end

  def test_arn
    # When
    @identity = AwsStsCallerIdentity.new(client_args: { stub_responses: true }, stub_data: @mock.stub_data(false))

    # Then
    assert(!@identity.govcloud?)
  end

end