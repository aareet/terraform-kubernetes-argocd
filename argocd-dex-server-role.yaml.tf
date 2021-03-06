resource "kubernetes_manifest" "role_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "Role"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name"      = "argocd-dex-server"
        "app.kubernetes.io/part-of"   = "argocd"
      }
      "name"      = "argocd-dex-server"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
          "configmaps",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
    ]
  }
}
