resource "kubernetes_manifest" "role_argocd_application_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "application-controller"
        "app.kubernetes.io/name" = "argocd-application-controller"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-application-controller"
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
          "patch",
          "delete",
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
