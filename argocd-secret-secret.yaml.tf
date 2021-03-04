resource "kubernetes_manifest" "secret_argocd_secret" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-secret"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-secret"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "type" = "Opaque"
  }
}
