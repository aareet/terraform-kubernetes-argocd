resource "kubernetes_manifest" "service_argocd_repo_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "repo-server"
        "app.kubernetes.io/name" = "argocd-repo-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-repo-server"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "server"
          "port" = 8081
          "protocol" = "TCP"
          "targetPort" = 8081
        },
        {
          "name" = "metrics"
          "port" = 8084
          "protocol" = "TCP"
          "targetPort" = 8084
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-repo-server"
      }
    }
  }
}
