output "this_cluster_node_id" {
  description = "The list ids of the worker nodes."
  value       = module.k8s-eip.this_cluster_node_ids
}

output "this_eip_id" {
  description = "The list ids of the eip."
  value       = module.k8s-eip.this_eip_ids
}

output "this_common_bandwidth_package_id" {
  description = "The id of the common bandwidth package."
  value       = module.k8s-eip.this_common_bandwidth_package_id
}
