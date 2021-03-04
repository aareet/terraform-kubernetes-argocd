resource "kubernetes_manifest" "rolebinding_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "argocd-server"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-server"
      },
    ]
  }
}
