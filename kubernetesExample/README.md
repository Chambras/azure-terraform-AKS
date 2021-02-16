# Kubernetes Provider with AKS

This is sample deployment that uses [Kubernetes terraform provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest) to deploy Nginx into AKS. It creates:

- A New Namespace (nginx by default).
- A Deployment.
- A Load Balancer service.

## Project Structure

This project has the following files which make them easy to reuse, add or remove.

```ssh
.
├── README.md
├── main.tf
└── variables.tf
```

Most common parameters are exposed as variables in _`variables.tf`_

## Pre-requisites

It is assumed that you have azure CLI and Terraform installed and configured.
More information on this topic [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure). I recommend using a Service Principal with a certificate.

It also assumes you have _`kubectl`_ installed and configured.
More information on this topic [here](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

### versions

- Terraform >= 0.14.6
- Azure provider 2.47.0
- Kubernetes Provider 2.0.2
- Azure CLI 2.19.1
- kubectl >= 1.18.15

## Authentication

This providers has multiple ways to authenticate with Kubernetes and you can take a look at them [here.](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#authentication)

This is specific example is using the Static TLS certificate credentials that are present in Azure AKS clusters by default, and can be used with the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) data source. This will automatically read the certificate information from the AKS cluster and pass it to the Kubernetes provider. More information [here](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/guides/getting-started#provider-setup).

## Usage

Just run these commands to initialize terraform, get a plan and approve it to apply it.

```ssh
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
```

I also recommend using a remote state instead of a local one. You can change this configuration in _`main.tf`_
You can create a free Terraform Cloud account [here](https://app.terraform.io).

Once the deployment completed you can execute the following command in order to configure kubectl to connect to your cluster.

```ssh
az aks get-credentials -g {{ResourceGroupName}} -n {{AKSClusterName}}
```

once executed you should be able to interact with the cluster using `kubectl`

```ssh
kubectl get nodes -n nginx
```

This command will give you the EXTERNAL-IP that you can use to test it. You should see the Nginx Welcome screen.

```ssh
kubecetl get services -n nginx

NAME    TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)        AGE
nginx   LoadBalancer   10.0.96.217   52.177.31.62   80:32714/TCP   102m

```

## Clean resources

It will destroy everything that was created.

```ssh
terraform destroy --force
```

## Caution

Be aware that by running this script your account might get billed.

## Authors

- Marcelo Zambrana
