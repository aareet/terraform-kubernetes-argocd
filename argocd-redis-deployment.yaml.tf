resource "kubernetes_manifest" "deployment_argocd_redis" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/name" = "argocd-redis"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-redis"
      "namespace" = "default"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "argocd-redis"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/name" = "argocd-redis"
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
                        "app.kubernetes.io/name" = "argocd-redis"
                      }
                    }
                    "topologyKey" = "kubernetes.io/hostname"
                  }
                  "weight" = 100
                },
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
              "args" = [
                "--save",
                "",
                "--appendonly",
                "no",
              ]
              "image" = "redis:5.0.10-alpine"
              "imagePullPolicy" = "Always"
              "name" = "redis"
              "ports" = [
                {
		  "protocol" = "TCP"
                  "containerPort" = 6379
                },
              ]
            },
          ]
          "securityContext" = {
            "fsGroup" = 1000
            "runAsGroup" = 1000
            "runAsNonRoot" = true
            "runAsUser" = 1000
          }
          "serviceAccountName" = "argocd-redis"
        }
      }
    }
  }
}
