resource "kubernetes_manifest" "serviceaccount_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
      "namespace" = "default"
    }
  }
}
