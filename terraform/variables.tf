variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-3"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "pacman"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.32"
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
  default     = "pacman-node-group"
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}
