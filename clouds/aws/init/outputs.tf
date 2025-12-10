output "billing_service_account" {
  value = data.aws_billing_service_account.main
}

output "primary_contact" {
  value = data.aws_account_primary_contact.main.full_name
}

output "account_id" {
  value = data.aws_caller_identity.main.account_id
}