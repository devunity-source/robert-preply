########################################
# variables.tf — Input variables
########################################

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-west-1"
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "web-instance"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-000eed181b394b872"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "VPC ID where the instance will be created"
  type        = string
  default     = "vpc-04e228e93657b49de"
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be created"
  type        = string
  default     = "subnet-0b22f1c46e8d0e6e7"
}

variable "key_name" {
  description = "Name of an existing EC2 Key Pair to enable SSH access"
  type        = string
  default     = null
}
