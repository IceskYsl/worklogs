## TODO
* 兼容周报
* 修复日报bug
* 

### 0.2.5

* fix invalid multibyte char (US-ASCII)

## LOGS 
Setting Exists (0.3ms)  SELECT 1 AS one FROM `settings` WHERE `settings`.`name` = BINARY 'plugin_worklogs' LIMIT 1
SQL (0.3ms)  INSERT INTO `settings` (`name`, `updated_on`, `value`) VALUES ('plugin_worklogs', '2013-07-05 23:18:12', '--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess\nWORKLOGS_DAY_TIME: !ruby/hash:ActiveSupport::HashWithIndifferentAccess\n (1i): \'2013\'\n (2i): \'7\'\n (3i): \'5\'\n (4i): \'21\'\n (5i): \'18\'\nWORKLOGS_UN_IDS: \'1,2\'\n')