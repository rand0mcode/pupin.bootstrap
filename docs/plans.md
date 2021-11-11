## List available bolt plans

```
bolt plan show
```

## Install all components with a plan

### default run

All in one installation of puppetserver, ca and a db

```
bolt plan run bootstrap::all
```

### with another domain

default is `priv.example42.com`.

The targets in the plans will than be extended with this domain. Like `puppet.foobar.com` or `puppetdb.foorbar.com`. And dont forget to update the inventory file,
there is currently no way to get a dynamic domain.

```
bolt plan run bootstrap::all domain=foobar.com
```
