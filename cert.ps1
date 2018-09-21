$VerbosePreference = "Continue"
$DebugPreference = "Continue"

Param(
    [parameter(Mandatory=$true)][String]$ResourceGroupName,
    [parameter(Mandatory=$true)][String]$ApplicationGateway,
    [parameter(Mandatory=$true)][String]$Password,
    [parameter(Mandatory=$true)][String]$WorkingDirectory
)

$hostn=(Get-AzureRmPublicIpAddress -ResourceGroupName $ResourceGroupName -Name "pip-$ApplicationGateway").DnsSettings.Fqdn
write-host "##vso[task.setvariable variable=host]$hostn"
$cert=New-SelfSignedCertificate -DnsName $hostn -CertStoreLocation "cert:\CurrentUser\My"
$pwd = ConvertTo-SecureString -String $Password -Force -AsPlainText
Export-PfxCertificate -cert "cert:\CurrentUser\My\$cert.thumbprint" -FilePath "$WorkingDirectory\appgwcert.pfx" -Password $pwd -Force
