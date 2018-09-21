$VerbosePreference = "Continue"
$DebugPreference = "Continue"

$ResourceGroupName = $args[0]
$ApplicationGateway = $args[1]
$Password = $args[2]
$WorkingDirectory = $args[3]

$hostn=(Get-AzureRmPublicIpAddress -ResourceGroupName $ResourceGroupName -Name "pip-$ApplicationGateway").DnsSettings.Fqdn
write-host "##vso[task.setvariable variable=host]$hostn"

write-verbose "Start New-SelfSignedCertificate"
$cert=New-SelfSignedCertificate -DnsName $hostn -CertStoreLocation "cert:\CurrentUser\My"
write-verbose "End New-SelfSignedCertificate"

write-verbose "Password: $Password : $pwd"
$pwd = ConvertTo-SecureString -String $Password -Force -AsPlainText

write-verbose "dir cert cert:\CurrentUser\My"
dir cert:\CurrentUser\My

write-verbose "Start Export-PfxCertificate"
Export-PfxCertificate -cert "cert:\CurrentUser\My\$cert.thumbprint" -FilePath "$WorkingDirectory\appgwcert.pfx" -Password $pwd -Force
write-verbose "End Export-PfxCertificate"
