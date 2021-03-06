resource "kubernetes_manifest" "serviceaccount_argocd_redis" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/name"      = "argocd-redis"
        "app.kubernetes.io/part-of"   = "argocd"
      }
      "name"      = "argocd-redis"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
  }
}
