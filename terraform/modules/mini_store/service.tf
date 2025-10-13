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

    port {
      port        = 80
      target_port = 8000
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }
}
