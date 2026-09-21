\# Azure Home Assignment



\## Technical Architecture Document



\## 1. Purpose and Scope



This document describes a small Azure environment designed for an internal business application. The solution demonstrates practical cloud engineering across infrastructure design, deployment, security, monitoring, alerting, and Infrastructure as Code.



The environment is intentionally limited to one Ubuntu Linux virtual machine and the minimum supporting Azure services required by the assignment. The design is simple, secure, cost-conscious, and repeatable through Terraform.



The implemented solution includes:



\- A dedicated Azure Resource Group

\- One Azure Virtual Network with two subnets

\- One Ubuntu Linux virtual machine in the Application subnet

\- One Network Security Group associated with the Application subnet

\- Restricted SSH access from a trusted public IP address

\- One Azure Storage Account

\- One Log Analytics Workspace

\- Azure Monitor platform metrics

\- Two Azure Monitor metric alerts

\- One Action Group for email notifications

\- Terraform configuration for deployment and cleanup



Application installation, high availability, load balancing, autoscaling, Azure Firewall, VPN connectivity, Azure Bastion, and guest operating system log ingestion are outside the implemented scope.



\---



\## 2. Architecture Overview



All workload resources are deployed in Sweden Central. The Resource Group metadata location is West Europe; this does not affect the runtime location of the resources contained in the Resource Group.



The environment uses the Virtual Network `vnet-azure-home-assignment` with address space `10.0.0.0/16`.



The Virtual Network contains:



\- `snet-management`, using `10.0.1.0/24`

\- `snet-application`, using `10.0.2.0/24`



The virtual machine `vm-app-01` is deployed in `snet-application`. The `snet-management` subnet is reserved for future management services.



The Network Security Group `nsg-application` is associated with `snet-application`. SSH access to the virtual machine is permitted only from a trusted public IP address.



The Storage Account allows network access from both subnets through `Microsoft.Storage` service endpoints and Storage Account network rules.



Azure Monitor platform metrics are used for CPU and virtual machine availability monitoring. The Log Analytics Workspace is provisioned as the centralized monitoring workspace. Guest operating system log ingestion is not configured in the current Terraform deployment.



The architecture diagram is stored separately as:



```text

docs/architecture-diagram.png

```



\---



\## 3. Resource Inventory



| Resource Type | Resource Name | Purpose |

|---|---|---|

| Resource Group | `rg-azure-home-assignment` | Logical container for assignment resources |

| Virtual Network | `vnet-azure-home-assignment` | Network boundary using `10.0.0.0/16` |

| Management Subnet | `snet-management` | Reserved management subnet using `10.0.1.0/24` |

| Application Subnet | `snet-application` | Hosts the Ubuntu virtual machine using `10.0.2.0/24` |

| Network Security Group | `nsg-application` | Protects the Application subnet |

| Public IP Address | `vm-app-01-ip` | Controlled administrative access for the assignment |

| Network Interface | `vm-app-01480` | Connects the virtual machine to the Application subnet |

| Linux Virtual Machine | `vm-app-01` | Ubuntu application server |

| Storage Account | `stazurehomeassign01` | Secure Azure Storage service |

| Log Analytics Workspace | `law-azure-home-assignment` | Central monitoring workspace |

| Action Group | `ag-home-assignment` | Sends alert notifications by email |

| Metric Alert | `HighCPUAlert` | Detects sustained high CPU utilization |

| Metric Alert | `VM Availability - vm-app-01` | Detects virtual machine availability problems |



Azure Storage Account names must be globally unique. If `stazurehomeassign01` is unavailable during a rebuild, another valid lowercase alphanumeric value must be supplied through Terraform.



\---



\## 4. Networking



\### 4.1 Virtual Network and Subnets



| Network Component | Address Space | Usage |

|---|---|---|

| Virtual Network | `10.0.0.0/16` | Address space for the assignment |

| Management Subnet | `10.0.1.0/24` | Reserved for future management services |

| Application Subnet | `10.0.2.0/24` | Hosts `vm-app-01` |



Both subnets have the `Microsoft.Storage` service endpoint enabled. The Storage Account network rules explicitly allow both subnet IDs.



\### 4.2 Network Security Group



The Network Security Group `nsg-application` is associated with `snet-application`.



The implemented custom rule is:



| Direction | Rule | Source | Destination | Protocol and Port | Action |

|---|---|---|---|---|---|

| Inbound | `Allow-SSH-Home` | Trusted public IP `/32` | Application subnet | TCP/22 | Allow |



Azure default NSG rules remain enabled. These include default virtual network and Azure Load Balancer inbound rules, a final inbound deny rule, and the standard Azure outbound rules.



No custom outbound NSG rule was added in the final Terraform configuration. Outbound connectivity therefore follows the Azure default NSG rules.



\### 4.3 Public IP Decision



A Public IP address is used to simplify administration and deployment validation during the assignment. SSH is not exposed to the entire Internet; access is limited to a trusted `/32` public IP address through the NSG.



For a production environment, direct public SSH access should be replaced by Azure Bastion, VPN-based private connectivity, or a controlled management host.



\---



\## 5. Compute



The application workload runs on one Ubuntu Linux virtual machine.



| Setting | Configuration |

|---|---|

| Name | `vm-app-01` |

| Operating System | Ubuntu Server 24.04 LTS |

| VM Size | `Standard\_B2ats\_v2` |

| Administrator Username | `azureuser` |

| Authentication | SSH public key |

| Password Authentication | Disabled |

| OS Disk | Standard LRS |

| Subnet | `snet-application` |

| Boot Diagnostics | Azure-managed storage |



Terraform places the SSH public key on the virtual machine. The corresponding private `.pem` key is stored outside the repository and is never committed to Git.



\---



\## 6. Security



The following controls are implemented:



\- Password authentication is disabled on the Linux virtual machine.

\- SSH public key authentication is required.

\- SSH access is restricted to one trusted source IP address.

\- The Application subnet is protected by `nsg-application`.

\- The Storage Account requires HTTPS and TLS 1.2.

\- Anonymous Blob access is disabled.

\- Storage network access uses a default-deny configuration.

\- Storage access is allowed from `snet-management` and `snet-application`.

\- Microsoft-managed encryption keys provide encryption at rest.

\- `terraform.tfvars`, Terraform state files, and private SSH keys are excluded from Git.

\- Environment-specific values are supplied locally rather than committed to the public repository.



\---



\## 7. Storage



| Setting | Configuration | Rationale |

|---|---|---|

| Performance Tier | Standard | Suitable for a small non-performance-critical workload |

| Redundancy | Locally Redundant Storage | Cost-conscious redundancy for a demonstration environment |

| Access Tier | Hot | Appropriate for frequently accessible assignment data |

| Secure Transfer | Required | Rejects non-HTTPS requests |

| Minimum TLS | TLS 1.2 | Enforces a modern transport security baseline |

| Anonymous Access | Disabled | Prevents anonymous public Blob access |

| Public Network Access | Enabled with restrictions | Required for the public Storage endpoint while firewall rules restrict sources |

| Default Network Action | Deny | Blocks sources not explicitly allowed |

| Allowed Networks | Both configured subnets | Permits access from the Management and Application subnets |

| Encryption Keys | Microsoft-managed | Reduces complexity while retaining encryption at rest |



LRS was selected because the assignment is a small, non-critical environment and prioritizes cost and simplicity. A production implementation should reassess recovery and availability requirements and consider zone-redundant or geo-redundant Storage where required.



\---



\## 8. Monitoring and Alerting



Azure Monitor provides platform metrics and alert evaluation. The Log Analytics Workspace `law-azure-home-assignment` is provisioned as the centralized monitoring workspace.



The current Terraform deployment does not install Azure Monitor Agent or configure a Data Collection Rule. Therefore, the architecture does not claim Linux guest operating system log ingestion. The implemented alerts use Azure platform metrics.



\### 8.1 Action Group



| Setting | Configuration |

|---|---|

| Name | `ag-home-assignment` |

| Short Name | `VMAlerts` |

| Notification Method | Email |

| Common Alert Schema | Enabled |



The email address is provided through the ignored local `terraform.tfvars` file.



\### 8.2 Alert Rules



| Alert | Condition | Evaluation | Severity | Notification |

|---|---|---|---|---|

| `HighCPUAlert` | Average `Percentage CPU` greater than 80 | Every 1 minute over a 5-minute window | 2 | Email through `ag-home-assignment` |

| `VM Availability - vm-app-01` | Average `VmAvailabilityMetric` less than 1 | Every 1 minute over a 5-minute window | 3 | Email through `ag-home-assignment` |



The High CPU alert highlights sustained resource utilization, while the VM Availability alert identifies availability problems. Thresholds should be reviewed and tuned before production use.



\---



\## 9. Infrastructure as Code



Terraform is the authoritative deployment method for the final environment.



The Terraform configuration includes:



\- Resource Group

\- Virtual Network

\- Two subnets

\- Storage service endpoints

\- Network Security Group

\- Restricted SSH rule

\- NSG and subnet association

\- Public IP address

\- Network interface

\- Ubuntu Linux virtual machine

\- Storage Account and network rules

\- Log Analytics Workspace

\- Action Group

\- High CPU alert

\- VM Availability alert

\- Terraform outputs



The Terraform configuration was successfully:



\- formatted with `terraform fmt`

\- validated with `terraform validate`

\- reviewed with `terraform plan`

\- deployed with `terraform apply`



The successful deployment returned `Apply complete` and Terraform outputs for the Resource Group, Virtual Network, Storage Account, Log Analytics Workspace, virtual machine, and public IP address.



\### 9.1 Repository Structure



```text

azure-home-assignment/

├── README.md

├── .gitignore

├── docs/

│   ├── architecture.md

│   ├── Azure\_Home\_Assignment\_Technical\_Architecture\_Final.docx

│   ├── architecture-diagram.png

│   └── evidence/

└── terraform/

&#x20;   ├── versions.tf

&#x20;   ├── provider.tf

&#x20;   ├── variables.tf

&#x20;   ├── main.tf

&#x20;   └── outputs.tf

```



\### 9.2 Local Configuration and State



The local `terraform.tfvars` file supplies:



\- Trusted SSH source IP address

\- Globally unique Storage Account name

\- SSH public-key path

\- Alert notification email address



The file is excluded from Git.



The Terraform state is stored locally for this assignment and is also excluded from Git. A production team deployment should use a protected remote backend with state locking.



\---



\## 10. Deployment, Validation, and Cleanup



\### 10.1 Deployment



```bash

az login

terraform init

terraform fmt

terraform validate

terraform plan

terraform apply

```



Before applying, the operator must verify the selected Azure subscription, local variable values, unique Storage Account name, trusted source IP address, and SSH public-key path.



\### 10.2 Validation



The deployment is validated by confirming:



\- The Resource Group and expected resources exist.

\- Both subnets use the expected address prefixes.

\- The NSG is associated with the Application subnet.

\- SSH access is restricted to the trusted source IP.

\- The Ubuntu virtual machine is running.

\- SSH login works with the corresponding private key.

\- The Storage Account uses LRS, HTTPS, TLS 1.2, and disabled anonymous access.

\- Storage network rules allow both configured subnets.

\- The Log Analytics Workspace exists.

\- Both Azure Monitor alert rules are enabled.

\- The Action Group contains the email receiver.



Example SSH command:



```powershell

ssh -i C:\\Keys\\vm-app-01\_key.pem azureuser@<public-ip-address>

```



Terraform outputs can be reviewed with:



```bash

terraform output

```



\### 10.3 Cleanup and Rebuild



The environment can be removed with:



```bash

terraform destroy

```



The same Terraform configuration can rebuild the environment with:



```bash

terraform plan

terraform apply

```



The Storage Account name must remain globally unique, and the trusted source IP may need to be updated when deployment is performed from another network.



\---



\## 11. Deployment Evidence



The `docs/evidence` folder should contain a small, focused evidence set:



\- Successful `terraform validate`

\- Successful `terraform apply` showing `Apply complete`

\- Terraform outputs

\- Azure Resource Group overview after deployment

\- Virtual Network and subnet configuration

\- NSG rule showing restricted SSH

\- Storage security and network configuration

\- Virtual machine overview

\- Successful SSH session

\- Log Analytics Workspace

\- Both Azure Monitor alert rules



Evidence must not expose subscription IDs, tenant IDs, email addresses, trusted public IP addresses, SSH keys, Storage access keys, connection strings, or Terraform state content.



\---



\## 12. Production Improvements



For a production implementation, consider:



\- Removing the direct VM Public IP

\- Using Azure Bastion or private VPN connectivity

\- Using a remote Terraform backend with state locking

\- Adding resource tags and governance policies

\- Adding backup and recovery controls

\- Reviewing availability and Storage redundancy requirements

\- Adding Azure Monitor Agent and Data Collection Rules if guest OS or application logs are required

\- Separating development, test, and production environments

