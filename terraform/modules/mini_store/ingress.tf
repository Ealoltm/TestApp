resource "kubernetes_ingress_v1" "mini_store_ingress" {
  metadata {
    name      = "mini-store-ingress"
    namespace = "default"
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
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "mini-store-service"
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