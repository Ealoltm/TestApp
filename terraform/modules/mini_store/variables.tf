variable "host_name" {
  description = "Ingress hostname for the mini-store app"
  type        = string
  default     = "mini-store.local"
}

variable "app_label" {
  description = "Label selector for the app"
  type        = string
  default     = "mini-store"
}
