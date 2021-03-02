resource "kubernetes_manifest" "role_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
      "namespace" = "default"
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
          "create",
          "get",
          "list",
          "watch",
          "update",
          "patch",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "argoproj.io",
        ]
        "resources" = [
          "applications",
          "appprojects",
        ]
        "verbs" = [
          "create",
          "get",
          "list",
          "watch",
          "update",
          "delete",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "list",
        ]
      },
    ]
  }
}