# Test Double AWS InSpec Profile
Follow profile setup instructions at https://github.com/inspec/inspec-aws
Inspec documentation at https://www.inspec.io/docs
Run all controls
```
inspec exec . -t aws://
```

Run individual controls
```
inspec exec . -t aws:// --controls s3
```
