resource "kubernetes_manifest" "service_argocd_redis" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/name" = "argocd-redis"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-redis"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
	  "protocol" = "TCP"
          "name" = "tcp-redis"
          "port" = 6379
          "targetPort" = 6379
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-redis"
      }
    }
  }
}
