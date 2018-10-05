#Set TMG log location
$TMGLogLocation = "C:\TMGLogs"

#Set the log location of this script
$date = Get-Date -Format FileDateTimeUniversal
$TranscriptPath = "C:\TransferLogs\" + $date + ".log"
Start-Transcript -Path $TranscriptPath -Append

Import-Module PSFTP 

$user = "" #FTP user name provided in MCAS portal 
$pass = "" #FTP password provided in MCAS portal

$str = ConvertTo-SecureString $pass -AsPlainText -Force 
$psc = New-Object System.Management.Automation.PsCredential($user, $str) 
$credential = Get-Credential -Credential $psc


"/////////////////// Started Transfering ///////////////////"
Get-Date

"----------Set-FTPConnection---------"
Set-FTPConnection -Credentials $credential -Server ftp://192.168.6.21 -UsePassive -KeepAlive -Verbose

$file = Get-ChildItem -Path $TMGLogLocation | Sort-Object -Descending | Select-Object -Index 1
echo $file

"----------Add-FTPItem---------"
Add-FTPItem -Path "/TMG" -LocalPath $file.FullName -Overwrite -Verbose

Get-Date
"/////////////////// Finished Transfering ///////////////////"

Stop-Transcript