variable "location" {
  description = "The azure region where the resource group should exist"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.location) > 0
    error_message = "location cannot be empty"
  }
}

variable "name" {
  description = "The name which should be used for this resource group"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) > 0
    error_message = "name cannot be empty"
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = null
}
