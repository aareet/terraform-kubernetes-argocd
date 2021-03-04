resource "kubernetes_manifest" "service_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 80
          "protocol" = "TCP"
          "targetPort" = 8080
        },
        {
          "name" = "https"
          "port" = 443
          "protocol" = "TCP"
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-server"
      }
    }
  }
}
