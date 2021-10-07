# full description of the _Syno_ConfBkp.db file. 

1. List of all tables and their content explained 

sqlite> .tables
confbkp_config_tb   link to full description to this table is [here](#confbkp_config_tb)

confbkp_volume_tb

confbkp_share_tb
confbkp_share_nfs_rule_tb
confbkp_share_privilege_id_tb

confbkp_group_tb                   
confbkp_group_member_list_tb       
confbkp_group_bandwidth_table      
confbkp_group_delegation_table     
confbkp_group_set_share_quota_tb   
confbkp_group_set_volume_quota_tb  
confbkp_group_share_quota_tb       
confbkp_group_volume_quota_tb      

confbkp_nfs_idmap_tb               
confbkp_scheduler_table
confbkp_smartblock_table

confbkp_user_tb
confbkp_user_bandwidth_table
confbkp_user_delegation_table
confbkp_user_quota_tb
confbkp_user_set_share_quota_tb
confbkp_user_set_volume_quota_tb
confbkp_user_share_quota_tb

confbkp_app_advanced_privilege_tb

confbkp_auto_config_backup_table
sqlite>


## confbkp_config_tb











confbkp_config_tb

sqlite> .schema ;
CREATE TABLE confbkp_config_tb(key TEXT, value TEXT);
sqlite>

sqlite> .schema confbkp_config_tb
CREATE TABLE confbkp_config_tb(key TEXT, value TEXT);
sqlite> .mode insert
sqlite> .output data.out
sqlite> select * from confbkp_config_tb;
sqlite>