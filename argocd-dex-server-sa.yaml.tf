resource "kubernetes_manifest" "serviceaccount_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name" = "argocd-dex-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-dex-server"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
  }
}
