# worklogs

This is a worklogs plugin for Redmine.


## Installation

To install the plugin, execute the following commands from the root of your Redmine directory:

```
cd plugins
git clone git@github.com:IceskYsl/worklogs.git
bundle install
```

and then execute the following commands from the root of your Redmine directory:

```
$ rake redmine:plugins:migrate
```	

More information on installing Redmine plugins can be found at [redmine.org](http://www.redmine.org/wiki/redmine/Plugins.).

After the plugin is installed you will need to restart Redmine for the plugin to be available.

## Task

Add the task into crontable
```
$ cat /etc/cron.daily/week.sh
#!/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/opt/ruby/bin
cd /opt/redmine/
RAILS_ENV=production bundle exec rake worklogs:day
```

### Uninstallation

To remove the plugin, from the root of your installation directory do the following:
```
rm -rf plugins/worklogs
bundle install
```

## Demo
![pic](https://f.cloud.github.com/assets/5537/719898/31cfb77e-dfa0-11e2-8618-6dd6c6bc31fd.jpg)

