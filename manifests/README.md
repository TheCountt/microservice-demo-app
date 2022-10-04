## Kubernetes manifests

Create the kubernetes objects in this order:

- storageclass.yml
- mongodb-statefulset.yml
- configmap.yml
- mern-app.yml

Statefulset object is best to run stateful applications such as databases,etc.

**NOTE**: Consult K8S documentation for more information on various objects and its fields and how they can be used.
