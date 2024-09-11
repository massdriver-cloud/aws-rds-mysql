[![Massdriver][logo]][website]

# aws-rds-mysql

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]


AWS RDS for MySQL. Amazon RDS makes it easy to set up, operate, and scale MySQL deployments in the cloud. With Amazon RDS, you can deploy scalable MySQL servers in minutes with cost-efficient and resizable hardware capacity.


---

## Design

For detailed information, check out our [Operator Guide](operator.md) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`backup`** *(object)*
  - **`delete_automated_backups`** *(boolean)*: Specifies whether to remove automated backups immediately after the DB instance is deleted. Default: `True`.
  - **`retention_period`** *(integer)*: The days to retain backups for. Minimum: `0`. Maximum: `35`. Default: `7`.
  - **`skip_final_snapshot`** *(boolean)*: Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. Default: `False`.
- **`database`** *(object)*
  - **`deletion_protection`** *(boolean)*: If the DB instance should have deletion protection enabled. Default: `True`.
  - **`engine_version`** *(string)*: Version of MySQL to use. Must be one of: `['5.7', '8.0']`. Default: `8.0`.
  - **`instance_class`** *(string)*: The instance type of the RDS instance. Default: `db.t3.medium`.
    - **One of**
      - M3 General Purpose Double Extra Large (8 vCPUs, 30 GiB)
      - M3 General Purpose Large (2 vCPUs, 7.5 GiB)
      - M3 General Purpose Medium (1 vCPUs, 3.75 GiB)
      - M3 General Purpose Extra Large (4 vCPUs, 15 GiB)
      - M4 General Purpose Deca Extra Large (40 vCPUs, 160 GiB)
      - M4 General Purpose 16xlarge (64 vCPUs, 256 GiB)
      - M4 General Purpose Double Extra Large (8 vCPUs, 32 GiB)
      - M4 General Purpose Quadruple Extra Large (16 vCPUs, 64 GiB)
      - M4 General Purpose Large (2 vCPUs, 8 GiB)
      - M4 General Purpose Extra Large (4 vCPUs, 16 GiB)
      - M5 12xlarge (48 vCPUs, 192 GiB)
      - M5 16xlarge (64 vCPUs, 256 GiB)
      - M5 24xlarge (96 vCPUs, 384 GiB)
      - M5 Double Extra Large (8 vCPUs, 32 GiB)
      - M5 Quadruple Extra Large (16 vCPUs, 64 GiB)
      - M5 Eight Extra Large (32 vCPUs, 128 GiB)
      - M5 Large (2 vCPUs, 8 GiB)
      - M5 Extra Large (4 vCPUs, 16 GiB)
      - M6G 12xlarge (48 vCPUs, 192 GiB)
      - M6G 16xlarge (64 vCPUs, 256 GiB)
      - M6G Double Extra Large (8 vCPUs, 32 GiB)
      - M6G Quadruple Extra Large (16 vCPUs, 64 GiB)
      - M6G Eight Extra Large (32 vCPUs, 128 GiB)
      - M6G Large (2 vCPUs, 8 GiB)
      - M6G Extra Large (4 vCPUs, 16 GiB)
      - M6I 12xlarge (48 vCPUs, 192 GiB)
      - M6I 16xlarge (64 vCPUs, 256 GiB)
      - M6I 24xlarge (96 vCPUs, 384 GiB)
      - M6I Double Extra Large (8 vCPUs, 32 GiB)
      - M6I 32xlarge (128 vCPUs, 512 GiB)
      - M6I Quadruple Extra Large (16 vCPUs, 64 GiB)
      - M6I Eight Extra Large (32 vCPUs, 128 GiB)
      - M6I Large (2 vCPUs, 8 GiB)
      - M6I Extra Large (4 vCPUs, 16 GiB)
      - R3 Memory Optimized Double Extra Large (8 vCPUs, 61 GiB)
      - R3 Memory Optimized Quadruple Extra Large (16 vCPUs, 122 GiB)
      - R3 Memory Optimized Eight Extra Large (32 vCPUs, 244 GiB)
      - R3 Memory Optimized Large (2 vCPUs, 15.25 GiB)
      - R3 Memory Optimized Extra Large (4 vCPUs, 30.5 GiB)
      - R4 Memory Optimized 16xlarge (64 vCPUs, 488 GiB)
      - R4 Memory Optimized Double Extra Large (8 vCPUs, 61 GiB)
      - R4 Memory Optimized Quadruple Extra Large (16 vCPUs, 122 GiB)
      - R4 Memory Optimized Eight Extra Large (32 vCPUs, 244 GiB)
      - R4 Memory Optimized Large (2 vCPUs, 15.25 GiB)
      - R4 Memory Optimized Extra Large (4 vCPUs, 30.5 GiB)
      - R5 12xlarge (48 vCPUs, 384 GiB)
      - R5 16xlarge (64 vCPUs, 512 GiB)
      - R5 24xlarge (96 vCPUs, 768 GiB)
      - R5 Double Extra Large (8 vCPUs, 64 GiB)
      - R5 Quadruple Extra Large (16 vCPUs, 128 GiB)
      - R5 Eight Extra Large (32 vCPUs, 256 GiB)
      - R5B 12xlarge (48 vCPUs, 384 GiB)
      - R5B 16xlarge (64 vCPUs, 512 GiB)
      - R5B 24xlarge (96 vCPUs, 768 GiB)
      - R5B Double Extra Large (8 vCPUs, 64 GiB)
      - R5B Quadruple Extra Large (16 vCPUs, 128 GiB)
      - R5B Eight Extra Large (32 vCPUs, 256 GiB)
      - R5B Large (2 vCPUs, 16 GiB)
      - R5B Extra Large (4 vCPUs, 32 GiB)
      - R5 Large (2 vCPUs, 16 GiB)
      - R5 Extra Large (4 vCPUs, 32 GiB)
      - R6G 12xlarge (48 vCPUs, 384 GiB)
      - R6G 16xlarge (64 vCPUs, 512 GiB)
      - R6G Double Extra Large (8 vCPUs, 64 GiB)
      - R6G Quadruple Extra Large (16 vCPUs, 128 GiB)
      - R6G Eight Extra Large (32 vCPUs, 256 GiB)
      - R6G Large (2 vCPUs, 16 GiB)
      - R6G Extra Large (4 vCPUs, 32 GiB)
      - R6I 12xlarge (48 vCPUs, 384 GiB)
      - R6I 16xlarge (64 vCPUs, 512 GiB)
      - R6I 24xlarge (96 vCPUs, 768 GiB)
      - R6I Double Extra Large (8 vCPUs, 64 GiB)
      - R6I 32xlarge (128 vCPUs, 1024 GiB)
      - R6I Quadruple Extra Large (16 vCPUs, 128 GiB)
      - R6I Eight Extra Large (32 vCPUs, 256 GiB)
      - R6I Large (2 vCPUs, 16 GiB)
      - R6I Extra Large (4 vCPUs, 32 GiB)
      - T2 General Purpose Double Extra Large (8 vCPUs, 32 GiB)
      - T2 General Purpose Large (2 vCPUs, 8 GiB)
      - T2 General Purpose Medium (2 vCPUs, 4 GiB)
      - T2 General Purpose Micro (1 vCPUs, 1 GiB)
      - T2 General Purpose Small (1 vCPUs, 2 GiB)
      - T2 General Purpose Extra Large (4 vCPUs, 16 GiB)
      - T3 Double Extra Large (8 vCPUs, 32 GiB)
      - T3 Large (2 vCPUs, 8 GiB)
      - T3 Medium (2 vCPUs, 4 GiB)
      - T3 Micro (2 vCPUs, 1 GiB)
      - T3 Small (2 vCPUs, 2 GiB)
      - T3 Extra Large (4 vCPUs, 16 GiB)
      - T4G Double Extra Large (8 vCPUs, 32 GiB)
      - T4G Large (2 vCPUs, 8 GiB)
      - T4G Medium (2 vCPUs, 4 GiB)
      - T4G Micro (2 vCPUs, 1 GiB)
      - T4G Small (2 vCPUs, 2 GiB)
      - T4G Extra Large (4 vCPUs, 16 GiB)
      - X2G 12xlarge (48 vCPUs, 768 GiB)
      - X2G 16xlarge (64 vCPUs, 1024 GiB)
      - X2G Double Extra Large (8 vCPUs, 128 GiB)
      - X2G Quadruple Extra Large (16 vCPUs, 256 GiB)
      - X2G Eight Extra Large (32 vCPUs, 512 GiB)
      - X2G Large (2 vCPUs, 32 GiB)
      - X2G Extra Large (4 vCPUs, 64 GiB)
  - **`parameters`** *(array)*: Default: `[]`.
    - **Items** *(object)*
      - **`apply_method`** *(string)*: Must be one of: `['immediate', 'pending-reboot']`. Default: `immediate`.
      - **`name`** *(string)*
      - **`value`** *(string)*
  - **`username`** *(string)*: Username for the 'root' DB user. Default: `root`.
- **`networking`** *(object)*
  - **`subnet_type`** *(string)*: Deploy the database to internal subnets (cannot reach the internet) or private subnets (internet egress traffic allowed). Must be one of: `['internal', 'private']`. Default: `internal`.
- **`observability`** *(object)*: Advanced logging and monitoring options.
  - **`enabled_cloudwatch_logs_exports`** *(array)*: Enables exporting specific MySQL logs to CloudWatch.
    - **Items** *(string)*
      - **One of**
        - General
        - Slow Query
        - Audit
        - Error
  - **`enhanced_monitoring_interval`** *(integer)*: Monitoring interval for operating system metrics of your DB instance in real time. When you want to see how different processes or threads use the CPU, Enhanced Monitoring metrics are useful. Default: `0`.
    - **One of**
      - Disabled
      - 1 second
      - 5 seconds
      - 10 seconds
      - 15 seconds
      - 30 seconds
      - 60 seconds
  - **`performance_insights_retention_period`** *(integer)*: Performance Insights is a database performance tuning and monitoring feature that helps you quickly assess the load on your database, and determine when and where to take action. Performance Insights allows non-experts to detect performance problems with an easy-to-understand dashboard that visualizes database load. Default: `0`.
    - **One of**
      - Disabled
      - 1 Week
      - 1 Month
      - 3 Months
      - 6 Months
      - 1 Year
      - 2 Years
- **`storage`** *(object)*
  - **`allocated`** *(integer)*: The allocated storage in GiB. Minimum: `100`. Maximum: `65536`. Default: `100`.
  - **`iops`** *(integer)*: The amount of provisioned IOPS. Only applies if `type` is `io1`. Minimum: `1000`.
  - **`max_allocated`** *(integer)*: The max allocated storage in GiB that RDS will autoscale to. Not supported on all instance types. Set to greater than `allocated_storage` to enable. Minimum: `0`. Maximum: `65536`. Default: `0`.
  - **`type`** *(string)*: One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. Default: `gp2`.
    - **One of**
      - SSD
      - Provisioned IOPS
      - Magnetic
## Examples

  ```json
  {
      "__name": "Development (Est. Cost: $51/mo)",
      "backup": {
          "delete_automated_backups": true,
          "retention_period": 1,
          "skip_final_snapshot": true
      },
      "database": {
          "deletion_protection": false,
          "engine_version": "8.0",
          "instance_class": "db.t3.medium",
          "username": "root"
      },
      "networking": {
          "subnet_type": "internal"
      },
      "observability": {
          "enabled_cloudwatch_logs_exports": [
              "slowquery"
          ],
          "enhanced_monitoring_interval": 0,
          "performance_insights_retention_period": 0
      },
      "storage": {
          "allocated": 100,
          "max_allocated": 0,
          "type": "gp2"
      }
  }
  ```

  ```json
  {
      "__name": "Production (Est. Cost: $881/mo)",
      "backup": {
          "delete_automated_backups": false,
          "retention_period": 30,
          "skip_final_snapshot": false
      },
      "database": {
          "deletion_protection": true,
          "engine_version": "8.0",
          "instance_class": "db.r5b.2xlarge",
          "username": "root"
      },
      "networking": {
          "subnet_type": "internal"
      },
      "observability": {
          "enabled_cloudwatch_logs_exports": [
              "audit",
              "error",
              "general",
              "slowquery"
          ],
          "enhanced_monitoring_interval": 30,
          "performance_insights_retention_period": 372
      },
      "storage": {
          "allocated": 100,
          "iops": 3000,
          "max_allocated": 1000,
          "type": "io1"
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`aws_authentication`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`arn`** *(string)*: Amazon Resource Name.

      Examples:
      ```json
      "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
      ```

      ```json
      "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
      ```

    - **`external_id`** *(string)*: An external ID is a piece of data that can be passed to the AssumeRole API of the Security Token Service (STS). You can then use the external ID in the condition element in a role's trust policy, allowing the role to be assumed only when a certain value is present in the external ID.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

- **`network`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`internal_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```


          Examples:
      - **`private_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```


          Examples:
      - **`public_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```


          Examples:
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`authentication`** *(object)*: Authentication parameters for a MySQL database. Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
    - **`authentication`** *(object)*
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific MySQL configuration data.
      - **One of**
        - AWS Infrastructure ARN*object*: Minimal AWS Infrastructure Config. Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - GCP Infrastructure Name*object*: GCP Infrastructure Config For Resources With A Name Not A GRN. Cannot contain additional properties.
          - **`name`** *(string)*: Name Of GCP Resource.

            Examples:
            ```json
            "my-cloud-function"
            ```

            ```json
            "my-sql-instance"
            ```

    - **`security`** *(object)*: TBD.
      - **Any of**
        - AWS Security information*object*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]+$`** *(object)*
              - **`policy_arn`** *(string)*: AWS IAM policy ARN.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

          - **`identity`** *(object)*: For instances where IAM policies must be attached to a role attached to an AWS resource, for instance AWS Eventbridge to Firehose, this attribute should be used to allow the downstream to attach it's policies (Firehose) directly to the IAM role created by the upstream (Eventbridge). It is important to remember that connections in massdriver are one way, this scheme perserves the dependency relationship while allowing bundles to control the lifecycles of resources under it's management. Cannot contain additional properties.
            - **`role_arn`** *(string)*: ARN for this resources IAM Role.

              Examples:
              ```json
              "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
              ```

              ```json
              "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
              ```

          - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
            - **`^[a-z-]+$`** *(object)*
              - **`arn`** *(string)*: Amazon Resource Name.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

              - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
              - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
        - Security*object*: Azure Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Scopes. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]$`** *(object)*
              - **`role`**: Azure Role.

                Examples:
                ```json
                "Storage Blob Data Reader"
                ```

              - **`scope`** *(string)*: Azure IAM Scope.
        - Security*object*: GCP Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Conditions. Cannot contain additional properties.
            - **`^[a-z]+[a-z_]*[a-z]$`** *(object)*
              - **`condition`** *(string)*: GCP IAM Condition.
              - **`role`**: GCP Role.

                Examples:
                ```json
                "roles/owner"
                ```

                ```json
                "roles/redis.editor"
                ```

                ```json
                "roles/storage.objectCreator"
                ```

                ```json
                "roles/storage.legacyObjectReader"
                ```

  - **`specs`** *(object)*: Cannot contain additional properties.
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

    - **`azure`** *(object)*: .
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
    - **`gcp`** *(object)*: .
      - **`project`** *(string)*
      - **`region`** *(string)*: The GCP region to provision resources in.

        Examples:
        ```json
        "us-east1"
        ```

        ```json
        "us-east4"
        ```

        ```json
        "us-west1"
        ```

        ```json
        "us-west2"
        ```

        ```json
        "us-west3"
        ```

        ```json
        "us-west4"
        ```

        ```json
        "us-central1"
        ```

    - **`rdbms`** *(object)*: Common metadata for relational databases.
      - **`engine`** *(string)*: The type of database server.

        Examples:
        ```json
        "postgresql"
        ```

        ```json
        "mysql"
        ```

      - **`engine_version`** *(string)*: The cloud provider's database version.

        Examples:
        ```json
        "5.7.mysql_aurora.2.03.2"
        ```

      - **`version`** *(string)*: The database version. Default: ``.

        Examples:
        ```json
        "12.2"
        ```

        ```json
        "5.7"
        ```


      Examples:
      ```json
      {
          "engine": "postgresql",
          "engine_version": "10.14",
          "version": "10.14"
      }
      ```

      ```json
      {
          "engine": "mysql",
          "engine_version": "5.7.mysql_aurora.2.03.2",
          "version": "5.7"
      }
      ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/aws-rds-mysql/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg
[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=aws-rds-mysql&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=aws-rds-mysql&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=aws-rds-mysql&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=aws-rds-mysql&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=aws-rds-mysql&utm_content=linkedin



[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/aws-rds-mysql.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/aws-rds-mysql/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/aws-rds-mysql.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/aws-rds-mysql/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/aws-rds-mysql.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/aws-rds-mysql/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/aws-rds-mysql.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/aws-rds-mysql/issues
[release_url]: https://github.com/massdriver-cloud/aws-rds-mysql/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/aws-rds-mysql.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/aws-rds-mysql.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/aws-rds-mysql/blob/main/LICENSE


[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=aws-rds-mysql&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=aws-rds-mysql&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
