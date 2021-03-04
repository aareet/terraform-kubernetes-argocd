resource "kubernetes_manifest" "rolebinding_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name" = "argocd-dex-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-dex-server"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "argocd-dex-server"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-dex-server"
      },
    ]
  }
}
