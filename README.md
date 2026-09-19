# Azure Home Assignment

## Overview

This project demonstrates the deployment of a secure and cost-conscious Azure environment using Terraform.

The solution includes:

- Resource Group
- Virtual Network
- Management Subnet
- Application Subnet
- Network Security Group
- Ubuntu Linux Virtual Machine
- Storage Account (LRS)
- Log Analytics Workspace
- Azure Monitor
- Action Group
- High CPU Alert
- VM Availability Alert

## Architecture

### Components

| Resource Type | Resource Name |
|--------------|--------------|
| Resource Group | rg-azure-home-assignment |
| Virtual Network | vnet-azure-home-assignment |
| Subnet | snet-management |
| Subnet | snet-application |
| Network Security Group | nsg-application |
| Virtual Machine | vm-app-01 |
| Public IP | vm-app-01-ip |
| Storage Account | stazurehomeassign01 |
| Log Analytics Workspace | law-azure-home-assignment |
| Action Group | ag-home-assignment |

## Security

- SSH access is restricted to a trusted public IP address.
- Password authentication is disabled.
- SSH key authentication is used.
- Storage Account access is restricted to designated virtual network subnets.
- TLS 1.2 is enforced.

## Monitoring

Monitoring services:

- Azure Monitor
- Log Analytics Workspace

Configured alerts:

### HighCPUAlert

- Metric: Percentage CPU
- Operator: Greater Than
- Threshold: 80%
- Evaluation Frequency: 1 minute
- Window Size: 5 minutes

### VM Availability Alert

- Metric: VmAvailabilityMetric
- Operator: Less Than
- Threshold: 1
- Evaluation Frequency: 1 minute
- Window Size: 5 minutes

## Terraform Structure

```text
terraform/
├── versions.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
└── main.tf