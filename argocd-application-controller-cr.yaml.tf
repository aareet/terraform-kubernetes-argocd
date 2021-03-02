resource "kubernetes_manifest" "clusterrole_argocd_application_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "application-controller"
        "app.kubernetes.io/name" = "argocd-application-controller"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-application-controller"
    }
    "rules" = [
      {
        "apiGroups" = [
          "*",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "*",
        ]
      },
      {
        "nonResourceURLs" = [
          "*",
        ]
        "verbs" = [
          "*",
        ]
      },
    ]
  }
}
