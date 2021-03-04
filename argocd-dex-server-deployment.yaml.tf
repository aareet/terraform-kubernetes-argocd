resource "kubernetes_manifest" "deployment_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name"      = "argocd-dex-server"
        "app.kubernetes.io/part-of"   = "argocd"
      }
      "name"      = "argocd-dex-server"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "argocd-dex-server"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/name" = "argocd-dex-server"
          }
        }
        "spec" = {
          "affinity" = {
            "podAntiAffinity" = {
              "preferredDuringSchedulingIgnoredDuringExecution" = [
                {
                  "podAffinityTerm" = {
                    "labelSelector" = {
                      "matchLabels" = {
                        "app.kubernetes.io/part-of" = "argocd"
                      }
                    }
                    "topologyKey" = "kubernetes.io/hostname"
                  }
                  "weight" = 5
                },
              ]
            }
          }
          "containers" = [
            {
              "command" = [
                "/shared/argocd-util",
                "rundex",
              ]
              "image"           = "ghcr.io/dexidp/dex:v2.27.0"
              "imagePullPolicy" = "Always"
              "name"            = "dex"
              "ports" = [
                {
                  "protocol"      = "TCP"
                  "containerPort" = 5556
                },
                {
                  "protocol"      = "TCP"
                  "containerPort" = 5557
                },
                {
                  "protocol"      = "TCP"
                  "containerPort" = 5558
                },
              ]
              "volumeMounts" = [
                {
                  "mountPath" = "/shared"
                  "name"      = "static-files"
                },
              ]
            },
          ]
          "initContainers" = [
            {
              "command" = [
                "cp",
                "-n",
                "/usr/local/bin/argocd-util",
                "/shared",
              ]
              "image"           = "argoproj/argocd:v1.8.6"
              "imagePullPolicy" = "Always"
              "name"            = "copyutil"
              "volumeMounts" = [
                {
                  "mountPath" = "/shared"
                  "name"      = "static-files"
                },
              ]
            },
          ]
          "serviceAccountName" = "argocd-dex-server"
          "volumes" = [
            {
              "emptyDir" = {}
              "name"     = "static-files"
            },
          ]
        }
      }
    }
  }
}
