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

#### all aio

if you only have a puppetserver, which is also the ca and runs the puppetdb, too, choose this parameters.

```
bolt plan run bootstrap::all type="aio_oss" targets="puppet"
```

#### all with different base environment

```
bolt plan run bootstrap::all env="development"
```


#### add

```
cd bootstrap

# update inventory.yaml

bolt plan run bootstrap::add -t kibana role="monitoring::kibana"
```

#### elk

after installing the puppet stack you can also install the elk stack with the following plan

```
cd bootstrap

# update inventory.yaml

bolt plan run bootstrap::elk
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
