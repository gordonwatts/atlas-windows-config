#
# Run to configure a node with the tools we often use to do work.
#

# See if the package feed is there. If not, then install it.
$repo = Get-PSRepository | ? {$_.Name -eq "atlas-myget"}
if (!$repo) {
	Register-PSRepository -name "atlas-myget" -source https://www.myget.org/F/gwatts-powershell/api/v2 -InstallationPolicy Trusted
}

# Next, if we don't have a module, then update it.
function install-or-update ($module)
{
	$listing = get-module -ListAvailable $module
	if ($listing) {
		Update-Module $module
	} else {
		Install-Module -scope CurrentUser $module
	}
}

install-or-update "PSJenkinsAccessCommands"
install-or-update "PSAtlasDatasetCommands"

# Finally, list it all.
Get-Module -ListAvailable

# And the result of the location
Write-Host "GRID Location Info"
Get-GridDataLocations
