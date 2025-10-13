resource "kubernetes_service" "mini_store" {
  metadata {
    name = "mini-store-service"
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
    }

    type = "ClusterIP"
  }
}
