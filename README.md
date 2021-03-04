A simple module to install ArgoCD into the cluster. This is an HCL translation of https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

This module requires the 0.3.0 version of the kubernetes-alpha provider.

Usage:

```
# main.tf
provider "kubernetes-alpha" {
  config_path = "~/.kube/config" // path to kubeconfig
}

module "argocd" {
  source    = "aareet/argocd/kubernetes"
  namespace = "argocd"
}
```
