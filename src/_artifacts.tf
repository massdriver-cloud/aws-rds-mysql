locals {
  data_authentication = {
    username = aws_db_instance.main.username
    password = aws_db_instance.main.password
    hostname = aws_db_instance.main.address
    port     = local.mysql.port
  }
  data_infrastructure = {
    arn = aws_rds_cluster.main.arn
  }

  data_security = {
    groups = {
      mysql = {
        arn      = aws_security_group.main.arn
        port     = local.mysql.port
        protocol = local.mysql.protocol
      }
    }
  }
  rdbms_specs = {
    engine         = "MySQL"
    engine_version = aws_db_instance.main.engine_version
    version        = aws_db_instance.main.engine_version_actual
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "authentication"
  provider_resource_id = aws_db_instance.main.arn
  type                 = "mysql-authentication"
  name                 = "MySQL user credentials: ${aws_db_instance.main.identifier}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = local.data_infrastructure
        authentication = local.data_authentication
        security       = local.data_security
      }
      specs = {
        rdbms = local.rdbms_specs
      }
    }
  )
}
