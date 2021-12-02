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
  [domain=<value>] [locale=<value>] [prerequirements=<value>] [targets=<value>]

Parameters
  collection  String
    Default: 'puppet7'

  control_repo  String
    Default: 'https://github.com/rand0mcode/pupin.control.git'

  domain  String
    Default: 'priv.example42.cloud'

  locale  String
    Default: 'de'

  prerequirements  Boolean
    Default: true

  targets  TargetSpec
    Default: ['puppet', 'puppetdb', 'puppetca', 'agent01']
```

#### with another domain

default is `priv.example42.com`.

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
  bolt plan run bootstrap::add [collection=<value>] [domain=<value>]
  [locale=<value>] [role=<value>] [targets=<value>]

Parameters
  collection  String
    Default: 'puppet7'

  domain  String
    Default: 'priv.example42.cloud'

  locale  String
    Default: 'de'

  role  String
    Default: 'default'

  targets  TargetSpec
    Default: []
```

```
# on control node
bolt plan run bootstrap::add -t monitor01,monitor02

# on node
ssh node
puppet agent -t --waitforcert 10

# on control node
bolt task run bootstrap::sign_cert --targets puppetca certname=monitor02.priv.example42.cloud
```
