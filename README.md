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

see pupin.setup

### WIP: Vagrant

see pupin.setup

### Use pupin.bootstrap

If you already got VMs or can create them yourself you can skip hetzner or vagrant setup.
Go to the `bootstrap` directory:

```
cd bootstrap

# update inventory.yaml

bolt plan run bootstrap::all dommain="your.domain.tld"
```

# Docs

- [The Docs](docs)
