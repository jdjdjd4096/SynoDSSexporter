# SynoDSSexporter
Synology DSS file exporter is a simple command line tool to extract info about stored configuration in file generated by Synology device ended with extension .dss.
DSS file is not suimply and fast readable by humans. Purpose of this script is to help generate simple documentaionwhich information are stored in this file. Not everytime the automatic recovery configuration process for synology device is possible or as a aim, thus comparation of manualy re-created configuration comparable to previous settings is more expected by users. Unfortunately any Synology app delivered by the venor not allow to simply todo this task. 

# How to obtain configuration backup file from Synology device ? 
Synology explains very detail about this process on their help. If you don't know how generate this file automatically/manually please read this part of the help 
https://kb.synology.com/en-ca/DSM/help/DSM/AdminCenter/system_configbackup?version=6

Basic little info about DSS files that I found myself on Internet. ![here](https://gist.github.com/willfurnass/7db2a26a7a147cc8b86676651e1ab8c1)


# Generated DSS file example 

![example](/img/220540_01.png)

# DS File structure 
The file structure is not simple in first eye sight, because this file is as archive compressed twicely. 
 
 First test of the .dss file returns: 
  
**>"C:\Program Files\7-Zip\7z.exe" l dsm0_20211006.dss**
```
7-Zip 19.00 (x64) : Copyright (c) 1999-2018 Igor Pavlov : 2019-02-21

Scanning the drive for archives:
+ 1 file, 19956 bytes (20 KiB)

Listing archive: dsm0_20211006.dss

--
Path = dsm0_20211006.dss
- Type = xz
- Physical Size = 19956
- Method = LZMA2:23 CRC64
Streams = 1
Blocks = 1

   Date      Time    Attr         Size   Compressed  Name
------------------- ----- ------------ ------------  ------------------------
                    .....       174080        19956  dsm0_20211006
------------------- ----- ------------ ------------  ------------------------
                                174080        19956  1 files
```
 So, we have in this archive one file. Let's extract it. 
 
 **"C:\Program Files\7-Zip\7z.exe" e dsm0_20211006.dss**
 
 After this process we have unpacked file. But this is not destination file that holds whole Synology device backup. 
 Let's try to test this unpacked file again. 
 
 **"C:\Program Files\7-Zip\7z.exe" l dsm0_20211006**
 
 ```
 Scanning the drive for archives:
+ 1 file, 174080 bytes (170 KiB)

Listing archive: dsm0_20211006

--
Path = dsm0_20211006
Type = tar
Physical Size = 174080
Headers Size = 10752
Code Page = UTF-8

   Date      Time    Attr         Size   Compressed  Name
------------------- ----- ------------ ------------  ------------------------
1970-01-01 01:00:00 D....            0            0  ConfigBkp
1970-01-01 01:00:00 .....          132          512  ConfigBkp\config_info
1970-01-01 01:00:00 .....       159744       159744  ConfigBkp\_Syno_ConfBkp.db
1970-01-01 01:00:00 D....            0            0  ConfigBkp\tls_profile
1970-01-01 01:00:00 .....          341          512  ConfigBkp\tls_profile\datastore.json
1970-01-01 01:00:00 D....            0            0  ConfigBkp\tls_profile\services
1970-01-01 01:00:00 .....          155          512  ConfigBkp\tls_profile\services\dsm.conf
1970-01-01 01:00:00 .....           81          512  ConfigBkp\tls_profile\services\smbftpd.conf
1970-01-01 01:00:00 .....          166          512  ConfigBkp\tls_profile\services\system_quickconnect.conf
1970-01-01 01:00:00 D....            0            0  ConfigBkp\tls_profile\config
1970-01-01 01:00:00 .....          361          512  ConfigBkp\tls_profile\config\dsm.conf
1970-01-01 01:00:00 .....          361          512  ConfigBkp\tls_profile\config\system_quickconnect.conf
1970-01-01 01:00:00 .....            0            0  ConfigBkp\synoS2S.info
------------------- ----- ------------ ------------  ------------------------
1970-01-01 01:00:00             161341       163328  9 files, 4 folders
```

Next step is simple to extract this file. Please use the switch x. This switch extract this content above to one folder called ConfigBkp.
 **"C:\Program Files\7-Zip\7z.exe" x dsm0_20211006**
```
 Scanning the drive for archives:
1 file, 174080 bytes (170 KiB)

Extracting archive: dsm0_20211006
--
Path = dsm0_20211006
Type = tar
Physical Size = 174080
Headers Size = 10752
Code Page = UTF-8

Everything is Ok

Folders: 4
Files: 9
Size:       161341
Compressed: 174080
 
Files inside .DSS file. 
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
            
