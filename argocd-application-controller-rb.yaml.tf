resource "kubernetes_manifest" "rolebinding_argocd_application_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "application-controller"
        "app.kubernetes.io/name"      = "argocd-application-controller"
        "app.kubernetes.io/part-of"   = "argocd"
      }
      "name"      = "argocd-application-controller"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "Role"
      "name"     = "argocd-application-controller"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-application-controller"
      },
    ]
  }
}
