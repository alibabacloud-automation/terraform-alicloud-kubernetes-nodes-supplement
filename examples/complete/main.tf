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

// Bind EIP to cluster node by instance ids and join the Common Bandwidth Package.
module "k8s_node_ids-eip" {
  source = "../.."

  kubernetes_node_ids = ["i-2ze0smzw7rfxi4a9p12m", "i-2ze0smzw7rfxi4a9p12n", "i-2ze0smzw7rfxi4a9p12l"]
  // eip config
  create_eip               = true
  eip_name                 = "test-k8s-eip"
  eip_instance_charge_type = "PostPaid"

  // common bandwidth package config
  create_cbp               = true
  cbp_bandwidth            = 10
  cbp_internet_charge_type = "PayByTraffic"
}

// Bind EIP to cluster node by Kubernetes Cluster id and join the Common Bandwidth Package.
module "k8s_cluster-eip" {
  source = "../.."

  kubernetes_cluster_id      = "c5836d24951f149aab24e374ee130****"
  number_of_kubernetes_nodes = 3

  // eip config
  create_eip               = true
  eip_name                 = "test-k8s-eip"
  eip_instance_charge_type = "PostPaid"

  // common bandwidth package config
  create_cbp               = true
  cbp_bandwidth            = 10
  cbp_internet_charge_type = "PayByTraffic"
}