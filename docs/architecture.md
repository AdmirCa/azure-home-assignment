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



\## Networking



Virtual Network:

\- Address Space: 10.0.0.0/16



Subnets:

\- Management Subnet: 10.0.1.0/24

\- Application Subnet: 10.0.2.0/24



\## Security



\- Network Security Group (NSG) will be used to control inbound and outbound traffic.

\- The virtual machine will be deployed in the Application subnet.

\- SSH access will not be open to the entire Internet.

\- Administrative access will be restricted to trusted source IP addresses.

\- Storage Account will use HTTPS-only access.

\- Public access to storage will be disabled.



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



\## Deployment Approach



\## CI/CD



\## Rebuild Procedure

