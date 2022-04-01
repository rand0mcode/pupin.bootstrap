# pupin.bootstrap

## Assumptions

### VMs

You got a hetzner cloud token or have vagrant running?
Otherwise you have to care about your vms for yourself.

We expect to have at least 3 VMS for the `bootstrap::all` plan to run.

VMs you will need with names like:

- puppet.your.domain.tld
- puppetca.your.domain.tld
- puppetdb.your.domain.tld

The VMs should have set these as system domain names and should be able to reach each other over the names.
So basicly DNS should be available ;)

## Using pupin.bootstrap

### Hetzner Cloud

see [pupin.setup](https://github.com/rand0mcode/pupin.setup)

### WIP: Vagrant

see [pupin.setup](https://github.com/rand0mcode/pupin.setup)

### Use pupin.bootstrap

#### all

If you already got VMs or can create them yourself you can skip hetzner or vagrant setup.
Go to the `bootstrap` directory:

```
cd bootstrap

# update inventory.yaml

bolt plan run bootstrap::all dommain="your.domain.tld"
```

#### add

```
cd bootstrap

# update inventory.yaml

bolt plan run bootstrap::add -t kibana role="monitoring::kibana"
```

#### clean cert

```
cd bootstrap
bolt task run bootstrap::clean_cert --targets puppetca certname=kibana.priv.rw.betadots.training
```

#### r10k deployment

```
cd bootstrap

bootstrap git:(main) bolt task run bootstrap::r10k_deploy --targets puppet

# only deploy one environment

bolt task run bootstrap::r10k_deploy --targets puppet puppet_env=development
```

# Docs

- [The Docs](docs)
