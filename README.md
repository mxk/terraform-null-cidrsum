# Terraform cidrsum module

This module aggregates/summarizes a list of IPv4 CIDR blocks using the most compact equivalent representation. For example, `["0.0.0.0/32", "0.0.0.1/32", "0.0.0.2/31"]` is converted to `["0.0.0.0/30"]`. The implementation matches the behavior of [netaddr.cidr_merge] and [netipx.IPSetBuilder].

[netaddr.cidr_merge]: https://netaddr.readthedocs.io/en/latest/api.html#netaddr.cidr_merge
[netipx.IPSetBuilder]: https://pkg.go.dev/go4.org/netipx#IPSetBuilder
