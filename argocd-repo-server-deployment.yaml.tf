resource "kubernetes_manifest" "deployment_argocd_repo_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "repo-server"
        "app.kubernetes.io/name"      = "argocd-repo-server"
        "app.kubernetes.io/part-of"   = "argocd"
      }
      "name"      = "argocd-repo-server"
      "namespace" = kubernetes_manifest.namespace_argocd.object.metadata.name
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "argocd-repo-server"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/name" = "argocd-repo-server"
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
                        "app.kubernetes.io/name" = "argocd-repo-server"
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
          "automountServiceAccountToken" = false
          "containers" = [
            {
              "command" = [
                "uid_entrypoint.sh",
                "argocd-repo-server",
                "--redis",
                "argocd-redis:6379",
              ]
              "image"           = "argoproj/argocd:v1.8.6"
              "imagePullPolicy" = "Always"
              "livenessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/healthz?full=true"
                  "port" = 8084
                }
                "initialDelaySeconds" = 30
                "periodSeconds"       = 5
              }
              "name" = "argocd-repo-server"
              "ports" = [
                {
                  "protocol"      = "TCP"
                  "containerPort" = 8081
                },
                {
                  "protocol"      = "TCP"
                  "containerPort" = 8084
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 8084
                }
                "initialDelaySeconds" = 5
                "periodSeconds"       = 10
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/app/config/ssh"
                  "name"      = "ssh-known-hosts"
                },
                {
                  "mountPath" = "/app/config/tls"
                  "name"      = "tls-certs"
                },
                {
                  "mountPath" = "/app/config/gpg/source"
                  "name"      = "gpg-keys"
                },
                {
                  "mountPath" = "/app/config/gpg/keys"
                  "name"      = "gpg-keyring"
                },
              ]
            },
          ]
          "volumes" = [
            {
              "configMap" = {
                "name" = "argocd-ssh-known-hosts-cm"
              }
              "name" = "ssh-known-hosts"
            },
            {
              "configMap" = {
                "name" = "argocd-tls-certs-cm"
              }
              "name" = "tls-certs"
            },
            {
              "configMap" = {
                "name" = "argocd-gpg-keys-cm"
              }
              "name" = "gpg-keys"
            },
            {
              "emptyDir" = {}
              "name"     = "gpg-keyring"
            },
          ]
        }
      }
    }
  }
}
