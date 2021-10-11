Files inside .DSS file. 
```
+ ConfigBkp\config_info
+ ConfigBkp\_Syno_ConfBkp.db
+ ConfigBkp\synoS2S.info
+ ConfigBkp\tls_profile\datastore.json
+ ConfigBkp\tls_profile\services\dsm.conf
+ ConfigBkp\tls_profile\services\smbftpd.conf
+ ConfigBkp\tls_profile\services\system_quickconnect.conf
+ ConfigBkp\tls_profile\config\dsm.conf
+ ConfigBkp\tls_profile\config\system_quickconnect.conf

 ```
 
The main important file is _Syno_ConfBkp.db SQLite database. This database holds most of the important files that stores the configuration. This powershell script will be extraxt this file all possible element to readable format for humans. In below lines the isimple information about configuration are placed in dedicates sections 
 
**[ConfigBkp\]**
 
The main folder with extracted config files. 
 
**[ConfigBkp\config_info]**
 
This file are holding information about the hardware and installed DSM version. 
```
os_name="DSM"
conf_version="5"
dsm_majorversion="7"
dsm_minorversion="0"
dsm_buildnumber="41890"
unique="synology_armada370_ds115j"
```
**[ConfigBkp\synoS2S.info]**
 
```
<empty> 
```
**[ConfigBkp\_Syno_ConfBkp.db]**
 
Main database with many information about our Synology device. We can simmply extract manually these information using sqlite tools. 
```
SQLite version 3.36.0 2021-06-18 18:36:39
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open _Syno_ConfBkp.db
sqlite> .databases
main: C:\Users\<anonymised_folder>\ConfigBkp\_Syno_ConfBkp.db r/w
sqlite> .dbinfo
database page size:  4096
write format:        1
read format:         1
reserved bytes:      0
file change counter: 2
database page count: 39
freelist page count: 0
schema cookie:       25
schema format:       4
default cache size:  0
autovacuum top root: 0
incremental vacuum:  0
text encoding:       1 (utf8)
user version:        0
application id:      0
software version:    3034001
number of tables:    25
number of indexes:   1
number of triggers:  0
number of views:     0
schema size:         2777
data version         1
sqlite> .tables
confbkp_app_advanced_privilege_tb  confbkp_share_nfs_rule_tb
confbkp_auto_config_backup_table   confbkp_share_privilege_id_tb
confbkp_config_tb                  confbkp_share_tb
confbkp_group_bandwidth_table      confbkp_smartblock_table
confbkp_group_delegation_table     confbkp_user_bandwidth_table
confbkp_group_member_list_tb       confbkp_user_delegation_table
confbkp_group_set_share_quota_tb   confbkp_user_quota_tb
confbkp_group_set_volume_quota_tb  confbkp_user_set_share_quota_tb
confbkp_group_share_quota_tb       confbkp_user_set_volume_quota_tb
confbkp_group_tb                   confbkp_user_share_quota_tb
confbkp_group_volume_quota_tb      confbkp_user_tb
confbkp_nfs_idmap_tb               confbkp_volume_tb
confbkp_scheduler_table
sqlite>
```
More about stored information inside this file is located in this doc [here](doc/_Syno_ConfBkp.db.md)

**[ConfigBkp\tls_profile\datastore.json]**
 
This file holds information about services. 

**[ConfigBkp\tls_profile\config\dsm.conf]**
 
This file Holds information about internal ssl configuration 
 
**[ConfigBkp\tls_profile\config\system_quickconnect.conf]**
 
This file Holds information about external ssl configuration 

**[ConfigBkp\tls_profile\services\dsm.conf]**
 
This file holds information about services. 
 
**[ConfigBkp\tls_profile\services\smbftpd.conf]**
 
This file holds information about services. 

**[ConfigBkp\tls_profile\services\system_quickconnect.conf]**
 
This file holds the Quickconnect config       