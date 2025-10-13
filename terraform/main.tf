provider "kubernetes" {
  config_path = var.kubeconfig_path
}

# Apply the YAML deployment
resource "kubernetes_manifest" "mini_store_deploy" {
  manifest = yamldecode(file("${path.module}/manifests/deployment.yaml"))
}

# Create the Service + Ingress
module "mini_store" {
  source    = "./modules/mini_store"
  host_name = "mini-store.local"
}
