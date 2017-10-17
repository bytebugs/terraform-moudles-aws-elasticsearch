# Terraform Setup

Each developer will need to execute the following command before attempting to compile:

`terraform init`

This command ensures that the s3 backend for the state files is initialised and that there is a lock table associated with each. 

# Terraform components

## Outputs

Every resource that requires access to part of another component's state will require that the source component has that value exported in the outputs.tf file.

