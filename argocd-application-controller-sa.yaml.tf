resource "kubernetes_manifest" "serviceaccount_argocd_application_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "application-controller"
        "app.kubernetes.io/name"      = "argocd-application-controller"
        "app.kubernetes.io/part-of"   = "argocd"
      }
      "name"      = "argocd-application-controller"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
  }
}
