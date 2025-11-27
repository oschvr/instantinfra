output "brokers" {
  value = aws_msk_cluster.msk.bootstrap_brokers_sasl_iam
}

output "instance_ip" {
  value = aws_instance.test.public_ip
}