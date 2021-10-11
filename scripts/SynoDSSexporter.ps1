 # powershell script that connect to the SQLite database with Synology config dump and extract all important Synology settings to human readable format. 

 
 param($database)
 set-psdebug -strict; $ErrorActionPreference = "stop"


 # set working path to the place where the script is placed 


 $database = "dsm0_20211006.dss"




 if (!$database)
 {
        write-host "please provide full path to the downloaded file from Synology drive "
 }
 else
    {
        $data_confbkp_config_tb = @{}

        write-host "Processing database file "
        Write-host "$database " $database.GetType().Name  
        
        
        # Install-Module PSSQLite
        # check that module exsists 
        Import-Module PSSQLite

        # load  database as a parameter 
        $Database = $database

        $data_confbkp_config_tb = Invoke-SqliteQuery -DataSource $Database -Query "SELECT * FROM confbkp_config_tb"

        #$data_confbkp_config_tb | Get-Member  

        Write-host "Loaded " $data_confbkp_config_tb.Count

        $data_confbkp_config_tb | Select -ExpandProperty key

        $data_confbkp_config_tb.GetEnumerator() | ? { $_.key -eq "Homeservice_volumePath" }

    }



    <#
       TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition                    
----        ----------   ----------                    
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()             
GetType     Method       type GetType()                
ToString    Method       string ToString()             
key         NoteProperty string key=ACL_max_count      
value       NoteProperty string value=200 
#>


 Function Get-FreeDiskSpace
{
 Param ($drive,$computer)
 $driveData = Get-WmiObject -class win32_LogicalDisk `
 -computername $computer -filter "Name = '$drive'" 
"
 $computer free disk space on drive $drive 
    $("{0:n2}" -f ($driveData.FreeSpace/1MB)) MegaBytes
" 
}

# Get-FreeDiskSpace -drive "C:" -computer "localhost"