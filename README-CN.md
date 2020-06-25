terraform-alicloud-kubernetes-nodes-supplement
==============================================

本 Terraform Module 根据 Kubernetes 集群 ID，为集群内的节点实例绑定 EIP，并将 EIP 添加到共享宽带中。

本 Module 支持创建以下资源:

* [EIP](https://www.terraform.io/docs/providers/alicloud/r/eip.html)
* [EIP Association](https://www.terraform.io/docs/providers/alicloud/r/eip_association.html)
* [Common Bandwidth Package](https://www.terraform.io/docs/providers/alicloud/r/common_bandwidth_package.html)
* [Common Bandwidth Package Attachment](https://www.terraform.io/docs/providers/alicloud/r/common_bandwidth_package_attachment.html)

## Terraform 版本

本模板要求使用版本 Terraform 0.12 和 阿里云 Provider 1.56.0+。

## 用法

```hcl
module "k8s-cluster-eip" {
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

## 示例

* [完整示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-kubernetes-nodes-supplement/tree/master/examples/complete)

## 注意事项

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file` 中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置。

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com).

参考
----
Apache 2 Licensed. See LICENSE for full details.

许可
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
