.PHONY: build
build:
	mass bundle build
	
.PHONY: plan
plan: build
	cd ./src && terraform plan -var-file=./dev.connections.tfvars.json -var-file=./dev.params.tfvars.json

.PHONY: apply
apply: build
	cd ./src && terraform apply -var-file=./dev.connections.tfvars.json -var-file=./dev.params.tfvars.json
