# azure-home-assignment

Production-oriented Azure infrastructure deployment using Terraform, Azure Monitor, Log Analytics and GitHub Actions.



\# Azure Home Assignment



\## Overview



This project demonstrates the deployment of a simple, secure and cost-conscious Azure environment using Infrastructure as Code (Terraform).



The environment includes:



\- Resource Group

\- Virtual Network

\- Management Subnet

\- Application Subnet

\- Network Security Group

\- Ubuntu Linux Virtual Machine

\- Azure Storage Account

\- Log Analytics Workspace

\- Azure Monitor

\- Infrastructure Alerts



\## Architecture



The environment contains:



\- vnet-azure-home-assignment

\- snet-management

\- snet-application

\- nsg-application

\- vm-app-01

\- stazurehomeassign01

\- law-azure-home-assignment



\## Prerequisites



The following tools are required:



\- Azure Subscription

\- Terraform 1.6+

\- Azure CLI

\- Git



\## Azure Authentication



Login to Azure:



```bash

az login

