resource "kubernetes_manifest" "configmap_argocd_gpg_keys_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name"    = "argocd-gpg-keys-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name"      = "argocd-gpg-keys-cm"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
  }
}
