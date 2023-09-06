terraform {
	required_version = "~> 1.5"

	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 5.12"
		}
	}
}

provider "aws" {
	region = "ca-central-1"

	default_tags {
		tags = {
			environment          = "prod"
			pii                  = false
			terragrunt_base_path = "1Mill/experiment-crystal-lambda"
		}
	}
}

module "lambda" {
	source  = "1Mill/serverless-docker-function/aws"
	version = "~> 3.1"

	docker      = { build = abspath(path.module) }
	environment = {}
	function    = { name = "experimental-crystal-lambda" }
}
