def get_account_id(sts):
    account_id = sts.get_caller_identity()["Account"]
    print(account_id)