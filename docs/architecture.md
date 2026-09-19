\# Azure Home Assignment



\## Purpose and Scope



\## Architecture Overview



The environment consists of:



\- Azure Resource Group

\- Virtual Network

\- Management Subnet

\- Application Subnet

\- Network Security Group

\- Ubuntu Linux Virtual Machine

\- Azure Storage Account

\- Log Analytics Workspace

\- Azure Monitor

\- Alert Rules





\## Resource Inventory



| Resource Type | Purpose |

|---------------|---------|

| Resource Group | Logical container for all resources |

| Virtual Network | Network isolation |

| Management Subnet | Dedicated subnet for management resources |

| Application Subnet | Hosts application workload |

| Network Security Group | Traffic filtering and access control |

| Ubuntu Virtual Machine | Application server |

| Storage Account | Storage services and Terraform state |

| Log Analytics Workspace | Centralized logging |

| Azure Monitor | Monitoring and alerting |

| Alert Rules | Infrastructure notifications |



| Resource Type | Resource Name | Purpose |

|--------------|--------------|----------|

| Resource Group | rg-azure-home-assignment | Logical resource container |

| Virtual Network | vnet-azure-home-assignment | Network isolation |

| Management Subnet | snet-management | Future management resources |

| Application Subnet | snet-application | Application workload |

| Network Security Group | nsg-application | Traffic filtering |

| Virtual Machine | vm-app-01 | Ubuntu application server |

| Storage Account | stazurehomeassign01 | Secure storage services |

| Log Analytics Workspace | law-azure-home-assignment |





\## Networking



Virtual Network:

\- Name: vnet-azure-home-assignment

\- Address Space: 10.0.0.0/16



Subnets:

\- snet-management (10.0.1.0/24)

\- snet-application (10.0.2.0/24)



Network Security Group:

\- nsg-application

\- Associated with snet-application



Security Rules:

\- SSH (TCP/22) allowed only from a trusted public IP address

\- Default Azure NSG deny rules applied for all other inbound traffic



The VM is deployed in the Application subnet. The Management subnet is reserved for future management resources.





\## Security



\- Network Security Group (NSG) will be used to control inbound and outbound traffic.

\- The virtual machine will be deployed in the Application subnet.

\- SSH access will not be open to the entire Internet.

\- Administrative access will be restricted to trusted source IP addresses.

\- Storage Account will use HTTPS-only access.

\- Public access to storage will be disabled.

\- SSH access is restricted to a trusted public IP address using Network Security Group rules.

\- SSH access is not exposed to the entire Internet.

\- Public IP address is used only for assignment administration and demonstration purposes.

\- In a production environment, Azure Bastion or private connectivity would be preferred.



\### Design Decisions



The solution was designed to be simple, secure and cost-conscious while meeting the assignment requirements.



Key design decisions:



\- A dedicated Resource Group is used to isolate all assignment resources.

\- Two subnets are implemented to provide basic network segmentation between management and application resources.

\- Ubuntu Linux was selected as the required workload platform.

\- A Public IP address is used only to simplify administrative access during the assignment.

\- SSH access is restricted to trusted source IP addresses using Network Security Group rules.

\- Azure Storage Account is configured with secure transfer enabled and public access disabled.

\- Locally Redundant Storage (LRS) was selected as a cost-effective redundancy option suitable for a non-critical demonstration environment.

\- Log Analytics Workspace and Azure Monitor provide centralized logging and monitoring.

\- Infrastructure alerts are configured to detect high CPU utilization and VM availability issues.

\- Terraform is used to provide repeatable infrastructure deployment.



\## Monitoring and Alerting



Monitoring components:



\- Azure Monitor

\- Log Analytics Workspace (law-azure-home-assignment)

\- VM Insights enabled for vm-app-01



Configured Alerts



1\. HighCPUAlert

&#x20;  - Trigger: CPU utilization greater than 80%

&#x20;  - Severity: Warning



2\. VM Availability Alert

&#x20;  - Trigger: VM availability metric below 1

&#x20;  - Severity: Informational



Alert notifications are delivered through Azure Monitor Action Groups to the configured email address.



\## Deployment Approach



\## CI/CD



\## Rebuild Procedure



\## Storage



Storage Account:

\- Name: stazurehomeassign01

\- Performance: Standard

\- Redundancy: LRS (Locally Redundant Storage)

\- Access Tier: Hot

\- Minimum TLS Version: 1.2

\- Secure Transfer Required: Enabled

\- Anonymous Public Access: Disabled



LRS was selected as a cost-effective redundancy option suitable for a non-critical demonstration environment.

