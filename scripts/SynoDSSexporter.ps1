# powershell script that connect to the SQLite database with Synology config dump and extract all important Synology settings to human readable format. 

# [cmdletbinding(DefaultParameterSetName = 'STATUS')]
[cmdletbinding()]
    Param (
    [Parameter(Mandatory=$false,Position=0, ParameterSetName="file", HelpMessage=".dss file path")]  
    [string]$database
)

set-psdebug -strict; $ErrorActionPreference = "stop"

# This Script version 
$ThisScriptVersion = "0.18 20.02.2022"
$CurrDotNetVer = get-itemproperty -name version,release "hklm:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\FULL"

$dir = $PSCommandPath | Split-Path -Parent
$dir = $dir + "\"

$CurrentScriptName = $MyInvocation.MyCommand
Push-Location $dir # the current folder from the stript was loaded 

# Global definitions

$BackupStatusFile = "FileWithResult.txt"
$hostname = $env:computername
$majorversion = $psversiontable.psversion.Major

$GLOBALtable = New-Object System.Data.DataTable
# add collumns needed to store informations 
$GLOBALtable.Columns.Add("KeyName") | Out-Null
$GLOBALtable.Columns.Add("KeyValue") | Out-Null
$GLOBALtable.Columns.Add("Explanation") | Out-Null
$GLOBALtable.Columns.Add("PossibleValues") | Out-Null 

$GLOBALtable

# global functions 

function GTAdd {
    param (
        [string]$KeyName, 
        [string]$KeyValue,
        [string]$Explanation,
        [string]$PossibleValues
    )
    # Write-Host "[GTAdd]  $KeyName, $KeyValue, $Explanation, $PossibleValues"
    $nr = $GLOBALtable.NewRow()
    $nr.KeyName = $KeyName
    $nr.KeyValue = $KeyValue
    $nr.Explanation = $Explanation
    $nr.PossibleValues = $PossibleValues
    $GLOBALtable.Rows.Add($nr)
}

Function Test-IsFileLocked {
    [cmdletbinding()]
    Param (
        [parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        [Alias('FullName','PSPath')]
        [string[]]$Path
    )
    Process {
        ForEach ($Item in $Path) {
            #Ensure this is a full path
            if ([System.IO.File]::Exists($Item))
                {$Item = Convert-Path $Item}
            #Verify that this is a file and not a directory
            If ([System.IO.File]::Exists($Item)) {
                Try {
                    $FileStream = [System.IO.File]::Open($Item,'Open','Write')
                    $FileStream.Close()
                    $FileStream.Dispose()
                    $IsLocked = $False
                } Catch [System.UnauthorizedAccessException] {
                    $IsLocked = 'AccessDenied'
                } Catch {
                    $IsLocked = $True
                }
                [pscustomobject]@{
                    File = $Item
                    IsLocked = $IsLocked
                }
            }
        }
    }
}
# end functions 



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

            Write-Host -ForegroundColor Cyan "[message]" archive is correct $TestResult 
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
            Write-Host -ForegroundColor Yellow "[job] expand archive  $database in folder $destFolder " 
            
            $ExpandResult = Expand-7Zip .\dsm0_20211006.dss $destFolder
            
            if ($ExpandResult)
            {# do domething with results in the future
            }

            Write-Host -ForegroundColor Yellow "[job] searching next level of archives "
            
            $searching = Get-Childitem $destFolder

            Write-Host -ForegroundColor Cyan "[message] found next archive level: $($searching.Name) " 
            
            # if is only tar it means that is not extracted if is also ConfigBkp the current archive was extracted

            if ($($searching.Name) -match "ConfigBkp")
            {

                            Write-Host -ForegroundColor Cyan "[message] second archive was extracted previously: "  $searching.Name 

                            #C:\Users\jdjd\Documents\GitHub\SynoDSSexporter\scripts\dsm0_20211006.dss_extracted\ConfigBkp

                            $extracted = $searching.DirectoryName + "\ConfigBkp"

                            $extractedDatabase = $extracted + "\_Syno_ConfBkp.db"
            
            }
            else
            {
                Write-Host -ForegroundColor Yellow "[job] extract second archive  " $searching.FullName 

                # test archive 

                Get-7ZipInformation $searching.FullName
                Expand-7Zip $($searching.FullName) $searching.DirectoryName
            }            

                $result2 = Get-ChildItem $extracted
                $result2.FullName

                # now you can try connect to the database 

                Write-Host -ForegroundColor Yellow "[job] connect to the database  $extractedDatabase "
                               
                $data_confbkp_config_tb = Invoke-SqliteQuery -DataSource $extractedDatabase -Query "SELECT * FROM confbkp_config_tb"

                ##$data_confbkp_config_tb | Get-Member  

                Write-Host -ForegroundColor Cyan "[message] Loaded number of keys " $data_confbkp_config_tb.Count
                
                # $data_confbkp_config_tb | Select-Object -ExpandProperty key

                # Try to ectract all informations compressed in these strings 
                
                # Write-Host -ForegroundColor Green "[volume info]"

                # $data_confbkp_config_tb.GetEnumerator() | Where-Object { $_.key -eq "Homeservice_volumePath" }
            
                # enumerate by all keys and theirs values 

                # dump all keys and values to readable txt file. 
                
                # Define global table to store all information 

                foreach ($item in $data_confbkp_config_tb) {

                    
                    # GTAdd "AAA" "BBB" "CCC" "DDD"
                    GTAdd $item.key $item.value "fakeValue" "fakeValue"
                    # Write-Host $item.key $item.value
                    
                }


                    $FileTest = Test-IsFileLocked($BackupStatusFile)
                
                    if ([bool]$FileTest.IsLocked -eq $False)
                    {
                        Write-Host "[STATUS] export to file --> " $BackupStatusFile  -ForegroundColor Yellow
                        $GLOBALtable | Export-Csv -Path $BackupStatusFile -NoTypeInformation
                        $data_confbkp_config_tb | Out-File -FilePath "RAW_data_from_hash.txt"
                        
                        }
                    else {
                          Write-Host "[export csv to file] opps ! someone opened the file outside!  --> $BackupStatusFile "  -ForegroundColor Red
                    }

        }
        else {
            write-host "this $database doesn't exsist on the disk im provided path " -ForegroundColor Red
        }
    }

# $GLOBALtable | ft KeyName,KeyValue,Explanation,PossibleValues
