## List available bolt tasks

```
bolt task show
```

## Terraform rampup

This is a bolt standard task, which uses the terraform manifests from `../terraform` directory.

```
bolt task run terraform::apply -t localhost dir="../terraform"
```


## Install Puppet Agent (latest)

This is a bolt standard task

```
bolt task run puppet_agent::install --targets puppet
```

## Sign Certificate

This is a custom task to sign a cert request on a PuppetCA
```
bolt task run bootstrap::sign_cert --targets puppetca certname=agent01.priv.example42.cloud
```

## Tear down

This is a bolt standard task, which uses the terraform manifests from `../terraform` directory.

```
bolt task run terraform::destroy -t localhost dir="../terraform"
```
