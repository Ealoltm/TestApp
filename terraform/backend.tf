terraform {
  backend "kubernetes" {
    secret_suffix     = "local-tfstate"
    namespace         = "terraform"
    in_cluster_config = false
    config_path       = "C:/Users/ealol/.kube/config"
  }
}
