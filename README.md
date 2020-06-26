# terraform-alicloud-kubernetes-nodes-supplement
Terraform Module for attaching more resources, like eips and so on, to kubernetes nodes on Alibaba Cloud.

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-kubernetes-nodes-supplement/blob/master/README-CN.md)

These types of resources are supported:

* [EIP](https://www.terraform.io/docs/providers/alicloud/r/eip.html)
* [EIP Association](https://www.terraform.io/docs/providers/alicloud/r/eip_association.html)
* [Common Bandwidth Package](https://www.terraform.io/docs/providers/alicloud/r/common_bandwidth_package.html)
* [Common Bandwidth Package Attachment](https://www.terraform.io/docs/providers/alicloud/r/common_bandwidth_package_attachment.html)


## Terraform versions

The Module requires Terraform 0.12 and Terraform Provider AliCloud 1.56.0+.

## Usage

Bind EIP to cluster node by instance ids and join the Common Bandwidth Package.
```hcl
module "k8s_node_ids-eip" {
  source                   = "terraform-alicloud-modules/kubernetes-nodes-supplement/alicloud"
  region                   = "cn-beijing"
  profile                  = "Your-Profile-Name"

  kubernetes_node_ids      = ["i-2ze0smzw7rfxi4a9****", "i-2ze0smzw7rfxi4a9****", "i-2ze0smzw7rfxi4a9****"]
  // eip config
  create_eip               = true
  eip_name                 = "test-k8s-eip"
  eip_instance_charge_type = "PostPaid"

  // common bandwidth package config
  create_cbp               = true
  cbp_bandwidth            = 10
  cbp_internet_charge_type = "PayByTraffic"
}
```

Bind EIP to cluster node by Kubernetes Cluster id and join the Common Bandwidth Package.
```hcl
module "k8s_cluster_id-eip" {
  source                   = "terraform-alicloud-modules/kubernetes-nodes-supplement/alicloud"
  region                   = "cn-beijing"
  profile                  = "Your-Profile-Name"

  cluster_id                 = "c5836d24951f149aab24e374ee130****"
  number_of_kubernetes_nodes = 3

  // eip config
  eip_name                 = "test-k8s-eip"
  eip_bandwidth            = 10
  eip_instance_charge_type = "PostPaid"

  // common bandwidth package config
  cbp_bandwidth = 10
  cbp_internet_charge_type = "PayByTraffic"
}
```

## Examples

* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-kubernetes-nodes-supplement/tree/master/examples/complete)

## Notes
* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com).

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
