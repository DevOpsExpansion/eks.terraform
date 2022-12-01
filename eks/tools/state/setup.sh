terraform init
terraform apply -auto-approve
export AWS_PROFILE=sandbox
aws s3 cp terraform.tfstate s3://$(terraform output --raw bucket_id)/setup/terraform.tfstate
aws s3 cp terraform.tfstate.backup s3://$(terraform output --raw bucket_id)/setup/terraform.tfstate.backup