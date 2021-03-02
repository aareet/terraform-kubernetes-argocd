resource "kubernetes_manifest" "customresourcedefinition_applications_argoproj_io" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1beta1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "applications.argoproj.io"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "applications.argoproj.io"
    }
    "spec" = {
      "additionalPrinterColumns" = [
        {
          "JSONPath" = ".status.sync.status"
          "name" = "Sync Status"
          "type" = "string"
        },
        {
          "JSONPath" = ".status.health.status"
          "name" = "Health Status"
          "type" = "string"
        },
        {
          "JSONPath" = ".status.sync.revision"
          "name" = "Revision"
          "priority" = 10
          "type" = "string"
        },
      ]
      "group" = "argoproj.io"
      "names" = {
        "kind" = "Application"
        "listKind" = "ApplicationList"
        "plural" = "applications"
        "shortNames" = [
          "app",
          "apps",
        ]
        "singular" = "application"
      }
      "scope" = "Namespaced"
      "subresources" = {}
      "validation" = {
        "openAPIV3Schema" = {
          "description" = "Application is a definition of Application resource."
          "properties" = {
            "apiVersion" = {
              "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
              "type" = "string"
            }
            "kind" = {
              "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
              "type" = "string"
            }
            "metadata" = {
              "type" = "object"
            }
            "operation" = {
              "description" = "Operation contains requested operation parameters."
              "properties" = {
                "info" = {
                  "items" = {
                    "properties" = {
                      "name" = {
                        "type" = "string"
                      }
                      "value" = {
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "name",
                      "value",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "initiatedBy" = {
                  "description" = "OperationInitiator holds information about the operation initiator"
                  "properties" = {
                    "automated" = {
                      "description" = "Automated is set to true if operation was initiated automatically by the application controller."
                      "type" = "boolean"
                    }
                    "username" = {
                      "description" = "Name of a user who started operation."
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
                "retry" = {
                  "description" = "Retry controls failed sync retry behavior"
                  "properties" = {
                    "backoff" = {
                      "description" = "Backoff is a backoff strategy"
                      "properties" = {
                        "duration" = {
                          "description" = "Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. \"2m\", \"1h\")"
                          "type" = "string"
                        }
                        "factor" = {
                          "description" = "Factor is a factor to multiply the base duration after each failed retry"
                          "format" = "int64"
                          "type" = "integer"
                        }
                        "maxDuration" = {
                          "description" = "MaxDuration is the maximum amount of time allowed for the backoff strategy"
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "limit" = {
                      "description" = "Limit is the maximum number of attempts when retrying a container"
                      "format" = "int64"
                      "type" = "integer"
                    }
                  }
                  "type" = "object"
                }
                "sync" = {
                  "description" = "SyncOperation contains sync operation details."
                  "properties" = {
                    "dryRun" = {
                      "description" = "DryRun will perform a `kubectl apply --dry-run` without actually performing the sync"
                      "type" = "boolean"
                    }
                    "manifests" = {
                      "description" = "Manifests is an optional field that overrides sync source with a local directory for development"
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "prune" = {
                      "description" = "Prune deletes resources that are no longer tracked in git"
                      "type" = "boolean"
                    }
                    "resources" = {
                      "description" = "Resources describes which resources to sync"
                      "items" = {
                        "description" = "SyncOperationResource contains resources to sync."
                        "properties" = {
                          "group" = {
                            "type" = "string"
                          }
                          "kind" = {
                            "type" = "string"
                          }
                          "name" = {
                            "type" = "string"
                          }
                          "namespace" = {
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "kind",
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "revision" = {
                      "description" = "Revision is the revision in which to sync the application to. If omitted, will use the revision specified in app spec."
                      "type" = "string"
                    }
                    "source" = {
                      "description" = "Source overrides the source definition set in the application. This is typically set in a Rollback operation and nil during a Sync operation"
                      "properties" = {
                        "chart" = {
                          "description" = "Chart is a Helm chart name"
                          "type" = "string"
                        }
                        "directory" = {
                          "description" = "Directory holds path/directory specific options"
                          "properties" = {
                            "exclude" = {
                              "type" = "string"
                            }
                            "jsonnet" = {
                              "description" = "ApplicationSourceJsonnet holds jsonnet specific options"
                              "properties" = {
                                "extVars" = {
                                  "description" = "ExtVars is a list of Jsonnet External Variables"
                                  "items" = {
                                    "description" = "JsonnetVar is a jsonnet variable"
                                    "properties" = {
                                      "code" = {
                                        "type" = "boolean"
                                      }
                                      "name" = {
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "name",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "libs" = {
                                  "description" = "Additional library search dirs"
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "tlas" = {
                                  "description" = "TLAS is a list of Jsonnet Top-level Arguments"
                                  "items" = {
                                    "description" = "JsonnetVar is a jsonnet variable"
                                    "properties" = {
                                      "code" = {
                                        "type" = "boolean"
                                      }
                                      "name" = {
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "name",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                              }
                              "type" = "object"
                            }
                            "recurse" = {
                              "type" = "boolean"
                            }
                          }
                          "type" = "object"
                        }
                        "helm" = {
                          "description" = "Helm holds helm specific options"
                          "properties" = {
                            "fileParameters" = {
                              "description" = "FileParameters are file parameters to the helm template"
                              "items" = {
                                "description" = "HelmFileParameter is a file parameter to a helm template"
                                "properties" = {
                                  "name" = {
                                    "description" = "Name is the name of the helm parameter"
                                    "type" = "string"
                                  }
                                  "path" = {
                                    "description" = "Path is the path value for the helm parameter"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "parameters" = {
                              "description" = "Parameters are parameters to the helm template"
                              "items" = {
                                "description" = "HelmParameter is a parameter to a helm template"
                                "properties" = {
                                  "forceString" = {
                                    "description" = "ForceString determines whether to tell Helm to interpret booleans and numbers as strings"
                                    "type" = "boolean"
                                  }
                                  "name" = {
                                    "description" = "Name is the name of the helm parameter"
                                    "type" = "string"
                                  }
                                  "value" = {
                                    "description" = "Value is the value for the helm parameter"
                                    "type" = "string"
                                  }
                                }
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "releaseName" = {
                              "description" = "The Helm release name. If omitted it will use the application name"
                              "type" = "string"
                            }
                            "valueFiles" = {
                              "description" = "ValuesFiles is a list of Helm value files to use when generating a template"
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "values" = {
                              "description" = "Values is Helm values, typically defined as a block"
                              "type" = "string"
                            }
                            "version" = {
                              "description" = "Version is the Helm version to use for templating with"
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "ksonnet" = {
                          "description" = "Ksonnet holds ksonnet specific options"
                          "properties" = {
                            "environment" = {
                              "description" = "Environment is a ksonnet application environment name"
                              "type" = "string"
                            }
                            "parameters" = {
                              "description" = "Parameters are a list of ksonnet component parameter override values"
                              "items" = {
                                "description" = "KsonnetParameter is a ksonnet component parameter"
                                "properties" = {
                                  "component" = {
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "type" = "string"
                                  }
                                  "value" = {
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "name",
                                  "value",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                          }
                          "type" = "object"
                        }
                        "kustomize" = {
                          "description" = "Kustomize holds kustomize specific options"
                          "properties" = {
                            "commonAnnotations" = {
                              "additionalProperties" = {
                                "type" = "string"
                              }
                              "description" = "CommonAnnotations adds additional kustomize commonAnnotations"
                              "type" = "object"
                            }
                            "commonLabels" = {
                              "additionalProperties" = {
                                "type" = "string"
                              }
                              "description" = "CommonLabels adds additional kustomize commonLabels"
                              "type" = "object"
                            }
                            "images" = {
                              "description" = "Images are kustomize image overrides"
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "namePrefix" = {
                              "description" = "NamePrefix is a prefix appended to resources for kustomize apps"
                              "type" = "string"
                            }
                            "nameSuffix" = {
                              "description" = "NameSuffix is a suffix appended to resources for kustomize apps"
                              "type" = "string"
                            }
                            "version" = {
                              "description" = "Version contains optional Kustomize version"
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "path" = {
                          "description" = "Path is a directory path within the Git repository"
                          "type" = "string"
                        }
                        "plugin" = {
                          "description" = "ConfigManagementPlugin holds config management plugin specific options"
                          "properties" = {
                            "env" = {
                              "items" = {
                                "properties" = {
                                  "name" = {
                                    "description" = "the name, usually uppercase"
                                    "type" = "string"
                                  }
                                  "value" = {
                                    "description" = "the value"
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "name",
                                  "value",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "name" = {
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "repoURL" = {
                          "description" = "RepoURL is the repository URL of the application manifests"
                          "type" = "string"
                        }
                        "targetRevision" = {
                          "description" = "TargetRevision defines the commit, tag, or branch in which to sync the application to. If omitted, will sync to HEAD"
                          "type" = "string"
                        }
                      }
                      "required" = [
                        "repoURL",
                      ]
                      "type" = "object"
                    }
                    "syncOptions" = {
                      "description" = "SyncOptions provide per-sync sync-options, e.g. Validate=false"
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "syncStrategy" = {
                      "description" = "SyncStrategy describes how to perform the sync"
                      "properties" = {
                        "apply" = {
                          "description" = "Apply will perform a `kubectl apply` to perform the sync."
                          "properties" = {
                            "force" = {
                              "description" = "Force indicates whether or not to supply the --force flag to `kubectl apply`. The --force flag deletes and re-create the resource, when PATCH encounters conflict and has retried for 5 times."
                              "type" = "boolean"
                            }
                          }
                          "type" = "object"
                        }
                        "hook" = {
                          "description" = "Hook will submit any referenced resources to perform the sync. This is the default strategy"
                          "properties" = {
                            "force" = {
                              "description" = "Force indicates whether or not to supply the --force flag to `kubectl apply`. The --force flag deletes and re-create the resource, when PATCH encounters conflict and has retried for 5 times."
                              "type" = "boolean"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                  }
                  "type" = "object"
                }
              }
              "type" = "object"
            }
            "spec" = {
              "description" = "ApplicationSpec represents desired application state. Contains link to repository with application definition and additional parameters link definition revision."
              "properties" = {
                "destination" = {
                  "description" = "Destination overrides the kubernetes server and namespace defined in the environment ksonnet app.yaml"
                  "properties" = {
                    "name" = {
                      "description" = "Name of the destination cluster which can be used instead of server (url) field"
                      "type" = "string"
                    }
                    "namespace" = {
                      "description" = "Namespace overrides the environment namespace value in the ksonnet app.yaml"
                      "type" = "string"
                    }
                    "server" = {
                      "description" = "Server overrides the environment server value in the ksonnet app.yaml"
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
                "ignoreDifferences" = {
                  "description" = "IgnoreDifferences controls resources fields which should be ignored during comparison"
                  "items" = {
                    "description" = "ResourceIgnoreDifferences contains resource filter and list of json paths which should be ignored during comparison with live state."
                    "properties" = {
                      "group" = {
                        "type" = "string"
                      }
                      "jsonPointers" = {
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                      "kind" = {
                        "type" = "string"
                      }
                      "name" = {
                        "type" = "string"
                      }
                      "namespace" = {
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "jsonPointers",
                      "kind",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "info" = {
                  "description" = "Infos contains a list of useful information (URLs, email addresses, and plain text) that relates to the application"
                  "items" = {
                    "properties" = {
                      "name" = {
                        "type" = "string"
                      }
                      "value" = {
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "name",
                      "value",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "project" = {
                  "description" = "Project is a application project name. Empty name means that application belongs to 'default' project."
                  "type" = "string"
                }
                "revisionHistoryLimit" = {
                  "description" = "This limits this number of items kept in the apps revision history. This should only be changed in exceptional circumstances. Setting to zero will store no history. This will reduce storage used. Increasing will increase the space used to store the history, so we do not recommend increasing it. Default is 10."
                  "format" = "int64"
                  "type" = "integer"
                }
                "source" = {
                  "description" = "Source is a reference to the location ksonnet application definition"
                  "properties" = {
                    "chart" = {
                      "description" = "Chart is a Helm chart name"
                      "type" = "string"
                    }
                    "directory" = {
                      "description" = "Directory holds path/directory specific options"
                      "properties" = {
                        "exclude" = {
                          "type" = "string"
                        }
                        "jsonnet" = {
                          "description" = "ApplicationSourceJsonnet holds jsonnet specific options"
                          "properties" = {
                            "extVars" = {
                              "description" = "ExtVars is a list of Jsonnet External Variables"
                              "items" = {
                                "description" = "JsonnetVar is a jsonnet variable"
                                "properties" = {
                                  "code" = {
                                    "type" = "boolean"
                                  }
                                  "name" = {
                                    "type" = "string"
                                  }
                                  "value" = {
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "name",
                                  "value",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "libs" = {
                              "description" = "Additional library search dirs"
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "tlas" = {
                              "description" = "TLAS is a list of Jsonnet Top-level Arguments"
                              "items" = {
                                "description" = "JsonnetVar is a jsonnet variable"
                                "properties" = {
                                  "code" = {
                                    "type" = "boolean"
                                  }
                                  "name" = {
                                    "type" = "string"
                                  }
                                  "value" = {
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "name",
                                  "value",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                          }
                          "type" = "object"
                        }
                        "recurse" = {
                          "type" = "boolean"
                        }
                      }
                      "type" = "object"
                    }
                    "helm" = {
                      "description" = "Helm holds helm specific options"
                      "properties" = {
                        "fileParameters" = {
                          "description" = "FileParameters are file parameters to the helm template"
                          "items" = {
                            "description" = "HelmFileParameter is a file parameter to a helm template"
                            "properties" = {
                              "name" = {
                                "description" = "Name is the name of the helm parameter"
                                "type" = "string"
                              }
                              "path" = {
                                "description" = "Path is the path value for the helm parameter"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "parameters" = {
                          "description" = "Parameters are parameters to the helm template"
                          "items" = {
                            "description" = "HelmParameter is a parameter to a helm template"
                            "properties" = {
                              "forceString" = {
                                "description" = "ForceString determines whether to tell Helm to interpret booleans and numbers as strings"
                                "type" = "boolean"
                              }
                              "name" = {
                                "description" = "Name is the name of the helm parameter"
                                "type" = "string"
                              }
                              "value" = {
                                "description" = "Value is the value for the helm parameter"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "releaseName" = {
                          "description" = "The Helm release name. If omitted it will use the application name"
                          "type" = "string"
                        }
                        "valueFiles" = {
                          "description" = "ValuesFiles is a list of Helm value files to use when generating a template"
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "values" = {
                          "description" = "Values is Helm values, typically defined as a block"
                          "type" = "string"
                        }
                        "version" = {
                          "description" = "Version is the Helm version to use for templating with"
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "ksonnet" = {
                      "description" = "Ksonnet holds ksonnet specific options"
                      "properties" = {
                        "environment" = {
                          "description" = "Environment is a ksonnet application environment name"
                          "type" = "string"
                        }
                        "parameters" = {
                          "description" = "Parameters are a list of ksonnet component parameter override values"
                          "items" = {
                            "description" = "KsonnetParameter is a ksonnet component parameter"
                            "properties" = {
                              "component" = {
                                "type" = "string"
                              }
                              "name" = {
                                "type" = "string"
                              }
                              "value" = {
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "name",
                              "value",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                      }
                      "type" = "object"
                    }
                    "kustomize" = {
                      "description" = "Kustomize holds kustomize specific options"
                      "properties" = {
                        "commonAnnotations" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = "CommonAnnotations adds additional kustomize commonAnnotations"
                          "type" = "object"
                        }
                        "commonLabels" = {
                          "additionalProperties" = {
                            "type" = "string"
                          }
                          "description" = "CommonLabels adds additional kustomize commonLabels"
                          "type" = "object"
                        }
                        "images" = {
                          "description" = "Images are kustomize image overrides"
                          "items" = {
                            "type" = "string"
                          }
                          "type" = "array"
                        }
                        "namePrefix" = {
                          "description" = "NamePrefix is a prefix appended to resources for kustomize apps"
                          "type" = "string"
                        }
                        "nameSuffix" = {
                          "description" = "NameSuffix is a suffix appended to resources for kustomize apps"
                          "type" = "string"
                        }
                        "version" = {
                          "description" = "Version contains optional Kustomize version"
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "path" = {
                      "description" = "Path is a directory path within the Git repository"
                      "type" = "string"
                    }
                    "plugin" = {
                      "description" = "ConfigManagementPlugin holds config management plugin specific options"
                      "properties" = {
                        "env" = {
                          "items" = {
                            "properties" = {
                              "name" = {
                                "description" = "the name, usually uppercase"
                                "type" = "string"
                              }
                              "value" = {
                                "description" = "the value"
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "name",
                              "value",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "name" = {
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "repoURL" = {
                      "description" = "RepoURL is the repository URL of the application manifests"
                      "type" = "string"
                    }
                    "targetRevision" = {
                      "description" = "TargetRevision defines the commit, tag, or branch in which to sync the application to. If omitted, will sync to HEAD"
                      "type" = "string"
                    }
                  }
                  "required" = [
                    "repoURL",
                  ]
                  "type" = "object"
                }
                "syncPolicy" = {
                  "description" = "SyncPolicy controls when a sync will be performed"
                  "properties" = {
                    "automated" = {
                      "description" = "Automated will keep an application synced to the target revision"
                      "properties" = {
                        "allowEmpty" = {
                          "description" = "AllowEmpty allows apps have zero live resources (default: false)"
                          "type" = "boolean"
                        }
                        "prune" = {
                          "description" = "Prune will prune resources automatically as part of automated sync (default: false)"
                          "type" = "boolean"
                        }
                        "selfHeal" = {
                          "description" = "SelfHeal enables auto-syncing if  (default: false)"
                          "type" = "boolean"
                        }
                      }
                      "type" = "object"
                    }
                    "retry" = {
                      "description" = "Retry controls failed sync retry behavior"
                      "properties" = {
                        "backoff" = {
                          "description" = "Backoff is a backoff strategy"
                          "properties" = {
                            "duration" = {
                              "description" = "Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. \"2m\", \"1h\")"
                              "type" = "string"
                            }
                            "factor" = {
                              "description" = "Factor is a factor to multiply the base duration after each failed retry"
                              "format" = "int64"
                              "type" = "integer"
                            }
                            "maxDuration" = {
                              "description" = "MaxDuration is the maximum amount of time allowed for the backoff strategy"
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "limit" = {
                          "description" = "Limit is the maximum number of attempts when retrying a container"
                          "format" = "int64"
                          "type" = "integer"
                        }
                      }
                      "type" = "object"
                    }
                    "syncOptions" = {
                      "description" = "Options allow you to specify whole app sync-options"
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                  }
                  "type" = "object"
                }
              }
              "required" = [
                "destination",
                "project",
                "source",
              ]
              "type" = "object"
            }
            "status" = {
              "description" = "ApplicationStatus contains information about application sync, health status"
              "properties" = {
                "conditions" = {
                  "items" = {
                    "description" = "ApplicationCondition contains details about current application condition"
                    "properties" = {
                      "lastTransitionTime" = {
                        "description" = "LastTransitionTime is the time the condition was first observed."
                        "format" = "date-time"
                        "type" = "string"
                      }
                      "message" = {
                        "description" = "Message contains human-readable message indicating details about condition"
                        "type" = "string"
                      }
                      "type" = {
                        "description" = "Type is an application condition type"
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "message",
                      "type",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "health" = {
                  "properties" = {
                    "message" = {
                      "type" = "string"
                    }
                    "status" = {
                      "description" = "Represents resource health status"
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
                "history" = {
                  "description" = "RevisionHistories is a array of history, oldest first and newest last"
                  "items" = {
                    "description" = "RevisionHistory contains information relevant to an application deployment"
                    "properties" = {
                      "deployStartedAt" = {
                        "description" = "DeployStartedAt holds the time the deployment started"
                        "format" = "date-time"
                        "type" = "string"
                      }
                      "deployedAt" = {
                        "description" = "DeployedAt holds the time the deployment completed"
                        "format" = "date-time"
                        "type" = "string"
                      }
                      "id" = {
                        "description" = "ID is an auto incrementing identifier of the RevisionHistory"
                        "format" = "int64"
                        "type" = "integer"
                      }
                      "revision" = {
                        "description" = "Revision holds the revision of the sync"
                        "type" = "string"
                      }
                      "source" = {
                        "description" = "ApplicationSource contains information about github repository, path within repository and target application environment."
                        "properties" = {
                          "chart" = {
                            "description" = "Chart is a Helm chart name"
                            "type" = "string"
                          }
                          "directory" = {
                            "description" = "Directory holds path/directory specific options"
                            "properties" = {
                              "exclude" = {
                                "type" = "string"
                              }
                              "jsonnet" = {
                                "description" = "ApplicationSourceJsonnet holds jsonnet specific options"
                                "properties" = {
                                  "extVars" = {
                                    "description" = "ExtVars is a list of Jsonnet External Variables"
                                    "items" = {
                                      "description" = "JsonnetVar is a jsonnet variable"
                                      "properties" = {
                                        "code" = {
                                          "type" = "boolean"
                                        }
                                        "name" = {
                                          "type" = "string"
                                        }
                                        "value" = {
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "name",
                                        "value",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                  }
                                  "libs" = {
                                    "description" = "Additional library search dirs"
                                    "items" = {
                                      "type" = "string"
                                    }
                                    "type" = "array"
                                  }
                                  "tlas" = {
                                    "description" = "TLAS is a list of Jsonnet Top-level Arguments"
                                    "items" = {
                                      "description" = "JsonnetVar is a jsonnet variable"
                                      "properties" = {
                                        "code" = {
                                          "type" = "boolean"
                                        }
                                        "name" = {
                                          "type" = "string"
                                        }
                                        "value" = {
                                          "type" = "string"
                                        }
                                      }
                                      "required" = [
                                        "name",
                                        "value",
                                      ]
                                      "type" = "object"
                                    }
                                    "type" = "array"
                                  }
                                }
                                "type" = "object"
                              }
                              "recurse" = {
                                "type" = "boolean"
                              }
                            }
                            "type" = "object"
                          }
                          "helm" = {
                            "description" = "Helm holds helm specific options"
                            "properties" = {
                              "fileParameters" = {
                                "description" = "FileParameters are file parameters to the helm template"
                                "items" = {
                                  "description" = "HelmFileParameter is a file parameter to a helm template"
                                  "properties" = {
                                    "name" = {
                                      "description" = "Name is the name of the helm parameter"
                                      "type" = "string"
                                    }
                                    "path" = {
                                      "description" = "Path is the path value for the helm parameter"
                                      "type" = "string"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                              "parameters" = {
                                "description" = "Parameters are parameters to the helm template"
                                "items" = {
                                  "description" = "HelmParameter is a parameter to a helm template"
                                  "properties" = {
                                    "forceString" = {
                                      "description" = "ForceString determines whether to tell Helm to interpret booleans and numbers as strings"
                                      "type" = "boolean"
                                    }
                                    "name" = {
                                      "description" = "Name is the name of the helm parameter"
                                      "type" = "string"
                                    }
                                    "value" = {
                                      "description" = "Value is the value for the helm parameter"
                                      "type" = "string"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                              "releaseName" = {
                                "description" = "The Helm release name. If omitted it will use the application name"
                                "type" = "string"
                              }
                              "valueFiles" = {
                                "description" = "ValuesFiles is a list of Helm value files to use when generating a template"
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "values" = {
                                "description" = "Values is Helm values, typically defined as a block"
                                "type" = "string"
                              }
                              "version" = {
                                "description" = "Version is the Helm version to use for templating with"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "ksonnet" = {
                            "description" = "Ksonnet holds ksonnet specific options"
                            "properties" = {
                              "environment" = {
                                "description" = "Environment is a ksonnet application environment name"
                                "type" = "string"
                              }
                              "parameters" = {
                                "description" = "Parameters are a list of ksonnet component parameter override values"
                                "items" = {
                                  "description" = "KsonnetParameter is a ksonnet component parameter"
                                  "properties" = {
                                    "component" = {
                                      "type" = "string"
                                    }
                                    "name" = {
                                      "type" = "string"
                                    }
                                    "value" = {
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                    "value",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                            }
                            "type" = "object"
                          }
                          "kustomize" = {
                            "description" = "Kustomize holds kustomize specific options"
                            "properties" = {
                              "commonAnnotations" = {
                                "additionalProperties" = {
                                  "type" = "string"
                                }
                                "description" = "CommonAnnotations adds additional kustomize commonAnnotations"
                                "type" = "object"
                              }
                              "commonLabels" = {
                                "additionalProperties" = {
                                  "type" = "string"
                                }
                                "description" = "CommonLabels adds additional kustomize commonLabels"
                                "type" = "object"
                              }
                              "images" = {
                                "description" = "Images are kustomize image overrides"
                                "items" = {
                                  "type" = "string"
                                }
                                "type" = "array"
                              }
                              "namePrefix" = {
                                "description" = "NamePrefix is a prefix appended to resources for kustomize apps"
                                "type" = "string"
                              }
                              "nameSuffix" = {
                                "description" = "NameSuffix is a suffix appended to resources for kustomize apps"
                                "type" = "string"
                              }
                              "version" = {
                                "description" = "Version contains optional Kustomize version"
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "path" = {
                            "description" = "Path is a directory path within the Git repository"
                            "type" = "string"
                          }
                          "plugin" = {
                            "description" = "ConfigManagementPlugin holds config management plugin specific options"
                            "properties" = {
                              "env" = {
                                "items" = {
                                  "properties" = {
                                    "name" = {
                                      "description" = "the name, usually uppercase"
                                      "type" = "string"
                                    }
                                    "value" = {
                                      "description" = "the value"
                                      "type" = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                    "value",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                              "name" = {
                                "type" = "string"
                              }
                            }
                            "type" = "object"
                          }
                          "repoURL" = {
                            "description" = "RepoURL is the repository URL of the application manifests"
                            "type" = "string"
                          }
                          "targetRevision" = {
                            "description" = "TargetRevision defines the commit, tag, or branch in which to sync the application to. If omitted, will sync to HEAD"
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "repoURL",
                        ]
                        "type" = "object"
                      }
                    }
                    "required" = [
                      "deployedAt",
                      "id",
                      "revision",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "observedAt" = {
                  "description" = "ObservedAt indicates when the application state was updated without querying latest git state Deprecated: controller no longer updates ObservedAt field"
                  "format" = "date-time"
                  "type" = "string"
                }
                "operationState" = {
                  "description" = "OperationState contains information about state of currently performing operation on application."
                  "properties" = {
                    "finishedAt" = {
                      "description" = "FinishedAt contains time of operation completion"
                      "format" = "date-time"
                      "type" = "string"
                    }
                    "message" = {
                      "description" = "Message hold any pertinent messages when attempting to perform operation (typically errors)."
                      "type" = "string"
                    }
                    "operation" = {
                      "description" = "Operation is the original requested operation"
                      "properties" = {
                        "info" = {
                          "items" = {
                            "properties" = {
                              "name" = {
                                "type" = "string"
                              }
                              "value" = {
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "name",
                              "value",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "initiatedBy" = {
                          "description" = "OperationInitiator holds information about the operation initiator"
                          "properties" = {
                            "automated" = {
                              "description" = "Automated is set to true if operation was initiated automatically by the application controller."
                              "type" = "boolean"
                            }
                            "username" = {
                              "description" = "Name of a user who started operation."
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "retry" = {
                          "description" = "Retry controls failed sync retry behavior"
                          "properties" = {
                            "backoff" = {
                              "description" = "Backoff is a backoff strategy"
                              "properties" = {
                                "duration" = {
                                  "description" = "Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. \"2m\", \"1h\")"
                                  "type" = "string"
                                }
                                "factor" = {
                                  "description" = "Factor is a factor to multiply the base duration after each failed retry"
                                  "format" = "int64"
                                  "type" = "integer"
                                }
                                "maxDuration" = {
                                  "description" = "MaxDuration is the maximum amount of time allowed for the backoff strategy"
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "limit" = {
                              "description" = "Limit is the maximum number of attempts when retrying a container"
                              "format" = "int64"
                              "type" = "integer"
                            }
                          }
                          "type" = "object"
                        }
                        "sync" = {
                          "description" = "SyncOperation contains sync operation details."
                          "properties" = {
                            "dryRun" = {
                              "description" = "DryRun will perform a `kubectl apply --dry-run` without actually performing the sync"
                              "type" = "boolean"
                            }
                            "manifests" = {
                              "description" = "Manifests is an optional field that overrides sync source with a local directory for development"
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "prune" = {
                              "description" = "Prune deletes resources that are no longer tracked in git"
                              "type" = "boolean"
                            }
                            "resources" = {
                              "description" = "Resources describes which resources to sync"
                              "items" = {
                                "description" = "SyncOperationResource contains resources to sync."
                                "properties" = {
                                  "group" = {
                                    "type" = "string"
                                  }
                                  "kind" = {
                                    "type" = "string"
                                  }
                                  "name" = {
                                    "type" = "string"
                                  }
                                  "namespace" = {
                                    "type" = "string"
                                  }
                                }
                                "required" = [
                                  "kind",
                                  "name",
                                ]
                                "type" = "object"
                              }
                              "type" = "array"
                            }
                            "revision" = {
                              "description" = "Revision is the revision in which to sync the application to. If omitted, will use the revision specified in app spec."
                              "type" = "string"
                            }
                            "source" = {
                              "description" = "Source overrides the source definition set in the application. This is typically set in a Rollback operation and nil during a Sync operation"
                              "properties" = {
                                "chart" = {
                                  "description" = "Chart is a Helm chart name"
                                  "type" = "string"
                                }
                                "directory" = {
                                  "description" = "Directory holds path/directory specific options"
                                  "properties" = {
                                    "exclude" = {
                                      "type" = "string"
                                    }
                                    "jsonnet" = {
                                      "description" = "ApplicationSourceJsonnet holds jsonnet specific options"
                                      "properties" = {
                                        "extVars" = {
                                          "description" = "ExtVars is a list of Jsonnet External Variables"
                                          "items" = {
                                            "description" = "JsonnetVar is a jsonnet variable"
                                            "properties" = {
                                              "code" = {
                                                "type" = "boolean"
                                              }
                                              "name" = {
                                                "type" = "string"
                                              }
                                              "value" = {
                                                "type" = "string"
                                              }
                                            }
                                            "required" = [
                                              "name",
                                              "value",
                                            ]
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                        }
                                        "libs" = {
                                          "description" = "Additional library search dirs"
                                          "items" = {
                                            "type" = "string"
                                          }
                                          "type" = "array"
                                        }
                                        "tlas" = {
                                          "description" = "TLAS is a list of Jsonnet Top-level Arguments"
                                          "items" = {
                                            "description" = "JsonnetVar is a jsonnet variable"
                                            "properties" = {
                                              "code" = {
                                                "type" = "boolean"
                                              }
                                              "name" = {
                                                "type" = "string"
                                              }
                                              "value" = {
                                                "type" = "string"
                                              }
                                            }
                                            "required" = [
                                              "name",
                                              "value",
                                            ]
                                            "type" = "object"
                                          }
                                          "type" = "array"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                    "recurse" = {
                                      "type" = "boolean"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "helm" = {
                                  "description" = "Helm holds helm specific options"
                                  "properties" = {
                                    "fileParameters" = {
                                      "description" = "FileParameters are file parameters to the helm template"
                                      "items" = {
                                        "description" = "HelmFileParameter is a file parameter to a helm template"
                                        "properties" = {
                                          "name" = {
                                            "description" = "Name is the name of the helm parameter"
                                            "type" = "string"
                                          }
                                          "path" = {
                                            "description" = "Path is the path value for the helm parameter"
                                            "type" = "string"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                    "parameters" = {
                                      "description" = "Parameters are parameters to the helm template"
                                      "items" = {
                                        "description" = "HelmParameter is a parameter to a helm template"
                                        "properties" = {
                                          "forceString" = {
                                            "description" = "ForceString determines whether to tell Helm to interpret booleans and numbers as strings"
                                            "type" = "boolean"
                                          }
                                          "name" = {
                                            "description" = "Name is the name of the helm parameter"
                                            "type" = "string"
                                          }
                                          "value" = {
                                            "description" = "Value is the value for the helm parameter"
                                            "type" = "string"
                                          }
                                        }
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                    "releaseName" = {
                                      "description" = "The Helm release name. If omitted it will use the application name"
                                      "type" = "string"
                                    }
                                    "valueFiles" = {
                                      "description" = "ValuesFiles is a list of Helm value files to use when generating a template"
                                      "items" = {
                                        "type" = "string"
                                      }
                                      "type" = "array"
                                    }
                                    "values" = {
                                      "description" = "Values is Helm values, typically defined as a block"
                                      "type" = "string"
                                    }
                                    "version" = {
                                      "description" = "Version is the Helm version to use for templating with"
                                      "type" = "string"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "ksonnet" = {
                                  "description" = "Ksonnet holds ksonnet specific options"
                                  "properties" = {
                                    "environment" = {
                                      "description" = "Environment is a ksonnet application environment name"
                                      "type" = "string"
                                    }
                                    "parameters" = {
                                      "description" = "Parameters are a list of ksonnet component parameter override values"
                                      "items" = {
                                        "description" = "KsonnetParameter is a ksonnet component parameter"
                                        "properties" = {
                                          "component" = {
                                            "type" = "string"
                                          }
                                          "name" = {
                                            "type" = "string"
                                          }
                                          "value" = {
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                          "value",
                                        ]
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "kustomize" = {
                                  "description" = "Kustomize holds kustomize specific options"
                                  "properties" = {
                                    "commonAnnotations" = {
                                      "additionalProperties" = {
                                        "type" = "string"
                                      }
                                      "description" = "CommonAnnotations adds additional kustomize commonAnnotations"
                                      "type" = "object"
                                    }
                                    "commonLabels" = {
                                      "additionalProperties" = {
                                        "type" = "string"
                                      }
                                      "description" = "CommonLabels adds additional kustomize commonLabels"
                                      "type" = "object"
                                    }
                                    "images" = {
                                      "description" = "Images are kustomize image overrides"
                                      "items" = {
                                        "type" = "string"
                                      }
                                      "type" = "array"
                                    }
                                    "namePrefix" = {
                                      "description" = "NamePrefix is a prefix appended to resources for kustomize apps"
                                      "type" = "string"
                                    }
                                    "nameSuffix" = {
                                      "description" = "NameSuffix is a suffix appended to resources for kustomize apps"
                                      "type" = "string"
                                    }
                                    "version" = {
                                      "description" = "Version contains optional Kustomize version"
                                      "type" = "string"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "path" = {
                                  "description" = "Path is a directory path within the Git repository"
                                  "type" = "string"
                                }
                                "plugin" = {
                                  "description" = "ConfigManagementPlugin holds config management plugin specific options"
                                  "properties" = {
                                    "env" = {
                                      "items" = {
                                        "properties" = {
                                          "name" = {
                                            "description" = "the name, usually uppercase"
                                            "type" = "string"
                                          }
                                          "value" = {
                                            "description" = "the value"
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                          "value",
                                        ]
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                    "name" = {
                                      "type" = "string"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "repoURL" = {
                                  "description" = "RepoURL is the repository URL of the application manifests"
                                  "type" = "string"
                                }
                                "targetRevision" = {
                                  "description" = "TargetRevision defines the commit, tag, or branch in which to sync the application to. If omitted, will sync to HEAD"
                                  "type" = "string"
                                }
                              }
                              "required" = [
                                "repoURL",
                              ]
                              "type" = "object"
                            }
                            "syncOptions" = {
                              "description" = "SyncOptions provide per-sync sync-options, e.g. Validate=false"
                              "items" = {
                                "type" = "string"
                              }
                              "type" = "array"
                            }
                            "syncStrategy" = {
                              "description" = "SyncStrategy describes how to perform the sync"
                              "properties" = {
                                "apply" = {
                                  "description" = "Apply will perform a `kubectl apply` to perform the sync."
                                  "properties" = {
                                    "force" = {
                                      "description" = "Force indicates whether or not to supply the --force flag to `kubectl apply`. The --force flag deletes and re-create the resource, when PATCH encounters conflict and has retried for 5 times."
                                      "type" = "boolean"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "hook" = {
                                  "description" = "Hook will submit any referenced resources to perform the sync. This is the default strategy"
                                  "properties" = {
                                    "force" = {
                                      "description" = "Force indicates whether or not to supply the --force flag to `kubectl apply`. The --force flag deletes and re-create the resource, when PATCH encounters conflict and has retried for 5 times."
                                      "type" = "boolean"
                                    }
                                  }
                                  "type" = "object"
                                }
                              }
                              "type" = "object"
                            }
                          }
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "phase" = {
                      "description" = "Phase is the current phase of the operation"
                      "type" = "string"
                    }
                    "retryCount" = {
                      "description" = "RetryCount contains time of operation retries"
                      "format" = "int64"
                      "type" = "integer"
                    }
                    "startedAt" = {
                      "description" = "StartedAt contains time of operation start"
                      "format" = "date-time"
                      "type" = "string"
                    }
                    "syncResult" = {
                      "description" = "SyncResult is the result of a Sync operation"
                      "properties" = {
                        "resources" = {
                          "description" = "Resources holds the sync result of each individual resource"
                          "items" = {
                            "description" = "ResourceResult holds the operation result details of a specific resource"
                            "properties" = {
                              "group" = {
                                "type" = "string"
                              }
                              "hookPhase" = {
                                "description" = "the state of any operation associated with this resource OR hook note: can contain values for non-hook resources"
                                "type" = "string"
                              }
                              "hookType" = {
                                "description" = "the type of the hook, empty for non-hook resources"
                                "type" = "string"
                              }
                              "kind" = {
                                "type" = "string"
                              }
                              "message" = {
                                "description" = "message for the last sync OR operation"
                                "type" = "string"
                              }
                              "name" = {
                                "type" = "string"
                              }
                              "namespace" = {
                                "type" = "string"
                              }
                              "status" = {
                                "description" = "the final result of the sync, this is be empty if the resources is yet to be applied/pruned and is always zero-value for hooks"
                                "type" = "string"
                              }
                              "syncPhase" = {
                                "description" = "indicates the particular phase of the sync that this is for"
                                "type" = "string"
                              }
                              "version" = {
                                "type" = "string"
                              }
                            }
                            "required" = [
                              "group",
                              "kind",
                              "name",
                              "namespace",
                              "version",
                            ]
                            "type" = "object"
                          }
                          "type" = "array"
                        }
                        "revision" = {
                          "description" = "Revision holds the revision of the sync"
                          "type" = "string"
                        }
                        "source" = {
                          "description" = "Source records the application source information of the sync, used for comparing auto-sync"
                          "properties" = {
                            "chart" = {
                              "description" = "Chart is a Helm chart name"
                              "type" = "string"
                            }
                            "directory" = {
                              "description" = "Directory holds path/directory specific options"
                              "properties" = {
                                "exclude" = {
                                  "type" = "string"
                                }
                                "jsonnet" = {
                                  "description" = "ApplicationSourceJsonnet holds jsonnet specific options"
                                  "properties" = {
                                    "extVars" = {
                                      "description" = "ExtVars is a list of Jsonnet External Variables"
                                      "items" = {
                                        "description" = "JsonnetVar is a jsonnet variable"
                                        "properties" = {
                                          "code" = {
                                            "type" = "boolean"
                                          }
                                          "name" = {
                                            "type" = "string"
                                          }
                                          "value" = {
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                          "value",
                                        ]
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                    "libs" = {
                                      "description" = "Additional library search dirs"
                                      "items" = {
                                        "type" = "string"
                                      }
                                      "type" = "array"
                                    }
                                    "tlas" = {
                                      "description" = "TLAS is a list of Jsonnet Top-level Arguments"
                                      "items" = {
                                        "description" = "JsonnetVar is a jsonnet variable"
                                        "properties" = {
                                          "code" = {
                                            "type" = "boolean"
                                          }
                                          "name" = {
                                            "type" = "string"
                                          }
                                          "value" = {
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                          "value",
                                        ]
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "recurse" = {
                                  "type" = "boolean"
                                }
                              }
                              "type" = "object"
                            }
                            "helm" = {
                              "description" = "Helm holds helm specific options"
                              "properties" = {
                                "fileParameters" = {
                                  "description" = "FileParameters are file parameters to the helm template"
                                  "items" = {
                                    "description" = "HelmFileParameter is a file parameter to a helm template"
                                    "properties" = {
                                      "name" = {
                                        "description" = "Name is the name of the helm parameter"
                                        "type" = "string"
                                      }
                                      "path" = {
                                        "description" = "Path is the path value for the helm parameter"
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "parameters" = {
                                  "description" = "Parameters are parameters to the helm template"
                                  "items" = {
                                    "description" = "HelmParameter is a parameter to a helm template"
                                    "properties" = {
                                      "forceString" = {
                                        "description" = "ForceString determines whether to tell Helm to interpret booleans and numbers as strings"
                                        "type" = "boolean"
                                      }
                                      "name" = {
                                        "description" = "Name is the name of the helm parameter"
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "description" = "Value is the value for the helm parameter"
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "releaseName" = {
                                  "description" = "The Helm release name. If omitted it will use the application name"
                                  "type" = "string"
                                }
                                "valueFiles" = {
                                  "description" = "ValuesFiles is a list of Helm value files to use when generating a template"
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "values" = {
                                  "description" = "Values is Helm values, typically defined as a block"
                                  "type" = "string"
                                }
                                "version" = {
                                  "description" = "Version is the Helm version to use for templating with"
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "ksonnet" = {
                              "description" = "Ksonnet holds ksonnet specific options"
                              "properties" = {
                                "environment" = {
                                  "description" = "Environment is a ksonnet application environment name"
                                  "type" = "string"
                                }
                                "parameters" = {
                                  "description" = "Parameters are a list of ksonnet component parameter override values"
                                  "items" = {
                                    "description" = "KsonnetParameter is a ksonnet component parameter"
                                    "properties" = {
                                      "component" = {
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "name",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                              }
                              "type" = "object"
                            }
                            "kustomize" = {
                              "description" = "Kustomize holds kustomize specific options"
                              "properties" = {
                                "commonAnnotations" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = "CommonAnnotations adds additional kustomize commonAnnotations"
                                  "type" = "object"
                                }
                                "commonLabels" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = "CommonLabels adds additional kustomize commonLabels"
                                  "type" = "object"
                                }
                                "images" = {
                                  "description" = "Images are kustomize image overrides"
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "namePrefix" = {
                                  "description" = "NamePrefix is a prefix appended to resources for kustomize apps"
                                  "type" = "string"
                                }
                                "nameSuffix" = {
                                  "description" = "NameSuffix is a suffix appended to resources for kustomize apps"
                                  "type" = "string"
                                }
                                "version" = {
                                  "description" = "Version contains optional Kustomize version"
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "path" = {
                              "description" = "Path is a directory path within the Git repository"
                              "type" = "string"
                            }
                            "plugin" = {
                              "description" = "ConfigManagementPlugin holds config management plugin specific options"
                              "properties" = {
                                "env" = {
                                  "items" = {
                                    "properties" = {
                                      "name" = {
                                        "description" = "the name, usually uppercase"
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "description" = "the value"
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "name",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "name" = {
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "repoURL" = {
                              "description" = "RepoURL is the repository URL of the application manifests"
                              "type" = "string"
                            }
                            "targetRevision" = {
                              "description" = "TargetRevision defines the commit, tag, or branch in which to sync the application to. If omitted, will sync to HEAD"
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "repoURL",
                          ]
                          "type" = "object"
                        }
                      }
                      "required" = [
                        "revision",
                      ]
                      "type" = "object"
                    }
                  }
                  "required" = [
                    "operation",
                    "phase",
                    "startedAt",
                  ]
                  "type" = "object"
                }
                "reconciledAt" = {
                  "description" = "ReconciledAt indicates when the application state was reconciled using the latest git version"
                  "format" = "date-time"
                  "type" = "string"
                }
                "resources" = {
                  "items" = {
                    "description" = "ResourceStatus holds the current sync and health status of a resource"
                    "properties" = {
                      "group" = {
                        "type" = "string"
                      }
                      "health" = {
                        "properties" = {
                          "message" = {
                            "type" = "string"
                          }
                          "status" = {
                            "description" = "Represents resource health status"
                            "type" = "string"
                          }
                        }
                        "type" = "object"
                      }
                      "hook" = {
                        "type" = "boolean"
                      }
                      "kind" = {
                        "type" = "string"
                      }
                      "name" = {
                        "type" = "string"
                      }
                      "namespace" = {
                        "type" = "string"
                      }
                      "requiresPruning" = {
                        "type" = "boolean"
                      }
                      "status" = {
                        "description" = "SyncStatusCode is a type which represents possible comparison results"
                        "type" = "string"
                      }
                      "version" = {
                        "type" = "string"
                      }
                    }
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "sourceType" = {
                  "type" = "string"
                }
                "summary" = {
                  "properties" = {
                    "externalURLs" = {
                      "description" = "ExternalURLs holds all external URLs of application child resources."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "images" = {
                      "description" = "Images holds all images of application child resources."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                  }
                  "type" = "object"
                }
                "sync" = {
                  "description" = "SyncStatus is a comparison result of application spec and deployed application."
                  "properties" = {
                    "comparedTo" = {
                      "description" = "ComparedTo contains application source and target which was used for resources comparison"
                      "properties" = {
                        "destination" = {
                          "description" = "ApplicationDestination contains deployment destination information"
                          "properties" = {
                            "name" = {
                              "description" = "Name of the destination cluster which can be used instead of server (url) field"
                              "type" = "string"
                            }
                            "namespace" = {
                              "description" = "Namespace overrides the environment namespace value in the ksonnet app.yaml"
                              "type" = "string"
                            }
                            "server" = {
                              "description" = "Server overrides the environment server value in the ksonnet app.yaml"
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "source" = {
                          "description" = "ApplicationSource contains information about github repository, path within repository and target application environment."
                          "properties" = {
                            "chart" = {
                              "description" = "Chart is a Helm chart name"
                              "type" = "string"
                            }
                            "directory" = {
                              "description" = "Directory holds path/directory specific options"
                              "properties" = {
                                "exclude" = {
                                  "type" = "string"
                                }
                                "jsonnet" = {
                                  "description" = "ApplicationSourceJsonnet holds jsonnet specific options"
                                  "properties" = {
                                    "extVars" = {
                                      "description" = "ExtVars is a list of Jsonnet External Variables"
                                      "items" = {
                                        "description" = "JsonnetVar is a jsonnet variable"
                                        "properties" = {
                                          "code" = {
                                            "type" = "boolean"
                                          }
                                          "name" = {
                                            "type" = "string"
                                          }
                                          "value" = {
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                          "value",
                                        ]
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                    "libs" = {
                                      "description" = "Additional library search dirs"
                                      "items" = {
                                        "type" = "string"
                                      }
                                      "type" = "array"
                                    }
                                    "tlas" = {
                                      "description" = "TLAS is a list of Jsonnet Top-level Arguments"
                                      "items" = {
                                        "description" = "JsonnetVar is a jsonnet variable"
                                        "properties" = {
                                          "code" = {
                                            "type" = "boolean"
                                          }
                                          "name" = {
                                            "type" = "string"
                                          }
                                          "value" = {
                                            "type" = "string"
                                          }
                                        }
                                        "required" = [
                                          "name",
                                          "value",
                                        ]
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                  }
                                  "type" = "object"
                                }
                                "recurse" = {
                                  "type" = "boolean"
                                }
                              }
                              "type" = "object"
                            }
                            "helm" = {
                              "description" = "Helm holds helm specific options"
                              "properties" = {
                                "fileParameters" = {
                                  "description" = "FileParameters are file parameters to the helm template"
                                  "items" = {
                                    "description" = "HelmFileParameter is a file parameter to a helm template"
                                    "properties" = {
                                      "name" = {
                                        "description" = "Name is the name of the helm parameter"
                                        "type" = "string"
                                      }
                                      "path" = {
                                        "description" = "Path is the path value for the helm parameter"
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "parameters" = {
                                  "description" = "Parameters are parameters to the helm template"
                                  "items" = {
                                    "description" = "HelmParameter is a parameter to a helm template"
                                    "properties" = {
                                      "forceString" = {
                                        "description" = "ForceString determines whether to tell Helm to interpret booleans and numbers as strings"
                                        "type" = "boolean"
                                      }
                                      "name" = {
                                        "description" = "Name is the name of the helm parameter"
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "description" = "Value is the value for the helm parameter"
                                        "type" = "string"
                                      }
                                    }
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "releaseName" = {
                                  "description" = "The Helm release name. If omitted it will use the application name"
                                  "type" = "string"
                                }
                                "valueFiles" = {
                                  "description" = "ValuesFiles is a list of Helm value files to use when generating a template"
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "values" = {
                                  "description" = "Values is Helm values, typically defined as a block"
                                  "type" = "string"
                                }
                                "version" = {
                                  "description" = "Version is the Helm version to use for templating with"
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "ksonnet" = {
                              "description" = "Ksonnet holds ksonnet specific options"
                              "properties" = {
                                "environment" = {
                                  "description" = "Environment is a ksonnet application environment name"
                                  "type" = "string"
                                }
                                "parameters" = {
                                  "description" = "Parameters are a list of ksonnet component parameter override values"
                                  "items" = {
                                    "description" = "KsonnetParameter is a ksonnet component parameter"
                                    "properties" = {
                                      "component" = {
                                        "type" = "string"
                                      }
                                      "name" = {
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "name",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                              }
                              "type" = "object"
                            }
                            "kustomize" = {
                              "description" = "Kustomize holds kustomize specific options"
                              "properties" = {
                                "commonAnnotations" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = "CommonAnnotations adds additional kustomize commonAnnotations"
                                  "type" = "object"
                                }
                                "commonLabels" = {
                                  "additionalProperties" = {
                                    "type" = "string"
                                  }
                                  "description" = "CommonLabels adds additional kustomize commonLabels"
                                  "type" = "object"
                                }
                                "images" = {
                                  "description" = "Images are kustomize image overrides"
                                  "items" = {
                                    "type" = "string"
                                  }
                                  "type" = "array"
                                }
                                "namePrefix" = {
                                  "description" = "NamePrefix is a prefix appended to resources for kustomize apps"
                                  "type" = "string"
                                }
                                "nameSuffix" = {
                                  "description" = "NameSuffix is a suffix appended to resources for kustomize apps"
                                  "type" = "string"
                                }
                                "version" = {
                                  "description" = "Version contains optional Kustomize version"
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "path" = {
                              "description" = "Path is a directory path within the Git repository"
                              "type" = "string"
                            }
                            "plugin" = {
                              "description" = "ConfigManagementPlugin holds config management plugin specific options"
                              "properties" = {
                                "env" = {
                                  "items" = {
                                    "properties" = {
                                      "name" = {
                                        "description" = "the name, usually uppercase"
                                        "type" = "string"
                                      }
                                      "value" = {
                                        "description" = "the value"
                                        "type" = "string"
                                      }
                                    }
                                    "required" = [
                                      "name",
                                      "value",
                                    ]
                                    "type" = "object"
                                  }
                                  "type" = "array"
                                }
                                "name" = {
                                  "type" = "string"
                                }
                              }
                              "type" = "object"
                            }
                            "repoURL" = {
                              "description" = "RepoURL is the repository URL of the application manifests"
                              "type" = "string"
                            }
                            "targetRevision" = {
                              "description" = "TargetRevision defines the commit, tag, or branch in which to sync the application to. If omitted, will sync to HEAD"
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "repoURL",
                          ]
                          "type" = "object"
                        }
                      }
                      "required" = [
                        "destination",
                        "source",
                      ]
                      "type" = "object"
                    }
                    "revision" = {
                      "type" = "string"
                    }
                    "status" = {
                      "description" = "SyncStatusCode is a type which represents possible comparison results"
                      "type" = "string"
                    }
                  }
                  "required" = [
                    "status",
                  ]
                  "type" = "object"
                }
              }
              "type" = "object"
            }
          }
          "required" = [
            "metadata",
            "spec",
          ]
          "type" = "object"
        }
      }
      "version" = "v1alpha1"
      "versions" = [
        {
          "name" = "v1alpha1"
          "served" = true
          "storage" = true
        },
      ]
    }
  }
}
