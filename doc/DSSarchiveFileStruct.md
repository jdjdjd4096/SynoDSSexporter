# Generated DSS file example 

![example](/img/220540_01.png)

# DSS File structure 
The file structure is not simple in first eye sight, because this file is as archive compressed twicely. 
 
 First test of the .dss file returns: 
  
**>"C:\Program Files\7-Zip\7z.exe" l dsm0_20211006.dss**
```diff
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
 
 ```diff
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
```diff
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
            
