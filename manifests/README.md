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

# Deployment of the Microservice Application(using Ingress)

Create the kubernetes objects in this order:

- storageclass.yml

- secret.yml (this is for experimental purposes only, never save secrets in version control)

- mongo-statefulset.yml

- configmap.yml (this is for experimental purposes only, never save configmap in version control)

- mern-app.yml ( IF you want to use an Ingress object, youd should set the **spec.type** to *ClusterIP* for the Service object )

Statefulset object is best to run stateful applications such as databases,etc.

**NOTE**: Consult K8S documentation for more information on various objects and its fields and how they can be used.

## To use Ingress

- Make sure you have already have a domain name(You can buy from any domain registrar)


- Create an Ingress Controller. You can research on the best one( nginx ingress controller was used here)

**Note: If you have a ValidatingWebhookConfiguration blocker, delete the webhook(kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission)**

- Map the IP or Hostname/Address of the Ingress Controller to the domain name on the domain registrar portal/website. Choose A records for IP and CNAME records for Hostname/Address such as name of loadbalancer

- Create an Ingress object
