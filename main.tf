terraform {
  required_version = ">= 1.9"
}

locals {
  # Normalize and group all CIDRs by prefix length
  groups = { for v in [for v in var.cidrs : cidrsubnet(v, 0, 0)] : split("/", v)[1] => v... }

  # Convert to a list of sets indexed by prefix length
  s = [for i in range(33) : toset(lookup(local.groups, i, []))]

  # Sequentially generate new parent CIDRs when both children exist. Example:
  # 0.0.0.0/32 + 0.0.0.1/32 = 0.0.0.0/31 + 0.0.0.2/31 = 0.0.0.0/30.
  # @formatter:off
  s31 = toset([for k, v in { for v in setunion(local.s[32], toset([])) : cidrsubnet("${trimsuffix(v, "32")}31", 0, 0) => v... } : k if length(v) == 2])
  s30 = toset([for k, v in { for v in setunion(local.s[31], local.s31) : cidrsubnet("${trimsuffix(v, "31")}30", 0, 0) => v... } : k if length(v) == 2])
  s29 = toset([for k, v in { for v in setunion(local.s[30], local.s30) : cidrsubnet("${trimsuffix(v, "30")}29", 0, 0) => v... } : k if length(v) == 2])
  s28 = toset([for k, v in { for v in setunion(local.s[29], local.s29) : cidrsubnet("${trimsuffix(v, "29")}28", 0, 0) => v... } : k if length(v) == 2])
  s27 = toset([for k, v in { for v in setunion(local.s[28], local.s28) : cidrsubnet("${trimsuffix(v, "28")}27", 0, 0) => v... } : k if length(v) == 2])
  s26 = toset([for k, v in { for v in setunion(local.s[27], local.s27) : cidrsubnet("${trimsuffix(v, "27")}26", 0, 0) => v... } : k if length(v) == 2])
  s25 = toset([for k, v in { for v in setunion(local.s[26], local.s26) : cidrsubnet("${trimsuffix(v, "26")}25", 0, 0) => v... } : k if length(v) == 2])
  s24 = toset([for k, v in { for v in setunion(local.s[25], local.s25) : cidrsubnet("${trimsuffix(v, "25")}24", 0, 0) => v... } : k if length(v) == 2])
  s23 = toset([for k, v in { for v in setunion(local.s[24], local.s24) : cidrsubnet("${trimsuffix(v, "24")}23", 0, 0) => v... } : k if length(v) == 2])
  s22 = toset([for k, v in { for v in setunion(local.s[23], local.s23) : cidrsubnet("${trimsuffix(v, "23")}22", 0, 0) => v... } : k if length(v) == 2])
  s21 = toset([for k, v in { for v in setunion(local.s[22], local.s22) : cidrsubnet("${trimsuffix(v, "22")}21", 0, 0) => v... } : k if length(v) == 2])
  s20 = toset([for k, v in { for v in setunion(local.s[21], local.s21) : cidrsubnet("${trimsuffix(v, "21")}20", 0, 0) => v... } : k if length(v) == 2])
  s19 = toset([for k, v in { for v in setunion(local.s[20], local.s20) : cidrsubnet("${trimsuffix(v, "20")}19", 0, 0) => v... } : k if length(v) == 2])
  s18 = toset([for k, v in { for v in setunion(local.s[19], local.s19) : cidrsubnet("${trimsuffix(v, "19")}18", 0, 0) => v... } : k if length(v) == 2])
  s17 = toset([for k, v in { for v in setunion(local.s[18], local.s18) : cidrsubnet("${trimsuffix(v, "18")}17", 0, 0) => v... } : k if length(v) == 2])
  s16 = toset([for k, v in { for v in setunion(local.s[17], local.s17) : cidrsubnet("${trimsuffix(v, "17")}16", 0, 0) => v... } : k if length(v) == 2])
  s15 = toset([for k, v in { for v in setunion(local.s[16], local.s16) : cidrsubnet("${trimsuffix(v, "16")}15", 0, 0) => v... } : k if length(v) == 2])
  s14 = toset([for k, v in { for v in setunion(local.s[15], local.s15) : cidrsubnet("${trimsuffix(v, "15")}14", 0, 0) => v... } : k if length(v) == 2])
  s13 = toset([for k, v in { for v in setunion(local.s[14], local.s14) : cidrsubnet("${trimsuffix(v, "14")}13", 0, 0) => v... } : k if length(v) == 2])
  s12 = toset([for k, v in { for v in setunion(local.s[13], local.s13) : cidrsubnet("${trimsuffix(v, "13")}12", 0, 0) => v... } : k if length(v) == 2])
  s11 = toset([for k, v in { for v in setunion(local.s[12], local.s12) : cidrsubnet("${trimsuffix(v, "12")}11", 0, 0) => v... } : k if length(v) == 2])
  s10 = toset([for k, v in { for v in setunion(local.s[11], local.s11) : cidrsubnet("${trimsuffix(v, "11")}10", 0, 0) => v... } : k if length(v) == 2])
  s09 = toset([for k, v in { for v in setunion(local.s[10], local.s10) : cidrsubnet("${trimsuffix(v, "10")}09", 0, 0) => v... } : k if length(v) == 2])
  s08 = toset([for k, v in { for v in setunion(local.s[09], local.s09) : cidrsubnet("${trimsuffix(v, "/9")}/8", 0, 0) => v... } : k if length(v) == 2])
  s07 = toset([for k, v in { for v in setunion(local.s[08], local.s08) : cidrsubnet("${trimsuffix(v, "/8")}/7", 0, 0) => v... } : k if length(v) == 2])
  s06 = toset([for k, v in { for v in setunion(local.s[07], local.s07) : cidrsubnet("${trimsuffix(v, "/7")}/6", 0, 0) => v... } : k if length(v) == 2])
  s05 = toset([for k, v in { for v in setunion(local.s[06], local.s06) : cidrsubnet("${trimsuffix(v, "/6")}/5", 0, 0) => v... } : k if length(v) == 2])
  s04 = toset([for k, v in { for v in setunion(local.s[05], local.s05) : cidrsubnet("${trimsuffix(v, "/5")}/4", 0, 0) => v... } : k if length(v) == 2])
  s03 = toset([for k, v in { for v in setunion(local.s[04], local.s04) : cidrsubnet("${trimsuffix(v, "/4")}/3", 0, 0) => v... } : k if length(v) == 2])
  s02 = toset([for k, v in { for v in setunion(local.s[03], local.s03) : cidrsubnet("${trimsuffix(v, "/3")}/2", 0, 0) => v... } : k if length(v) == 2])
  s01 = toset([for k, v in { for v in setunion(local.s[02], local.s02) : cidrsubnet("${trimsuffix(v, "/2")}/1", 0, 0) => v... } : k if length(v) == 2])
  s00 = toset([for k, v in { for v in setunion(local.s[01], local.s01) : cidrsubnet("${trimsuffix(v, "/1")}/0", 0, 0) => v... } : k if length(v) == 2])
  # @formatter:on

  # Combine original and new CIDRs, and convert to a list to avoid sorting
  all = tolist(setunion(
    local.s00, local.s01, local.s02, local.s03, local.s04, local.s05, local.s06, local.s07,
    local.s08, local.s09, local.s10, local.s11, local.s12, local.s13, local.s14, local.s15,
    local.s16, local.s17, local.s18, local.s19, local.s20, local.s21, local.s22, local.s23,
    local.s24, local.s25, local.s26, local.s27, local.s28, local.s29, local.s30, local.s31,
    local.s...
  ))

  # Generate a list of parents (shorter prefixes) for each CIDR
  parents = {
    for v in local.all : v =>
    [for p in formatlist("%s/%d", split("/", v)[0], range(split("/", v)[1])) : cidrsubnet(p, 0, 0)]
  }

  # Filter out CIDRs that are covered by a shorter prefix
  sum = tolist([for k, v in local.parents : k if !anytrue([for p in v : can(local.parents[p])])])
}
