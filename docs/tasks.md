# Tasks

## List available bolt tasks

```
bolt task show
```

## Default Tasks

### Install Puppet Agent (latest)

This is a bolt standard task

```
bolt task run puppet_agent::install --targets puppet
```

## Custom Tasks

### Sign Certificate

This is a custom task to sign a cert request on a PuppetCA

```
bolt task run bootstrap::sign_cert --targets puppetca certname=agent01.priv.rw.betadots.training
```

### Create CSR Attributes

This task creates the crs_attributes.yaml and adds the pp_role filed to it.

```
bolt task run bootstrap::create_csr_attributes --targets puppetca role="puppet::ca"
```

### Create r10k Configuration

This task creates an initial r10k configuration. Parameter is the url of a control repo.

```
bolt task run bootstrap::r10k_config --targets puppet control_repo="https://git.example.com/control.git"
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

### Add dataview/index_pattern to kibana

Adds an index_pattern to kibana to scan an index or a dataview for all its fields.

```
bolt task run bootstrap::elk_add_datavie --targets kibana pattern="mypattern-*"
```


### Import Ingest Pipeline for puppetserver.log

Imports a ingest pipeline into elasticsearch with special GROK pattern for puppets puppetserver.log.

```
bolt task run bootstrap::elk_add_ingest_pipeline_puppetserver_log --targets elastic01
```

### Import Metricbeat default dashboards into Kibana

```
bolt task run bootstrap::elk_add_metricbeat_dashboards --targets kibana
```
