resource "aws_msk_cluster" "msk" {
  cluster_name = "${var.prefix}-msk"
  # https://docs.aws.amazon.com/msk/latest/developerguide/supported-kafka-versions.html
  kafka_version = "3.8.x"
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type = "kafka.t3.small"
    client_subnets = aws_subnet.subnets[*].id
    security_groups = [aws_security_group.msk.id]
    storage_info {
      ebs_storage_info {
        volume_size = 10
      }
    }
  }

  client_authentication {
    # simple authentication and security layer
    sasl {
      iam = true
    }
    unauthenticated = true
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS_PLAINTEXT"
    }
  }
}