terraform-alicloud-kubernetes-nodes-supplement
==============================================

本 Terraform Module 根据 Kubernetes 集群 ID，为集群内的节点实例绑定 EIP，并将 EIP 添加到共享宽带中。

本 Module 支持创建以下资源:

* [EIP](https://www.terraform.io/docs/providers/alicloud/r/eip.html)
* [EIP Association](https://www.terraform.io/docs/providers/alicloud/r/eip_association.html)
* [Common Bandwidth Package](https://www.terraform.io/docs/providers/alicloud/r/common_bandwidth_package.html)
* [Common Bandwidth Package Attachment](https://www.terraform.io/docs/providers/alicloud/r/common_bandwidth_package_attachment.html)

## 用法

传入 Kubernetes nodes 的实例 ID 进行绑定 EIP 并加入共享带宽。
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

传入 Kubernetes Cluster 实例 ID，为集群内的 ECS 实例绑定 EIP 并加入共享带宽。
```hcl
module "k8s-cluster-eip" {
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

## 示例

* [完整示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-kubernetes-nodes-supplement/tree/master/examples/complete)

## 注意事项
本Module从版本v1.3.0开始已经移除掉如下的 provider 的显示设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/kubernetes-nodes-supplement"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.2.0:

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

如果你想对正在使用中的Module升级到 1.3.0 或者更高的版本，那么你可以在模板中显示定义一个系统过Region的provider：
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
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

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

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

参考
----
Apache 2 Licensed. See LICENSE for full details.

许可
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
