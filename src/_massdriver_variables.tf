// Auto-generated variable declarations from massdriver.yaml
variable "aws_authentication" {
  type = object({
    data = object({
      arn         = string
      external_id = optional(string)
    })
    specs = object({
      aws = optional(object({
        region = optional(string)
      }))
    })
  })
}
variable "backup" {
  type = object({
    delete_automated_backups = optional(bool)
    retention_period         = number
    skip_final_snapshot      = optional(bool)
  })
}
variable "database" {
  type = object({
    deletion_protection = optional(bool)
    engine_version      = string
    instance_class      = string
    parameters = optional(list(object({
      apply_method = optional(string)
      name         = string
      value        = string
    })))
    username = string
  })
}
variable "md_metadata" {
  type = object({
    default_tags = object({
      managed-by  = string
      md-manifest = string
      md-package  = string
      md-project  = string
      md-target   = string
    })
    deployment = object({
      id = string
    })
    name_prefix = string
    observability = object({
      alarm_webhook_url = string
    })
    package = object({
      created_at             = string
      deployment_enqueued_at = string
      previous_status        = string
      updated_at             = string
    })
    target = object({
      contact_email = string
    })
  })
}
variable "network" {
  type = object({
    data = object({
      infrastructure = object({
        arn  = string
        cidr = string
        internal_subnets = list(object({
          arn = string
        }))
        private_subnets = list(object({
          arn = string
        }))
        public_subnets = list(object({
          arn = string
        }))
      })
    })
    specs = optional(object({
      aws = optional(object({
        region = optional(string)
      }))
    }))
  })
}
variable "networking" {
  type = object({
    subnet_type = optional(string)
  })
}
variable "observability" {
  type = object({
    enabled_cloudwatch_logs_exports       = optional(list(string))
    enhanced_monitoring_interval          = optional(number)
    performance_insights_retention_period = optional(number)
  })
}
variable "storage" {
  type = object({
    allocated     = number
    iops          = optional(number)
    max_allocated = number
    type          = string
  })
}
