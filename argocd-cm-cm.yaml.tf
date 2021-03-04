resource "kubernetes_manifest" "configmap_argocd_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-cm"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
  }
}
