# Tasks

## List available bolt tasks

```
bolt task show
```

## Default Tasks

### Terraform rampup

This is a bolt standard task, which uses the terraform manifests from `../terraform` directory.

```
bolt task run terraform::apply -t localhost dir="../terraform"
```

## Terraform tear down

This is a bolt standard task, which uses the terraform manifests from `../terraform` directory.

```
bolt task run terraform::destroy -t localhost dir="../terraform"
```

### Install Puppet Agent (latest)

This is a bolt standard task

```
bolt task run puppet_agent::install --targets puppet
```

## Custom Tasks

### Sign Certificate

This is a custom task to sign a cert request on a PuppetCA

```
bolt task run bootstrap::sign_cert --targets puppetca certname=agent01.priv.example42.cloud
```

### Create CSR Attributes

This task creates the crs_attributes.yaml and adds the pp_role filed to it.

```
bolt task run bootstrap::create_csr_attributes --targets puppetca role="puppet::ca"
```

### Create r10k Configuration

This task creates an initial r10k configuration. Parameter is the url of a control repo.

```
bolt task run bootstrap::create_r10k_config --targets puppet control_repo="https://git.example.com/control.git"
```

### Disable CA

This task disables the CA on a puppet compiler. It overwrites the services.d/ca.cfg.

```
bolt task run bootstrap::disable_ca --targets puppet
```

### Set alt_names

This task allows or disallows the usage of dns_alt_names on a PuppetCA.

```
bolt task run bootstrap::set_alt_names --targets puppetca alt_names="true"
```

### Run r10k module deployment

This tasks triggers r10k with or without an environment and updates the modules.

```
bolt taks run bootstrap::r10k_deploy --targets puppet puppet_env="empty"
```
