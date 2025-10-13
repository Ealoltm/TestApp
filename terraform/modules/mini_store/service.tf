resource "kubernetes_service" "mini_store_service" {
  metadata {
    name      = "mini-store-service"
    namespace = "default"
    labels = {
      app = var.app_label
    }
  }

  spec {
    selector = {
      app = var.app_label
    }

    type = "NodePort"

    port {
      name        = "http"
      port        = 80
      target_port = 8000
      node_port   = 32000
      protocol    = "TCP"
    }
  }
}
