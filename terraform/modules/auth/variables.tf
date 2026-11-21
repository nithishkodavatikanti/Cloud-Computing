variable "project_name" {
  description = "Project prefix for naming Cognito resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. dev, prod)."
  type        = string
}

variable "aws_region" {
  description = "AWS region used to construct the Cognito issuer and JWKS URLs."
  type        = string
  default     = "eu-central-1"
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
  default     = {}
}
