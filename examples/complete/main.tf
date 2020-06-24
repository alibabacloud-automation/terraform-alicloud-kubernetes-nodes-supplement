variable "region" {
  default = "cn-beijing"
}

variable "profile" {
  default = "default"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

module "k8s-eip" {
  source = "../.."

  kubernetes_cluster_id = "c5836d24951f149aab24e374ee130****"

  // eip config
  create_eip               = true
  eip_name                 = "test-k8s-eip"
  eip_instance_charge_type = "PostPaid"

  // common bandwidth package config
  create_cbp               = true
  cbp_bandwidth            = 10
  cbp_internet_charge_type = "PayByTraffic"
}