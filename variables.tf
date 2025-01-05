variable "cidrs" {
  description = "List of IPv4 CIDR blocks to summarize."
  type        = list(string)
  nullable    = false

  validation {
    condition     = alltrue([for v in var.cidrs : !strcontains(v, ":") && strcontains(v, "/")])
    error_message = "Invalid IPv4 CIDR subnet."
  }
}

variable "max_bits" {
  description = "Maximum CIDR bits to return in the output."
  type        = number
  nullable    = false
  default     = 32
}
