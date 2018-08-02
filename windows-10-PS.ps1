#Can you run Docker tools as an alias in Windows 10 Power Shell?Yes you can! We need Docker for Windows to be installed.

#Create anew folder in your %HOME%\Documents\WindowsPowerShell\

#Create new file in newly created folder Microsoft.PowerShell_profile.ps1

Add the below entries:

#docker rm $(docker ps -a -q)
function Remove-StoppedContainers {
 foreach ($id in & docker ps -a -q) { 
 & docker rm $id }
}
# docker inspect — format ‘{{ .NetworkSettings.Networks.nat.IPAddress }}’ <id>
function Get-ContainerIPAddress {
 param (
 [string] $id
 )
 & docker inspect — format ‘{{ .NetworkSettings.Networks.nat.IPAddress }}’ $id
}
#docker run gcloud
function Docker-Run-Gcloud {
 docker run -ti — rm -v ~./.kube:/root/.kube -v ~./.config:/root/.config mudrii/gcloud-cli gcloud $args
}
#docker run terraform
function Docker-Run-Terraform {
 docker run -ti — rm mudrii/terraform-cli $args
}
#docker run packer
function Docker-Run-Packer {
 docker run -ti — rm mudrii/packer-cli $args
}
#docker run packer
function Docker-Run-Azure {
 docker run -v ${HOME}:/root -it — rm azuresdk/azure-cli-python az $args
}
New-Alias drm Remove-StoppedContainers
New-Alias dip Get-ContainerIPAddress
New-Alias gcloud Docker-Run-Gcloud
New-Alias terraform Docker-Run-Terraform
New-Alias packer Docker-Run-Packer
New-Alias az Docker-Run-Azure
