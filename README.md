# worklogs

This is a worklogs plugin for Redmine.

## Requirements

```
Ruby interpreter: 1.9.2, 1.9.3, 2.0.0
Redmine: 2.3.x
```

## Installation

To install the plugin, execute the following commands from the root of your Redmine directory:

```
cd plugins
git clone https://github.com/IceskYsl/worklogs.git
```

and then execute the following commands from the root of your Redmine directory:

```
$ RAILS_ENV=production rake redmine:plugins:migrate
```	

More information on installing Redmine plugins can be found at [redmine.org](http://www.redmine.org/wiki/redmine/Plugins.).

After the plugin is installed you will need to restart Redmine for the plugin to be available.

## Task

by rake
```
#day report
RAILS_ENV=production bundle exec rake worklogs:day day=2013-08-01

#week report
RAILS_ENV=production bundle exec rake worklogs:week week=23

```

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
rake redmine:plugins:migrate NAME=worklogs VERSION=0 RAILS_ENV=production
rm -rf plugins/worklogs
bundle install
```

## Demo
Configure
![Configure](https://f.cloud.github.com/assets/5537/756143/753e6d74-e5eb-11e2-9cd6-64544f6fd876.png)

![Configure](https://f.cloud.github.com/assets/5537/756006/8d375c3a-e5d5-11e2-9377-ad887a58a6db.png)

demo
![pic](https://f.cloud.github.com/assets/5537/719898/31cfb77e-dfa0-11e2-8618-6dd6c6bc31fd.jpg)

