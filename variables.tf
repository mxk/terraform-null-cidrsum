variable "cidrs" {
  description = "List of IPv4 CIDR blocks to summarize."
  type        = list(string)
  nullable    = false

  validation {
    condition     = alltrue([for v in var.cidrs : !strcontains(v, ":") && length(split("/", v)) == 2])
    error_message = "Invalid IPv4 CIDR subnet."
  }
}
