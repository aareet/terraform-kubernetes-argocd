resource "kubernetes_manifest" "rolebinding_argocd_redis" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/name"      = "argocd-redis"
        "app.kubernetes.io/part-of"   = "argocd"
      }
      "name"      = "argocd-redis"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "Role"
      "name"     = "argocd-redis"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-redis"
      },
    ]
  }
}
