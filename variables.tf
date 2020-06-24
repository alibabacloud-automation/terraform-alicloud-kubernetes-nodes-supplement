variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}
variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}
variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

###########################
# eip config
###########################
variable "create_eip" {
  description = "Whether to create new EIP and bind it to this Nat gateway. If true, the 'number_of_dnat_eip' or 'number_of_snat_eip' should not be empty."
  type        = bool
  default     = true
}

variable "eip_name" {
  description = "Name to be used on all eip as prefix. Default to 'TF-EIP-for-Nat'. The final default name would be TF-EIP-for-Nat001, TF-EIP-for-Nat002 and so on."
  type        = string
  default     = "tf-module-network-with-nat"
}

variable "eip_bandwidth" {
  description = "Maximum bandwidth to the elastic public network, measured in Mbps (Mega bit per second). If 'create_cbp' value is true, the value is same with 'cbp_bandwidth', this parameter will be ignore."
  type        = number
  default     = 5
}

variable "eip_internet_charge_type" {
  description = "Internet charge type of the EIP, Valid values are 'PayByBandwidth', 'PayByTraffic'. "
  type        = string
  default     = "PayByTraffic"
}

variable "eip_instance_charge_type" {
  description = "Elastic IP instance charge type."
  type        = string
  default     = "PostPaid"
}

variable "eip_period" {
  description = "The duration that you will buy the EIP, in month."
  type        = number
  default     = 1
}

variable "eip_tags" {
  description = "A mapping of tags to assign to the EIP instance resource."
  type        = map(string)
  default     = {}
}

variable "eip_isp" {
  description = "The line type of the Elastic IP instance."
  type        = string
  default     = ""
}

variable "resource_group_id" {
  description = "The Id of resource group which the eip belongs."
  type        = string
  default     = ""
}

#########################
# common bandwodth package
#########################
variable "cbp_bandwidth" {
  description = "The bandwidth of the common bandwidth package, in Mbps."
  type        = number
  default     = 10
}

variable "cbp_internet_charge_type" {
  description = "The billing method of the common bandwidth package. Valid values are 'PayByBandwidth' and 'PayBy95' and 'PayByTraffic'. 'PayBy95' is pay by classic 95th percentile pricing. International Account doesn't supports 'PayByBandwidth' and 'PayBy95'. Default to 'PayByTraffic'."
  type        = string
  default     = "PayByTraffic"
}

variable "cbp_ratio" {
  description = "Ratio of the common bandwidth package."
  type        = string
  default     = 100
}

variable "create_cbp" {
  description = "Whether to create a common bandwidth package."
  type        = bool
  default     = true
}

variable "kubernetes_cluster_id" {
  description = "The id of Kubernetes cluster."
  type        = string
  default     = ""
}