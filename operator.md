## AWS RDS MySQL

AWS RDS MySQL is a managed relational database service provided by Amazon Web Services. It simplifies database administration tasks such as scaling, patching, and backups, allowing you to focus on optimizing your database configuration and performance. This module specifically configures and manages MySQL instances within AWS RDS, ensuring robust database performance and security.

### Design Decisions

1. **Modular Approach**: Individual modules for each database type to keep configurations specific and manageable.
2. **Security**: MySQL instances are created within a VPC with restricted security groups and encrypted at rest using AWS KMS.
3. **Scalability**: Provides configurations for auto-scaling storage and enabling performance insights to monitor and optimize performance.
4. **Observability**: Integrated with AWS CloudWatch for monitoring key metrics and setting up alarms for CPU, memory, disk space, and swap usage.
5. **High Availability**: Supports multi-AZ deployments for high availability and failover support.
6. **Configuration Management**: Allows users to set specific database parameters through a flexible and dynamic parameter group configuration.

### Runbook

#### Connection Issues

Difficulty connecting to the MySQL instance

Run the following AWS CLI command to get the endpoint and verify the connection details:

```sh
aws rds describe-db-instances --db-instance-identifier <your-db-instance-identifier>
```
Check for the `Endpoint.Address` field in the output:
- Ensure the MySQL client is using the correct endpoint, port, username, and password.
- Verify the security group rules allow traffic from your client’s IP address.

#### High CPU Utilization

MySQL instance exhibiting high CPU utilization

Check MySQL process list for intensive queries:

```sh
mysql -h <endpoint> -P <port> -u <username> -p
SHOW PROCESSLIST;
```
Look for queries that might be consuming high CPU and optimize or terminate them as necessary.

#### Insufficient Storage

Disk space running low on your MySQL instance

Check available storage:

```sh
aws rds describe-db-instances --db-instance-identifier <your-db-instance-identifier>
```
Verify the `AllocatedStorage` against the `MaxAllocatedStorage`. Consider resizing the storage if necessary.

#### Memory Usage Spike

High memory usage and out of memory errors

1. Check for status information:
    ```sh
    mysql -h <endpoint> -P <port> -u <username> -p
    SHOW STATUS LIKE 'Innodb_buffer_pool%';
    ```
   Review for `Innodb_buffer_pool_reads` and `Innodb_buffer_pool_read_requests`, indicative of memory issues in InnoDB.

2. Check the AWS CloudWatch metrics for `FreeableMemory`:
    ```sh
    aws cloudwatch get-metric-statistics \
      --metric-name FreeableMemory \
      --namespace AWS/RDS \
      --statistics Average \
      --dimensions Name=DBInstanceIdentifier,Value=<your-db-instance-identifier> \
      --start-time <start-time> --end-time <end-time> --period 300
    ```

#### Slow Query Performance

Queries taking longer time to execute than usual

Enable and check MySQL slow query log:

```sh
aws rds modify-db-instance --db-instance-identifier <your-db-instance-identifier> --enable-logging
```

Query the slow query log:

```sh
mysql -h <endpoint> -P <port> -u <username> -p
SHOW VARIABLES LIKE 'slow_query_log';
SHOW VARIABLES LIKE 'long_query_time';
```

Adjust the `long_query_time` parameter to capture more queries if needed. Consider optimizing the detected slow queries.

#### Backup and Restore

Issues with automated backups or need for manual restoration

1. Check the status of automated backups:
    ```sh
    aws rds describe-db-snapshots --db-instance-identifier <your-db-instance-identifier>
    ```
   Ensure that the expected snapshots are present.

2. To manually create a snapshot:
    ```sh
    aws rds create-db-snapshot --db-snapshot-identifier <your-snapshot-identifier> --db-instance-identifier <your-db-instance-identifier>
    ```

3. To restore from a snapshot:
    ```sh
    aws rds restore-db-instance-from-db-snapshot --db-instance-identifier <new-db-instance-identifier> --db-snapshot-identifier <your-snapshot-identifier>
    ```

Use these steps to address common issues and efficiently manage your AWS RDS MySQL instances.

