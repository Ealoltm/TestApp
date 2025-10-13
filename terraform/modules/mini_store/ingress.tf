resource "kubernetes_ingress_v1" "mini_store_ingress" {
  metadata {
    name = "mini-store-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      host = var.host_name

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.mini_store.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
