## List available bolt plans

```
bolt plan show
```

## Install all components with a plan

### bootstrap::all - All in one installation

```
bootstrap::all
  This plan installs a puppetserver, puppetca and puppetdb

Usage
  bolt plan run bootstrap::all [collection=<value>] [control_repo=<value>]
  [domain=<value>] [env=<value>] [locale=<value>] [prerequirements=<value>]
  [targets=<value>] [type=<value>]

Parameters
  collection  String
    Default: 'puppet7'

  control_repo  String
    Default: 'https://github.com/rand0mcode/pupin.control.git'

  domain  String
    Default: 'priv.rw.betadots.training'

  env  String
    Default: 'production'

  locale  String
    Default: 'de'

  prerequirements  Boolean
    Default: true

  targets  TargetSpec
    Default: ['puppet', 'puppetdb', 'puppetca']

  type  String
    Default: 'ext_ca_pdb_oss'
```

#### with another domain

default is `priv.rw.betadots.training`.

The targets in the plans will than be extended with this domain. Like `puppet.foobar.com` or `puppetdb.foorbar.com`. And dont forget to update the inventory file,
there is currently no way to get a dynamic domain.

```
bolt plan run bootstrap::all domain=foobar.com
```

### bootstrap::add - Add notes to the environment

```
bootstrap::add
  This plan add nodes to the puppet environment

Usage
  bolt plan run bootstrap::add [collection=<value>] [domain=<value>] [env=<value>]
  [locale=<value>] [role=<value>] [targets=<value>]

Parameters
  collection  String
    Default: 'puppet7'

  domain  String
    Default: 'priv.rw.betadots.training'

  env  String
    Default: 'production'

  locale  String
    Default: 'de'

  role  String
    Default: 'default'

  targets  TargetSpec
    Default: []
```
