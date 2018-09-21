$VerbosePreference = "Continue"
$DebugPreference = "Continue"

$ResourceGroupName = $args[0]
$ApplicationGateway = $args[1]
$Password = $args[2]
$WorkingDirectory = $args[3]

$hostn=(Get-AzureRmPublicIpAddress -ResourceGroupName $ResourceGroupName -Name "pip-$ApplicationGateway").DnsSettings.Fqdn
write-host "##vso[task.setvariable variable=host]$hostn"
$cert=New-SelfSignedCertificate -DnsName $hostn -CertStoreLocation "cert:\CurrentUser\My"
$pwd = ConvertTo-SecureString -String $Password -Force -AsPlainText
Export-PfxCertificate -cert "cert:\CurrentUser\My\$cert.thumbprint" -FilePath "$WorkingDirectory\appgwcert.pfx" -Password $pwd -Force
