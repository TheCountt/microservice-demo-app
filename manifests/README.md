# Kubernetes manifests

Create the kubernetes objects in this order:

- storageclass.yml
- secret.yml (this is for experimental purposes only, never save secrets in version control)
- mongo-statefulset.yml
- configmap.yml (this is for experimental purposes only, never save configmap in version control)
- mern-app.yml

Statefulset object is best to run stateful applications such as databases,etc.

**NOTE**: Consult K8S documentation for more information on various objects and its fields and how they can be used.
