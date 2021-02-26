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

resource "kubernetes_manifest" "customresourcedefinition_appprojects_argoproj_io" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1beta1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "appprojects.argoproj.io"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "appprojects.argoproj.io"
    }
    "spec" = {
      "group" = "argoproj.io"
      "names" = {
        "kind" = "AppProject"
        "listKind" = "AppProjectList"
        "plural" = "appprojects"
        "shortNames" = [
          "appproj",
          "appprojs",
        ]
        "singular" = "appproject"
      }
      "scope" = "Namespaced"
      "validation" = {
        "openAPIV3Schema" = {
          "description" = "AppProject provides a logical grouping of applications, providing controls for: * where the apps may deploy to (cluster whitelist) * what may be deployed (repository whitelist, resource whitelist/blacklist) * who can access these applications (roles, OIDC group claims bindings) * and what they can do (RBAC policies) * automation access to these roles (JWT tokens)"
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
            "spec" = {
              "description" = "AppProjectSpec is the specification of an AppProject"
              "properties" = {
                "clusterResourceBlacklist" = {
                  "description" = "ClusterResourceBlacklist contains list of blacklisted cluster level resources"
                  "items" = {
                    "description" = "GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types"
                    "properties" = {
                      "group" = {
                        "type" = "string"
                      }
                      "kind" = {
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "group",
                      "kind",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "clusterResourceWhitelist" = {
                  "description" = "ClusterResourceWhitelist contains list of whitelisted cluster level resources"
                  "items" = {
                    "description" = "GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types"
                    "properties" = {
                      "group" = {
                        "type" = "string"
                      }
                      "kind" = {
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "group",
                      "kind",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "description" = {
                  "description" = "Description contains optional project description"
                  "type" = "string"
                }
                "destinations" = {
                  "description" = "Destinations contains list of destinations available for deployment"
                  "items" = {
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
                  "type" = "array"
                }
                "namespaceResourceBlacklist" = {
                  "description" = "NamespaceResourceBlacklist contains list of blacklisted namespace level resources"
                  "items" = {
                    "description" = "GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types"
                    "properties" = {
                      "group" = {
                        "type" = "string"
                      }
                      "kind" = {
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "group",
                      "kind",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "namespaceResourceWhitelist" = {
                  "description" = "NamespaceResourceWhitelist contains list of whitelisted namespace level resources"
                  "items" = {
                    "description" = "GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types"
                    "properties" = {
                      "group" = {
                        "type" = "string"
                      }
                      "kind" = {
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "group",
                      "kind",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "orphanedResources" = {
                  "description" = "OrphanedResources specifies if controller should monitor orphaned resources of apps in this project"
                  "properties" = {
                    "ignore" = {
                      "items" = {
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
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "warn" = {
                      "description" = "Warn indicates if warning condition should be created for apps which have orphaned resources"
                      "type" = "boolean"
                    }
                  }
                  "type" = "object"
                }
                "roles" = {
                  "description" = "Roles are user defined RBAC roles associated with this project"
                  "items" = {
                    "description" = "ProjectRole represents a role that has access to a project"
                    "properties" = {
                      "description" = {
                        "description" = "Description is a description of the role"
                        "type" = "string"
                      }
                      "groups" = {
                        "description" = "Groups are a list of OIDC group claims bound to this role"
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                      "jwtTokens" = {
                        "description" = "JWTTokens are a list of generated JWT tokens bound to this role"
                        "items" = {
                          "description" = "JWTToken holds the issuedAt and expiresAt values of a token"
                          "properties" = {
                            "exp" = {
                              "format" = "int64"
                              "type" = "integer"
                            }
                            "iat" = {
                              "format" = "int64"
                              "type" = "integer"
                            }
                            "id" = {
                              "type" = "string"
                            }
                          }
                          "required" = [
                            "iat",
                          ]
                          "type" = "object"
                        }
                        "type" = "array"
                      }
                      "name" = {
                        "description" = "Name is a name for this role"
                        "type" = "string"
                      }
                      "policies" = {
                        "description" = "Policies Stores a list of casbin formated strings that define access policies for the role in the project"
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                    }
                    "required" = [
                      "name",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "signatureKeys" = {
                  "description" = "List of PGP key IDs that commits to be synced to must be signed with"
                  "items" = {
                    "description" = "SignatureKey is the specification of a key required to verify commit signatures with"
                    "properties" = {
                      "keyID" = {
                        "description" = "The ID of the key in hexadecimal notation"
                        "type" = "string"
                      }
                    }
                    "required" = [
                      "keyID",
                    ]
                    "type" = "object"
                  }
                  "type" = "array"
                }
                "sourceRepos" = {
                  "description" = "SourceRepos contains list of repository URLs which can be used for deployment"
                  "items" = {
                    "type" = "string"
                  }
                  "type" = "array"
                }
                "syncWindows" = {
                  "description" = "SyncWindows controls when syncs can be run for apps in this project"
                  "items" = {
                    "description" = "SyncWindow contains the kind, time, duration and attributes that are used to assign the syncWindows to apps"
                    "properties" = {
                      "applications" = {
                        "description" = "Applications contains a list of applications that the window will apply to"
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                      "clusters" = {
                        "description" = "Clusters contains a list of clusters that the window will apply to"
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                      "duration" = {
                        "description" = "Duration is the amount of time the sync window will be open"
                        "type" = "string"
                      }
                      "kind" = {
                        "description" = "Kind defines if the window allows or blocks syncs"
                        "type" = "string"
                      }
                      "manualSync" = {
                        "description" = "ManualSync enables manual syncs when they would otherwise be blocked"
                        "type" = "boolean"
                      }
                      "namespaces" = {
                        "description" = "Namespaces contains a list of namespaces that the window will apply to"
                        "items" = {
                          "type" = "string"
                        }
                        "type" = "array"
                      }
                      "schedule" = {
                        "description" = "Schedule is the time the window will begin, specified in cron format"
                        "type" = "string"
                      }
                    }
                    "type" = "object"
                  }
                  "type" = "array"
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

resource "kubernetes_manifest" "serviceaccount_argocd_application_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "application-controller"
        "app.kubernetes.io/name" = "argocd-application-controller"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-application-controller"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name" = "argocd-dex-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-dex-server"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_argocd_redis" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/name" = "argocd-redis"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-redis"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
      "namespace" = "default"
    }
  }
}

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

resource "kubernetes_manifest" "role_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name" = "argocd-dex-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-dex-server"
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
          "get",
          "list",
          "watch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "role_argocd_redis" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/name" = "argocd-redis"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-redis"
      "namespace" = "default"
    }
    "rules" = [
      {
        "apiGroups" = [
          "security.openshift.io",
        ]
        "resourceNames" = [
          "nonroot",
        ]
        "resources" = [
          "securitycontextconstraints",
        ]
        "verbs" = [
          "use",
        ]
      },
    ]
  }
}

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

resource "kubernetes_manifest" "clusterrole_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
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
          "delete",
          "get",
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
          "list",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods",
          "pods/log",
        ]
        "verbs" = [
          "get",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_argocd_application_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "application-controller"
        "app.kubernetes.io/name" = "argocd-application-controller"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-application-controller"
      "namespace" = "default"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "argocd-application-controller"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-application-controller"
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name" = "argocd-dex-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-dex-server"
      "namespace" = "default"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "argocd-dex-server"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-dex-server"
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_argocd_redis" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/name" = "argocd-redis"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-redis"
      "namespace" = "default"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "argocd-redis"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-redis"
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
      "namespace" = "default"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "argocd-server"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-server"
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_argocd_application_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "application-controller"
        "app.kubernetes.io/name" = "argocd-application-controller"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-application-controller"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "argocd-application-controller"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-application-controller"
        "namespace" = "argocd"
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "argocd-server"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "argocd-server"
        "namespace" = "argocd"
      },
    ]
  }
}

resource "kubernetes_manifest" "configmap_argocd_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-cm"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "configmap_argocd_gpg_keys_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-gpg-keys-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-gpg-keys-cm"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "configmap_argocd_rbac_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-rbac-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-rbac-cm"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "configmap_argocd_ssh_known_hosts_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "ssh_known_hosts" = "bitbucket.org ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==\ngithub.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==\ngitlab.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFSMqzJeV9rUzU4kWitGjeR4PWSa29SPqJ1fVkhtj3Hw9xjLVXVYrU9QlYWrOLXBpQ6KWjbjTDTdDkoohFzgbEY=\ngitlab.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf\ngitlab.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsj2bNKTBSpIYDEGk9KxsGh3mySTRgMtXL583qmBpzeQ+jqCMRgBqB98u3z++J1sKlXHWfM9dyhSevkMwSbhoR8XIq/U0tCNyokEi/ueaBMCvbcTHhO7FcwzY92WK4Yt0aGROY5qX2UKSeOvuP4D6TPqKF1onrSzH9bx9XUf2lEdWT/ia1NEKjunUqu1xOB/StKDHMoX4/OKyIzuS0q/T1zOATthvasJFoPrAjkohTyaDUz2LN5JoH839hViyEG82yB+MjcFV5MU3N1l1QL3cVUCh93xSaua1N85qivl+siMkPGbO5xR/En4iEY6K2XPASUEMaieWVNTRCtJ4S8H+9\nssh.dev.azure.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7Hr1oTWqNqOlzGJOfGJ4NakVyIzf1rXYd4d7wo6jBlkLvCA4odBlL0mDUyZ0/QUfTTqeu+tm22gOsv+VrVTMk6vwRU75gY/y9ut5Mb3bR5BV58dKXyq9A9UeB5Cakehn5Zgm6x1mKoVyf+FFn26iYqXJRgzIZZcZ5V6hrE0Qg39kZm4az48o0AUbf6Sp4SLdvnuMa2sVNwHBboS7EJkm57XQPVU3/QpyNLHbWDdzwtrlS+ez30S3AdYhLKEOxAG8weOnyrtLJAUen9mTkol8oII1edf7mWWbWVf0nBmly21+nZcmCTISQBtdcyPaEno7fFQMDD26/s0lfKob4Kw8H\nvs-ssh.visualstudio.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7Hr1oTWqNqOlzGJOfGJ4NakVyIzf1rXYd4d7wo6jBlkLvCA4odBlL0mDUyZ0/QUfTTqeu+tm22gOsv+VrVTMk6vwRU75gY/y9ut5Mb3bR5BV58dKXyq9A9UeB5Cakehn5Zgm6x1mKoVyf+FFn26iYqXJRgzIZZcZ5V6hrE0Qg39kZm4az48o0AUbf6Sp4SLdvnuMa2sVNwHBboS7EJkm57XQPVU3/QpyNLHbWDdzwtrlS+ez30S3AdYhLKEOxAG8weOnyrtLJAUen9mTkol8oII1edf7mWWbWVf0nBmly21+nZcmCTISQBtdcyPaEno7fFQMDD26/s0lfKob4Kw8H\n"
    }
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-ssh-known-hosts-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-ssh-known-hosts-cm"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "configmap_argocd_tls_certs_cm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "data" = null
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-tls-certs-cm"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-tls-certs-cm"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "secret_argocd_secret" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/name" = "argocd-secret"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-secret"
      "namespace" = "default"
    }
    "type" = "Opaque"
  }
}

resource "kubernetes_manifest" "service_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name" = "argocd-dex-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-dex-server"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 5556
          "protocol" = "TCP"
          "targetPort" = 5556
        },
        {
          "name" = "grpc"
          "port" = 5557
          "protocol" = "TCP"
          "targetPort" = 5557
        },
        {
          "name" = "metrics"
          "port" = 5558
          "protocol" = "TCP"
          "targetPort" = 5558
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-dex-server"
      }
    }
  }
}

resource "kubernetes_manifest" "service_argocd_metrics" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "metrics"
        "app.kubernetes.io/name" = "argocd-metrics"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-metrics"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "metrics"
          "port" = 8082
          "protocol" = "TCP"
          "targetPort" = 8082
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-application-controller"
      }
    }
  }
}

resource "kubernetes_manifest" "service_argocd_redis" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
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
      "ports" = [
        {
          "protocol" = "TCP"
          "name" = "tcp-redis"
          "port" = 6379
          "targetPort" = 6379
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-redis"
      }
    }
  }
}

resource "kubernetes_manifest" "service_argocd_repo_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "repo-server"
        "app.kubernetes.io/name" = "argocd-repo-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-repo-server"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "server"
          "port" = 8081
          "protocol" = "TCP"
          "targetPort" = 8081
        },
        {
          "name" = "metrics"
          "port" = 8084
          "protocol" = "TCP"
          "targetPort" = 8084
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-repo-server"
      }
    }
  }
}

resource "kubernetes_manifest" "service_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 80
          "protocol" = "TCP"
          "targetPort" = 8080
        },
        {
          "name" = "https"
          "port" = 443
          "protocol" = "TCP"
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-server"
      }
    }
  }
}

resource "kubernetes_manifest" "service_argocd_server_metrics" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server-metrics"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server-metrics"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "metrics"
          "port" = 8083
          "protocol" = "TCP"
          "targetPort" = 8083
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "argocd-server"
      }
    }
  }
}

resource "kubernetes_manifest" "deployment_argocd_dex_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "dex-server"
        "app.kubernetes.io/name" = "argocd-dex-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-dex-server"
      "namespace" = "default"
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
              "image" = "ghcr.io/dexidp/dex:v2.27.0"
              "imagePullPolicy" = "Always"
              "name" = "dex"
              "ports" = [
                {
		"protocol" = "TCP"
                  "containerPort" = 5556
                },
                {
"protocol" = "TCP"
                  "containerPort" = 5557
                },
                {
"protocol" = "TCP"
                  "containerPort" = 5558
                },
              ]
              "volumeMounts" = [
                {
                  "mountPath" = "/shared"
                  "name" = "static-files"
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
              "image" = "argoproj/argocd:v1.8.4"
              "imagePullPolicy" = "Always"
              "name" = "copyutil"
              "volumeMounts" = [
                {
                  "mountPath" = "/shared"
                  "name" = "static-files"
                },
              ]
            },
          ]
          "serviceAccountName" = "argocd-dex-server"
          "volumes" = [
            {
              "emptyDir" = {}
              "name" = "static-files"
            },
          ]
        }
      }
    }
  }
}

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

resource "kubernetes_manifest" "deployment_argocd_repo_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "repo-server"
        "app.kubernetes.io/name" = "argocd-repo-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-repo-server"
      "namespace" = "default"
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
              "image" = "argoproj/argocd:v1.8.4"
              "imagePullPolicy" = "Always"
              "livenessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/healthz?full=true"
                  "port" = 8084
                }
                "initialDelaySeconds" = 30
                "periodSeconds" = 5
              }
              "name" = "argocd-repo-server"
              "ports" = [
                {
"protocol" = "TCP"
                  "containerPort" = 8081
                },
                {
"protocol" = "TCP"
                  "containerPort" = 8084
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 8084
                }
                "initialDelaySeconds" = 5
                "periodSeconds" = 10
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/app/config/ssh"
                  "name" = "ssh-known-hosts"
                },
                {
                  "mountPath" = "/app/config/tls"
                  "name" = "tls-certs"
                },
                {
                  "mountPath" = "/app/config/gpg/source"
                  "name" = "gpg-keys"
                },
                {
                  "mountPath" = "/app/config/gpg/keys"
                  "name" = "gpg-keyring"
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
              "name" = "gpg-keyring"
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "deployment_argocd_server" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "server"
        "app.kubernetes.io/name" = "argocd-server"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-server"
      "namespace" = "default"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "argocd-server"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/name" = "argocd-server"
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
                        "app.kubernetes.io/name" = "argocd-server"
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
              "command" = [
                "argocd-server",
                "--staticassets",
                "/shared/app",
              ]
              "image" = "argoproj/argocd:v1.8.4"
              "imagePullPolicy" = "Always"
              "livenessProbe" = {
                "httpGet" = {
                  "path" = "/healthz?full=true"
                  "port" = 8080
                }
                "initialDelaySeconds" = 3
                "periodSeconds" = 30
              }
              "name" = "argocd-server"
              "ports" = [
                {
"protocol" = "TCP"
                  "containerPort" = 8080
                },
                {
"protocol" = "TCP"
                  "containerPort" = 8083
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 8080
                }
                "initialDelaySeconds" = 3
                "periodSeconds" = 30
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/app/config/ssh"
                  "name" = "ssh-known-hosts"
                },
                {
                  "mountPath" = "/app/config/tls"
                  "name" = "tls-certs"
                },
              ]
            },
          ]
          "serviceAccountName" = "argocd-server"
          "volumes" = [
            {
              "emptyDir" = {}
              "name" = "static-files"
            },
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
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "statefulset_argocd_application_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "StatefulSet"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "application-controller"
        "app.kubernetes.io/name" = "argocd-application-controller"
        "app.kubernetes.io/part-of" = "argocd"
      }
      "name" = "argocd-application-controller"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "argocd-application-controller"
        }
      }
      "serviceName" = "argocd-application-controller"
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/name" = "argocd-application-controller"
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
                        "app.kubernetes.io/name" = "argocd-application-controller"
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
              "command" = [
                "argocd-application-controller",
                "--status-processors",
                "20",
                "--operation-processors",
                "10",
              ]
              "image" = "argoproj/argocd:v1.8.4"
              "imagePullPolicy" = "Always"
              "livenessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 8082
                }
                "initialDelaySeconds" = 5
                "periodSeconds" = 10
              }
              "name" = "argocd-application-controller"
              "ports" = [
                {
"protocol" = "TCP"
                  "containerPort" = 8082
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = 8082
                }
                "initialDelaySeconds" = 5
                "periodSeconds" = 10
              }
            },
          ]
          "serviceAccountName" = "argocd-application-controller"
        }
      }
    }
  }
}