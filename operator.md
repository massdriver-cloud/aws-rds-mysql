## AWS RDS MySQL

AWS RDS MySQL is a managed relational database service provided by Amazon Web Services that makes it easy to set up, operate, and scale MySQL deployments in the cloud. It automates time-consuming administration tasks such as hardware provisioning, database setup, patching, and backups.

### Design Decisions

1. **Instance Specifications**:
   - This module supports defining different MySQL instance types, including memory and storage configurations.
   - Security groups are auto-configured for allowing VPC ingress to the RDS instance.

2. **Enhanced Monitoring**:
   - Integration with AWS CloudWatch for enhanced monitoring, including alarms for CPU utilization, disk queue depth, free storage space, freeable memory, and swap usage.
   - IAM roles are created and attached for monitoring permissions.

3. **Security**:
   - The RDS instance is configured to be private by default (not publicly accessible).
   - Storage encryption using KMS is enabled.
   - Enhanced IAM roles support.

4. **Backup**:
   - Automatic backup retention and configuration for automated backups.
   - Final snapshot creation before deletion for data protection (configurable).
   
### Runbook

#### Connectivity Issues

If you can't connect to the RDS MySQL instance, check the security group settings and network configurations.

List security group inbound rules:
```sh
aws ec2 describe-security-groups --group-ids <security_group_id>
```

Check VPC subnets and routing tables:
```sh
aws ec2 describe-route-tables --filters "Name=vpc-id,Values=<VPC_ID>"
```

Use the AWS CLI to verify endpoint accessibility:
```sh
nc -zv <RDS_ENDPOINT> 3306
```

#### High CPU Utilization

High CPU usage can indicate insufficient instance resources or an inefficient query.

Check CloudWatch metrics:
```sh
aws cloudwatch get-metric-statistics --namespace AWS/RDS --metric-name CPUUtilization --dimensions Name=DBInstanceIdentifier,Value=<DB_INSTANCE_IDENTIFIER> --start-time <START_TIME> --end-time <END_TIME> --period 300 --statistics Average
```

Inspect MySQL processes:
```sql
SHOW FULL PROCESSLIST;
```

Analyze slow queries:
```sql
SHOW GLOBAL STATUS LIKE 'Slow_queries';
SHOW FULL PROCESSLIST;
```

Enable and check the slow query log:
```sql
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;
SHOW VARIABLES LIKE 'slow_query_log_file';
```

#### Low Available Storage

When storage space is low, the database may become unresponsive.

Check disk space usage:
```sh
aws cloudwatch get-metric-statistics --namespace AWS/RDS --metric-name FreeStorageSpace --dimensions Name=DBInstanceIdentifier,Value=<DB_INSTANCE_IDENTIFIER> --start-time <START_TIME> --end-time <END_TIME> --period 300 --statistics Average
```

List tables to find large ones:
```sql
SELECT table_schema AS "Database", 
       table_name AS "Table", 
       round(((data_length + index_length) / 1024 / 1024), 2) AS "Size (MB)" 
FROM information_schema.TABLES 
ORDER BY (data_length + index_length) DESC;
```

#### Memory Issues

If the instance is running out of memory, check for processes or queries consuming excessive memory.

Check freeable memory using CloudWatch:
```sh
aws cloudwatch get-metric-statistics --namespace AWS/RDS --metric-name FreeableMemory --dimensions Name=DBInstanceIdentifier,Value=<DB_INSTANCE_IDENTIFIER> --start-time <START_TIME> --end-time <END_TIME> --period 300 --statistics Average
```

Inspect MySQL memory usage:
```sql
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_pages_data';
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_pages_free';
```

Determine the total memory usage:
```sql
SHOW ENGINE INNODB STATUS;
SHOW VARIABLES LIKE 'max_connections';
SHOW GLOBAL STATUS LIKE 'Threads_connected';
SELECT * FROM information_schema.INNODB_BUFFER_POOL_STATS;
```

#### Backup and Restore Issues

Issues with backups or restoring snapshots can be critical.

List RDS snapshots:
```sh
aws rds describe-db-snapshots --db-instance-identifier <DB_INSTANCE_IDENTIFIER>
```

Create a snapshot:
```sh
aws rds create-db-snapshot --db-snapshot-identifier <SNAPSHOT_IDENTIFIER> --db-instance-identifier <DB_INSTANCE_IDENTIFIER>
```

Restore from a snapshot:
```sh
aws rds restore-db-instance-from-db-snapshot --db-instance-identifier <NEW_DB_INSTANCE_IDENTIFIER> --db-snapshot-identifier <SNAPSHOT_IDENTIFIER>
```

