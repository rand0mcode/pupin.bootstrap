# pupin.bootstrap

## Assumptions

### VMs

you got a hetzner cloud token or have vagrant running.
Otherwise you have to care about your vms for yourself.

We expect to have at least 3 VMS for the `bootstrap::all` plan to run.

VMs you will need, names like:

- puppet.your.domain.tld
- puppetca.your.domain.tld
- puppetdb.your.domain.tld

The VMs should have set these as system domain names and should be able to reach each other over the names.
So basicly DNS should be available ;)

## Using pupin.bootstrap

### Hetzner Cloud

To use terraform you should create a `secrets.auto.tfvars` in the terraform directory.
We assume you have a hetzner dns zone and be able to spin up cloud instances.

`secrets.auto.tfvars` is in the `.gitignore` so it will not be commited.

```
hcloud_token = "..."      # cloud token for the vms
hdns_token = "..."        # cloud dns token for the dns records
dns_zone = "example.com"  # dns zone name // domain name
```

```
cd bootstrap

bolt task run terraform::apply -t localhost dir="../terraform"
bolt plan run bootstrap::all dommain="your.domain.tld"

bolt task run terraform::destroy -t localhost dir="terraform"
```

### WIP: Vagrant

Make sure you have at least 8 GiB RAM available. All VMs in sum will consume this.
Make also sure you have Vagrant and Virtualbox installed.

Tested versions:
 - macOS: 11.6
 - vagrant: 2.2.19
 - virtualbox: 6.1.18 r142142 (Qt5.6.3)

install hostmanager and vbguest.

```
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostmanager
```

```
cd vagrant
vagrant up
```

### Own VMs

If you already got VMs or can create them yourself you can skipt hetzner and vagrant setup.
Just go to the `bootstrap`directory and run:

```
bolt plan run bootstrap::all dommain="your.domain.tld"
```

# Docs

- [The Docs](docs)
