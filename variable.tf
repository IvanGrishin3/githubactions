variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "staging"
}

variable "aws_infra_account_id" {
  type    = string
  default = "914797210606"
}
