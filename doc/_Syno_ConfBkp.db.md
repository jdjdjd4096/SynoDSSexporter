# full description of the _Syno_ConfBkp.db file. 

**List of all tables and selected usable content explained**

sqlite> .tables  
confbkp_config_tb - this table contains all pairs key -> value with specific DSM configuration [here](#confbkp_config_tb)  
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





# confbkp_config_tb  

:pencil: Structure table: KEY (text) VALUE (text)

Home dirextories settings 

"Homeservice_isEnableHomeService"	"1"
"Homeservice_volumeID"	"1"
"Homeservice_isIncludeLDAPUser"	"0"
"Homeservice_isIncludeDomainUser"	"0"
"Homeservice_isEnableRecycleBin"	"1"
"Homeservice_volumePath"	"/volume1/homes"

Passwords 

"Passwdstrength_isApplyPasswdRule"	"1"
"Passwdstrength_isExcludeUsername"	"1"
"Passwdstrength_isMixedCase"	"0"
"Passwdstrength_isIncludeNumericChar"	"0"
"Passwdstrength_isIncludeSpecialChar"	"0"
"Passwdstrength_isEnableMinLength"	"1"
"Passwdstrength_minLength"	"6"
"Passwdstrength_isForgetPassword"	"0"
"Passwdstrength_isMustChange"	"0"
"Passwdstrength_isExcloudCommon"	"0"
"Passwdstrength_isExcloudHistory"	"0"
"Passwdstrength_excloudHistoryNum"	"1"
"Passwdexpiry_isEnableMaxAge"	"0"
"Passwdexpiry_maxAgeDay"	"-1"
"Passwdexpiry_isEnableMinAge"	"0"
"Passwdexpiry_minAgeDay"	"-1"
"Passwdexpiry_isEnableLoginPrompt"	"0"
"Passwdexpiry_loginPromptDay"	"-1"
"Passwdexpiry_isEnableReset"	"0"
"Passwdexpiry_isEnableNotify"	"0"
"Passwdexpiry_mailTaskId"	"-1"
"Passwdexpiry_mailNotifyHour"	"-1"
"Passwdexpiry_mailNotifyMinute"	"-1"
"Passwdexpiry_mailCheckPoint"	""

SMB options
"CIFS_Enable_Win_File_Service"	"1"
"CIFS_WinsServer"	""
"CIFS_Optimize_DB"	"0"
"CIFS_Enable_Local_Master_Browser"	"0"
"CIFS_Enable_Transfer_Log"	"1"
"CIFS_Symlinks"	"0"
"CIFS_Widelinks"	"0"
"CIFS_Msdfs"	"0"
"CIFS_Enable_Vetofiles"	"0"
"CIFS_Vetofiles"	""
"CIFS_Level"	"0"
"CIFS_DIR_Sort"	"0"
"CIFS_Reset_On_Zero_Vc"	"0"
"CIFS_SMB2"	"1"
"CIFS_Max_Protocol"	"SMB2_10"
"CIFS_Min_Protocol"	"SMB2"
"CIFS_Max_Protocol_v2"	"SMB3"
"CIFS_UnixMask"	"0"
"CIFS_Encry_Transpose"	""
"CIFS_Strict_Allocate"	"0"
"CIFS_Wildcard_Search"	"0"
"CIFS_Durable_Handles"	"0"
"CIFS_SMB2_Leases"	"0"
"CIFS_Syno_Catia"	"0"
"CIFS_Delete_Veto_Files"	"0"
"CIFS_Enable_Server_Signing"	"0"
"CIFS_Fruit_Locking"	"0"
"CIFS_Access_Based_Share_Enum"	"0"
"CIFS_Enable_NTLMv1_Auth"	"0"
"CIFS_Enable_AIO_Read"	"0"
"CIFS_Transferlog_Create"	"1"
"CIFS_Transferlog_Write"	"1"
"CIFS_Transferlog_Move"	"1"
"CIFS_Transferlog_Delete"	"1"
"CIFS_Transferlog_Read"	"1"
"CIFS_Transferlog_Rename"	"1"
"CIFS_Transferlog_PermissionChange"	"0"

SNMP options 
"SNMP_isEnableSNMP"	"1"
"SNMP_V1V2cRocommunity"	"public"
"SNMP_Nname"	"dsm0"
"SNMP_Location"	"wardrobe"
"SNMP_Contact"	"jacekduma@gmail.com"

Terminal options 
"Terminal_isEnableTelnet"	"0"
"Terminal_isEnableSSH"	"1"
"Terminal_SSHPort"	"25"
"Terminal_SSHCipher"	""
"Terminal_SSHKex"	""
"Terminal_SSHMac"	""

Wuickconnect options 
"QUICKCONNECT_service"	"[{""enabled"":true,""id"":""mobile_apps""},{""enabled"":true,""id"":""cloudstation""},{""enabled"":true,""id"":""file_sharing""},{""enabled"":true,""id"":""dsm_portal""}]"
"QUICKCONNECT_misc"	"{""relay_tunnel"":{""relay_enabled"":true},""upnp"":{""enabled"":true}}"
"QUICKCONNECT_config"	"{""quickconnect"":{""enabled"":true},""serverID"":""071609859"",""server_alias"":{""alias"":""buntewelt""},""server_control"":{""host"":""dec.quickconnect.to""},""server_myds"":{""account"":""""},""server_smartdns"":{""enabled"":true},""service"":[{""id"":""dsm""},{""id"":""dsm_https""},{""id"":""http""},{""id"":""https""},{""id"":""ssh""},{""id"":""dms_https""},{""id"":""file_sharing""},{""id"":""file_sharing_https""},{""id"":""dsm_portal_https""},{""id"":""dsm_portal_http2""},{""id"":""cloudstation""}],""support_channel"":{""enabled"":false}}"

DDOS protection 
"DOS_config"	"{""/etc/fw_security/eth0.conf"":""\n[SETTINGS]\ndos_protect_enable=yes\n""}"

Network interface config 
"NETWORK_INTERFACE_config"	"{""BOND"":{},""DEFAULT_GATEWAY"":{},""ETH"":{""/etc/sysconfig/network-scripts/ifcfg-eth0"":""DEVICE=eth0\nBOOTPROTO=static\nONBOOT=yes\nBRIDGE=\""\""\nIPV6INIT=off\nIPADDR=192.168.0.5\nNETMASK=255.255.255.0\n""},""GATEWAY_DATABASE"":{""/etc/iproute2/config/gateway_database"":""[eth0]\n\tdns=62.179.1.62\n\tgateway=192.168.0.1\n""},""IPV6_ROUTER"":{},""PPPOE"":{""/etc/ppp/options"":""lock\n+ipv6 ipv6cp-use-persistent\n"",""/etc/ppp/pap-secrets"":""# Secrets for authentication using PAP\n# client\tserver\tsecret\t\t\tIP addresses\n"",""/etc/ppp/pppoe.conf"":""#***********************************************************************\n#\n# pppoe.conf\n#\n# Configuration file for rp-pppoe.  Edit as appropriate and install in\n# /etc/ppp/pppoe.conf\n#\n# NOTE: This file is used by the pppoe-start, pppoe-stop, pppoe-connect and\n#       pppoe-status shell scripts.  It is *not* used in any way by the\n#       \""pppoe\"" executable.\n#\n# Copyright (C) 2000 Roaring Penguin Software Inc.\n#\n# This file may be distributed under the terms of the GNU General\n# Public License.\n#\n# LIC: GPL\n# $Id$\n#***********************************************************************\n\n# When you configure a variable, DO NOT leave spaces around the \""=\"" sign.\n\n# Ethernet card connected to DSL modem\nETH=eth0\n\n# PPPoE user name.  You may have to supply \""@provider.com\""  Sympatico\n# users in Canada do need to include \""@sympatico.ca\""\n# Sympatico uses PAP authentication.  Make sure /etc/ppp/pap-secrets\n# contains the right username/password combination.\n# For Magma, use xxyyzz@magma.ca\nUSER=\n\n# Bring link up on demand?  Default is to leave link up all the time.\n# If you want the link to come up on demand, set DEMAND to a number indicating\n# the idle time after which the link is brought down.\nDEMAND=no\n#DEMAND=300\n\n# DNS type: SERVER=obtain from server; SPECIFY=use DNS1 and DNS2;\n# NOCHANGE=do not adjust.\nDNSTYPE=SERVER\n\n# Obtain DNS server addresses from the peer (recent versions of pppd only)\n# In old config files, this used to be called USEPEERDNS.  Changed to\n# PEERDNS for better Red Hat compatibility\nPEERDNS=yes\n\nDNS1=\nDNS2=\n\n# Make the PPPoE connection your default route.  Set to\n# DEFAULTROUTE=no if you don't want this.\nDEFAULTROUTE=yes\n\n### ONLY TOUCH THE FOLLOWING SETTINGS IF YOU'RE AN EXPERT\n\n# How long pppoe-start waits for a new PPP interface to appear before\n# concluding something went wrong.  If you use 0, then pppoe-start\n# exits immediately with a successful status and does not wait for the\n# link to come up.  Time is in seconds.\n#\n# WARNING WARNING WARNING:\n#\n# If you are using rp-pppoe on a physically-inaccessible host, set\n# CONNECT_TIMEOUT to 0.  This makes SURE that the machine keeps trying\n# to connect forever after pppoe-start is called.  Otherwise, it will\n# give out after CONNECT_TIMEOUT seconds and will not attempt to\n# connect again, making it impossible to reach.\nCONNECT_TIMEOUT=30\n\n# How often in seconds pppoe-start polls to check if link is up\nCONNECT_POLL=2\n\n# Specific desired AC Name\nACNAME=\n\n# Specific desired service name\nSERVICENAME=\n\n# Character to echo at each poll.  Use PING=\""\"" if you don't want\n# anything echoed\nPING=\"".\""\n\n# File where the pppoe-connect script writes its process-ID.\n# Three files are actually used:\n#   $PIDFILE       contains PID of pppoe-connect script\n#   $PIDFILE.pppoe contains PID of pppoe process\n#   $PIDFILE.pppd  contains PID of pppd process\nCF_BASE=`basename $CONFIG`\nPIDFILE=\""/var/run/$CF_BASE-pppoe.pid\""\n\n# Do you want to use synchronous PPP?  \""yes\"" or \""no\"".  \""yes\"" is much\n# easier on CPU usage, but may not work for you.  It is safer to use\n# \""no\"", but you may want to experiment with \""yes\"".  \""yes\"" is generally\n# safe on Linux machines with the n_hdlc line discipline; unsafe on others.\nSYNCHRONOUS=no\n\n# Do you want to clamp the MSS?  Here's how to decide:\n# - If you have only a SINGLE computer connected to the DSL modem, choose\n#   \""no\"".\n# - If you have a computer acting as a gateway for a LAN, choose \""1412\"".\n#   The setting of 1412 is safe for either setup, but uses slightly more\n#   CPU power.\nCLAMPMSS=1412\n#CLAMPMSS=no\n\n# LCP echo interval and failure count.\nLCP_INTERVAL=20\nLCP_FAILURE=3\n\n# PPPOE_TIMEOUT should be about 4*LCP_INTERVAL\nPPPOE_TIMEOUT=80\n\n# Firewalling: One of NONE, STANDALONE or MASQUERADE\nFIREWALL=NONE\n\n# Linux kernel-mode plugin for pppd.  If you want to try the kernel-mode\n# plugin, use LINUX_PLUGIN=/etc/ppp/plugins/rp-pppoe.so\nLINUX_PLUGIN=/lib/rp-pppoe/rp-pppoe.so\n\n# Any extra arguments to pass to pppoe.  Normally, use a blank string\n# like this:\nPPPOE_EXTRA=\""\""\n\n# Rumour has it that \""Citizen's Communications\"" with a 3Com\n# HomeConnect DSL Modem DualLink requires these extra options:\n# PPPOE_EXTRA=\""-f 3c12:3c13 -S ISP\""\n\n# Any extra arguments to pass to pppd.  Normally, use a blank string\n# like this:\nPPPD_EXTRA=\""\""\n\n\n########## DON'T CHANGE BELOW UNLESS YOU KNOW WHAT YOU ARE DOING\n# If you wish to COMPLETELY overrride the pppd invocation:\n# Example:\n# OVERRIDE_PPPD_COMMAND=\""pppd call dsl\""\n\n# If you want pppoe-connect to exit when connection drops:\n# RETRY_ON_FAILURE=no\n""},""VLAN"":{},""VPNC_L2TP"":{},""VPNC_OPENVPN"":{},""VPNC_PPTP"":{""/usr/syno/etc/synovpnclient/pptp/wvdial"":""noauth\nname wvdial\nusepeerdns\n#syno define usbmodem start from ppp100\nunit 100\nipparam usbmodem\n"",""/usr/syno/etc/synovpnclient/pptp/wvdial-pipe"":""noauth\nname wvdial\n\nplugin passwordfd.so\n\ndefaultroute\nreplacedefaultroute\n""},""_8021X"":{},""config_version"":1,""is_valid"":true,""mtu"":{""eth0"":""1500""}}"

"NETWORK_GENERAL_config"	"{""config"":{""arp_ignore"":true,""dns_manual"":true,""dns_primary"":""62.179.1.62"",""dns_secondary"":""62.179.1.63"",""enable_ip_conflict_detect"":true,""ipv4_first"":false,""multi_gateway"":false,""server_name"":""dsm0""},""config_version"":1,""proxy_config"":{""/etc/proxy.conf"":""proxy_user=\nproxy_pwd=\nproxy_enabled=no\nadv_enabled=no\nbypass_enabled=yes\nauth_enabled=no\nhttps_host=\nhttps_port=80\nhttp_host=\nhttp_port=80\n""}}"