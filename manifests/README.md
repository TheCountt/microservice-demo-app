# Implementing RBAC on K8S cluster

## Pre-requisites

- Created IAM User Groups with IaC with group users included in the K8S infra code (check **aws-terraform/terraform/iam.tf**)

### Steps

- Enable k8s RBAC on the IAM Groups

- Create a Namespace (***Development***, in this case, was created) for developers

- Scope IAM Developer User Group  to ***Development*** namespace so that group
users can only deploy workloads in the ***Development*** namespace

- Generate a kubeconfig file  so that Group users will be able to connect to the
clusters and perform operations they have permissions for.


# Set Resource Quotas on Namespace(s)

For more information, consult the Kubernetes Documentation.

# Deployment of the Microservice Application

Create the kubernetes objects in this order:

- storageclass.yml

- secret.yml (this is for experimental purposes only, never save secrets in version control)

- mongo-statefulset.yml

- configmap.yml (this is for experimental purposes only, never save configmap in version control)

- mern-app.yml

Statefulset object is best to run stateful applications such as databases,etc.

**NOTE**: Consult K8S documentation for more information on various objects and its fields and how they can be used.
