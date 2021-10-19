 # powershell script that connect to the SQLite database with Synology config dump and extract all important Synology settings to human readable format. 

 # [cmdletbinding(DefaultParameterSetName = 'STATUS')]
[cmdletbinding()]
    Param (
    [Parameter(Mandatory=$false,Position=0, ParameterSetName="file", HelpMessage=".dss file path")]  
    [string]$database
)

set-psdebug -strict; $ErrorActionPreference = "stop"

# This Script version 
$ThisScriptVersion = "0.17 12.10.2021"
$CurrDotNetVer = get-itemproperty -name version,release "hklm:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\FULL"

$dir = $PSCommandPath | Split-Path -Parent
$dir = $dir + "\"

$CurrentScriptName = $MyInvocation.MyCommand
Push-Location $dir # the current folder from the stript was loaded 

# Global definitions

$hostname = $env:computername
$majorversion = $psversiontable.psversion.Major

Write-Host ": $CurrentScriptName : $ThisScriptVersion  PowerShell: $majorversion .NET: $($CurrDotNetVer.version) Hostname: $hostname " -ForegroundColor Green

if ($database -eq "")
 {
        write-host "please provide full path to the downloaded file from Synology drive " -ForegroundColor Red
 }
 else
    {
        # check that file really exsst in this path 

        if (Test-Path  $database){

            $data_confbkp_config_tb = @{}
            $destFolder = $database + "_extracted"

            write-host "Processing database file " $database
            
            # test file corrextness 
            #tar -tf $database 

            # Install-Module PSSQLite -Force
            # Install-Module 7Zip4PowerShell -Force

            # check that module exsists 
            Import-Module PSSQLite
            Import-Module 7Zip4PowerShell

            # Test archive 
            $TestResult = Get-7ZipInformation $database

            $TestResult
            
            # Get-7ZipInformation "FakeDssArchive.dss"
            #"Get-7ZipInformation : Invalid archive: open/read error! Is it encrypted and a wrong password was provided?
            #If your archive is an exotic one, it is possible that SevenZipSharp has no signature for its format and thus decided it is TAR by mistake."

            Write-Host "correct archive" $TestResult
            # test and expand archive 
            
            <# 
            PS>Get-7zip .\dsm0_20211006.dss


            Index          : 0
            FileName       : [no name]
            LastWriteTime  : 12.10.2021 21:41:42
            CreationTime   : 12.10.2021 21:41:42
            LastAccessTime : 12.10.2021 21:41:42
            Size           : 174080
            Crc            : 0
            Attributes     : 0
            IsDirectory    : False
            Encrypted      : False
            Comment        :
            Method         : LZMA2:23 CRC64
            
            
            #> 
            # Expand archive 
            Write-Host "expand archive  $database in folder $destFolder " 
            
            $ExpandResult = Expand-7Zip .\dsm0_20211006.dss $destFolder
            $ExpandResult


            Write-Host "searching second archive names " 
            
            $searching = Get-Childitem $destFolder

            Write-Host "found " $searching.Name
            
            # if is only tar it means that is not extracted if is also ConfigBkp the current archive was extracted

            if ($($searching.Name) -match "ConfigBkp")
            {

                            Write-Host "second archive was extracted previously " $searching.Name -ForegroundColor Cyan

                            #C:\Users\jdjd\Documents\GitHub\SynoDSSexporter\scripts\dsm0_20211006.dss_extracted\ConfigBkp

                            $extracted = $searching.DirectoryName + "\ConfigBkp"

                            $extractedDatabase = $extracted + "\_Syno_ConfBkp.db"
            
            }
            else
            {
                            Write-Host "extract founded archive  " $searching.FullName 

                # test archive 

                Get-7ZipInformation $searching.FullName

                Expand-7Zip $($searching.FullName) $searching.DirectoryName


            }            

                $result2 = Get-ChildItem $extracted

                $result2.FullName

                # now you can try connect to the database 

                Write-Host "conect to the database  " $extractedDatabase -ForegroundColor Cyan
                               
                $data_confbkp_config_tb = Invoke-SqliteQuery -DataSource $extractedDatabase -Query "SELECT * FROM confbkp_config_tb"

                ##$data_confbkp_config_tb | Get-Member  

                Write-host "Loaded " $data_confbkp_config_tb.Count -ForegroundColor Cyan

                Write-Host "Keys  "  -ForegroundColor Cyan
                
                $data_confbkp_config_tb | Select-Object -ExpandProperty key

                Write-Host "volume info   " -ForegroundColor Cyan

                $data_confbkp_config_tb.GetEnumerator() | Where-Object { $_.key -eq "Homeservice_volumePath" }
            
            <#
            PS>dir .\dsm0_extracted\


    Directory: C:\Users\jdjd\Documents\GitHub\SynoDSSexporter\scripts\dsm0_extracted


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        12.10.2021     21:42         174080 dsm0_20211006.tar

    very long listing 

PS>Get-7zip .\dsm0_20211006.tar


Index          : 0
FileName       : ConfigBkp
LastWriteTime  : 01.01.1970 00:00:00
CreationTime   : 12.10.2021 22:03:22
LastAccessTime : 12.10.2021 22:03:22
Size           : 0
Crc            : 0
Attributes     : 0
IsDirectory    : True
Encrypted      : False
Comment        :
Method         :

PS>Expand-7Zip .\dsm0_20211006.tar .

PS>dir


    Directory: C:\Users\jdjd\Documents\GitHub\SynoDSSexporter\scripts\dsm0_extracted


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        12.10.2021     22:04                ConfigBkp
-a----        12.10.2021     21:42         174080 dsm0_20211006.tar

PS>dir


    Directory: C:\Users\jdjd\Documents\GitHub\SynoDSSexporter\scripts\dsm0_extracted\ConfigBkp


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        12.10.2021     22:04                tls_profile
-a----        01.01.1970     00:00            132 config_info
-a----        01.01.1970     00:00              0 synoS2S.info
-a----        01.01.1970     00:00         159744 _Syno_ConfBkp.db

            #>

            <#


            #>

        }
        else {
            write-host "this $database doesn't exsist on the disk im provided path " -ForegroundColor Red
        }
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