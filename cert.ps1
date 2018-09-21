
$hostn=(Get-AzureRmPublicIpAddress -ResourceGroupName $(we.ResourceGroupName) -Name "pip-$(ApplicationGateway)").DnsSettings.Fqdn
write-host "##vso[task.setvariable variable=host]$hostn"
$cert=New-SelfSignedCertificate -DnsName $hostn -CertStoreLocation "cert:\CurrentUser\My"
$pwd = ConvertTo-SecureString -String $(Password) -Force -AsPlainText
Export-PfxCertificate -cert "cert:\CurrentUser\My\$cert.thumbprint" -FilePath "$(System.DefaultWorkingDirectory)\appgwcert.pfx" -Password $pwd -Force
