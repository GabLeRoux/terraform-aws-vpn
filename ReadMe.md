# Terraform vpn setup for AWS

![graph](./graph.svg)

## Getting Started

* [Terraform documentation](https://www.terraform.io/docs/)
* [Setup aws using env vars](https://www.terraform.io/docs/providers/aws/index.html#environment-variables)

### Init terraform

```bash
terraform init
```

### See what's going to be applied

```bash
terraform plan
```

### Apply the changes

```bash
terraform apply
```

### Generate a graph of the plan

```bash
terraform graph -draw-cycles | dot -Tsvg -o graph.svg
```

### Debugging

In case you get an unclear error message

```bash
TF_LOG=TRACE terraform your_command
```

### VPN details
  
* Install script:    https://git.io/vpnsetup
* Important notes:   https://git.io/vpnnotes
* Setup VPN clients: https://git.io/vpnclients

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)
