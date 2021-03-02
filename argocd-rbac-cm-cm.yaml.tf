resource "kubernetes_manifest" "configmap_argocd_rbac_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-rbac-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-rbac-cm"
      "namespace" = "default"
    }
  }
}
