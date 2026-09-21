## SSH Authentication

The virtual machine uses SSH key-based authentication.

The SSH public key is stored locally on the deployment workstation and is referenced during Terraform deployment:

```text
C:\Keys\vm-app-01_key.pub