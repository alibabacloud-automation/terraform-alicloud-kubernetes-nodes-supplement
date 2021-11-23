# terraform-alicloud-kubernetes-nodes-supplement
Terraform Module for attaching more resources, like eips and so on, to kubernetes nodes on Alibaba Cloud.

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-kubernetes-nodes-supplement/blob/master/README-CN.md)

These types of resources are supported:

* [EIP](https://www.terraform.io/docs/providers/alicloud/r/eip.html)
* [EIP Association](https://www.terraform.io/docs/providers/alicloud/r/eip_association.html)
* [Common Bandwidth Package](https://www.terraform.io/docs/providers/alicloud/r/common_bandwidth_package.html)
* [Common Bandwidth Package Attachment](https://www.terraform.io/docs/providers/alicloud/r/common_bandwidth_package_attachment.html)

## Usage

Bind EIP to cluster node by instance ids and join the Common Bandwidth Package.
```hcl
module "k8s_node_ids-eip" {
  source                   = "terraform-alicloud-modules/kubernetes-nodes-supplement/alicloud"

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
From the version v1.3.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/kubernetes-nodes-supplement"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.2.0:

```hcl
module "k8s_node_ids-eip" {
  source     = "terraform-alicloud-modules/kubernetes-nodes-supplement/alicloud"
  version    = "1.2.0"
  region     = "cn-beijing"
  profile    = "Your-Profile-Name"
  create_eip = true
  eip_name   = "test-k8s-eip"
  // ...
}
```

If you want to upgrade the module to 1.3.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
}
module "k8s_node_ids-eip" {
  source     = "terraform-alicloud-modules/kubernetes-nodes-supplement/alicloud"
  create_eip = true
  eip_name   = "test-k8s-eip"
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
  alias   = "bj"
}
module "k8s_node_ids-eip" {
  source     = "terraform-alicloud-modules/kubernetes-nodes-supplement/alicloud"
  providers         = {
    alicloud = alicloud.bj
  }
  create_eip = true
  eip_name   = "test-k8s-eip"
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
