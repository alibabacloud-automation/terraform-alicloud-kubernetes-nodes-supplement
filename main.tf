provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/k8s-eip-sg"
}

data "alicloud_instances" "ecs" {
  name_regex = "worker-k8s-for-cs-${var.kubernetes_cluster_id}"
}

resource "alicloud_eip" "eip" {
  count = var.create_eip ? length(data.alicloud_instances.ecs.ids) : 0

  name                 = length(data.alicloud_instances.ecs.ids) > 1 ? format("%s%03d", var.eip_name, count.index + 1) : var.eip_name
  bandwidth            = var.create_cbp ? var.cbp_bandwidth : var.eip_bandwidth
  internet_charge_type = var.eip_internet_charge_type
  instance_charge_type = var.eip_instance_charge_type
  period               = var.eip_period
  isp                  = var.eip_isp
  resource_group_id    = var.resource_group_id
  tags = merge(
    {
      Name = length(data.alicloud_instances.ecs.ids) > 1 ? format("%s%03d", var.eip_name, count.index + 1) : var.eip_name
    },
    var.eip_tags,
  )
}

resource "alicloud_eip_association" "eip" {
  count         = length(data.alicloud_instances.ecs.ids)
  allocation_id = alicloud_eip.eip.*.id[count.index]
  instance_id   = data.alicloud_instances.ecs.ids[count.index]
  depends_on    = [alicloud_eip.eip]

}

resource "alicloud_common_bandwidth_package" "cbp" {
  count                = var.create_cbp ? 1 : 0
  bandwidth            = var.cbp_bandwidth
  name                 = "cbp-k8s"
  internet_charge_type = var.cbp_internet_charge_type
  ratio                = var.cbp_ratio
  depends_on           = [alicloud_eip.eip]

}

resource "alicloud_common_bandwidth_package_attachment" "cbpa" {
  count                = length(data.alicloud_instances.ecs.ids) > 0 ? length(data.alicloud_instances.ecs.ids) : 0
  bandwidth_package_id = alicloud_common_bandwidth_package.cbp.0.id
  instance_id          = alicloud_eip.eip.*.id[count.index]
  depends_on           = [alicloud_eip_association.eip]
}