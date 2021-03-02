resource "kubernetes_manifest" "configmap_argocd_tls_certs_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "data" = null
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-tls-certs-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-tls-certs-cm"
      "namespace" = "default"
    }
  }
}
