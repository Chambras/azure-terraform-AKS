# Azure Kubernetes Service - AKS

It creates:

* A new Resource Group.
* A VNet with 2 subnets.
* A Route table.
* An AKS Cluster.

## Project Structure

This project has the following files which make them easy to reuse, add or remove.

```ssh
.
├── LICENSE
├── README.md
├── aks.tf
├── main.tf
├── networking.tf
├── outputs.tf
└── variables.tf
```

Most common paremeters are exposed as variables in _`variables.tf`_
In order to get supported k8s versions by region you can use this command

```ssh
az aks get-versions -l {{location}}
```

## Pre-requisites

It is assumed that you have azure CLI and Terraform installed and configured.
More information on this topic [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure). I recommend using a Service Principal with a certificate.

### versions

* Terraform =>0.12.16
* Azure provider 1.37.0
* Azure CLI 2.0.77

### Service Principal

AKS also requires a sesrvice principal in order to manage the cluster. It is assumed that you already have a Service Principal already created and you can configure those using `kubernetes_client_id` and `kubernetes_client_secret` located in _`variables.tf`_.

You can create a Service Principal using the following command

```ssh
az ad sp create-for-rbac --name {{SP_NAME}} --skip-assignment
```

More information about AKS Service Principal can be found [here](https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal).

> ### Warning: Sensitive Data
>
> It is not recommended to store secrets in terraform scripts. [Read more information about sensitive data](https://www.terraform.io/docs/state/sensitive-data.html).

## Authentication

It uses key based authentication and it assumes you already have a key and you can configure the path using the _sshKeyPath_ variable in _`variables.tf`_ You can create one using this command:

```ssh
ssh-keygen -t rsa -b 4096 -m PEM -C vm@mydomain.com -f ~/.ssh/vm_ssh
```

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

Once the cluster is up and running you can execute the following command in order to configure kubectl to connect to your cluster.

```ssh
az aks get-credentials -g {{ResourceGroupName}} -n {{AKSClusterName}}
```

once executed you should be able to interact with thte cluster usng `kubectl`

```ssh
kubectl get nodes
```

## Clean resources

It will destroy everything that was created.

```ssh
terraform destroy --force
```

## Caution

Be aware that by running this script your account might get billed.

## Authors

* Marcelo Zambrana
