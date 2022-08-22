# aws-rds-mysql

MySQL is the world's most popular open source relational database and Amazon RDS makes it easy to set up, operate, and scale MySQL deployments in the cloud. With Amazon RDS, you can deploy scalable MySQL servers in minutes with cost-efficient and resizable hardware capacity.

## Development

### Enabling Pre-commit

This repo includes Terraform pre-commit hooks.

[Install precommmit](https://pre-commit.com/index.html#installation) on your system.

```shell
git init
pre-commit install
```

Terraform hooks will now be run on each commit.

### GitHub Action for Publishing to Massdriver

A github workflow for publishing has been configured in `.github/workflows/publish.yaml`

### Configuring a bundle

`massdriver.yaml` TBD - walk through of fields & purpose (params, connections, artifacts)

### Building a bundle

Variables files can be generated for your bundle from your `massdriver.yaml` file by running

```shell
mass bundle build
```

Two development `tfvars` files are provided for setting `params` and `connections`:

```shell
cd src
terraform init
terraform plan -var-file=./dev.connections.tfvars.json -var-file=./dev.params.tfvars.json
```

### Developing a bundle

`md_metadata` - naming convention prefix, tags etc

### Misc

#### Other files
* `operator.mdx` TBD
* `schema.stories.json` TBD
