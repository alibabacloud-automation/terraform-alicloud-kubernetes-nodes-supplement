provider "alicloud" {
  region = var.region
}

variable "region" {
  default = "cn-zhangjiakou"
}


variable "name" {
  default = "my-first-kubernetes-demo"
}

variable "log_project_name" {
  default = "my-first-kubernetes-sls-demo"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones[0].id
  cpu_core_count       = 2
  memory_size          = 4
  kubernetes_node_role = "Worker"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.1.0.0/21"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.1.1.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
}


resource "alicloud_cs_managed_kubernetes" "default" {
  worker_vswitch_ids   = [alicloud_vswitch.default.id]
  name_prefix          = var.name
  new_nat_gateway      = true
  pod_cidr             = "172.20.0.0/16"
  service_cidr         = "172.21.0.0/20"
  slb_internet_enabled = true
}

resource "alicloud_cs_kubernetes_node_pool" "default" {
  node_pool_name        = var.name
  cluster_id            = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids           = [alicloud_vswitch.default.id]
  password              = "Yourpassword1234"
  desired_size          = 2
  install_cloud_monitor = true
  instance_types        = ["ecs.n4.large"]
  system_disk_category  = "cloud_efficiency"
  system_disk_size      = 40
  data_disks {
    category = "cloud_ssd"
    size     = "100"
  }
}

// Bind EIP to cluster node by Kubernetes Cluster id and join the Common Bandwidth Package.
module "k8s_cluster-eip" {
  source = "../.."

  kubernetes_cluster_id      = alicloud_cs_managed_kubernetes.default.id
  number_of_kubernetes_nodes = 2

  // eip config
  create_eip               = true
  eip_name                 = "test-k8s-eip"
  eip_instance_charge_type = "PayAsYouGo"

  // common bandwidth package config
  create_cbp               = true
  cbp_bandwidth            = 10
  cbp_internet_charge_type = "PayByTraffic"

  depends_on = [alicloud_cs_kubernetes_node_pool.default]
}
