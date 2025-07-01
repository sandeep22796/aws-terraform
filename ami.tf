variable "ami_linux" {
  description = "AMI ID for Linux instances"
  type        = string
  default     = "ami-05fcfb9614772f051" # Example AMI ID, replace with a valid one for your region
  
}

variable "ami_windows" {
  description = "AMI ID for Windows instances"
  type        = string
  default     = "ami-01998fe5b868df6e3" # Example AMI ID, replace with a valid one for your region
  
}