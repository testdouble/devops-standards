# AWS Prowler Report

This is our PDF report based on the [CIS Amazon Web Services Benchmarks](https://www.cisecurity.org/benchmark/amazon_web_services) using [Prowler](https://github.com/toniblyx/prowler)

We give this to our clients as an initial part of DevOps assessment.

## Usage

You will need CLI access to a user or role in AWS with these IAM policies attached:

```
arn:aws:iam::aws:policy/SecurityAudit
arn:aws:iam::aws:policy/job-function/ViewOnlyAccess
```

You will also need some env vars configured:

```sh
export AWS_ACCESS_KEY_ID="ASXXXXXXX"
export AWS_SECRET_ACCESS_KEY="XXXXXXXXX"
export AWS_SESSION_TOKEN="XXXXXXXXX" # may not be required if using an IAM user
```

Check `~/.aws/credentials` for these values.

```sh
git clone git@github.com:testdouble/devops-standards.git
cd devops-standards/aws-prowler-report
```

### Generate JSON Report from Prowler

```sh
docker pull toniblyx/prowler
docker run -it --rm --name prowler -v $(pwd)/output:/prowler/output --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --env AWS_SESSION_TOKEN toniblyx/prowler -g cislevel2 -M json
```

This takes a while.... ~30m-1h. DO NOT close the lid of your laptop.

This outputs a JSON file to `./output` to be used in the next step.

### Convert the Report to HTML and then render to PDF

You will need node installed with the version specified in `.tool-versions`

```sh
npm i
node ./index.js -f ./output/prowler-output-<blahblah>.json -o <path-to-output-file>.pdf -c "<customer-name>"
```

Check every page of the PDF to make sure it looks in order. 

## Troubleshooting

If you are having trouble, ask for help in #dev-ops.