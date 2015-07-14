param(
)

$nuget = '.\.nuget\NuGet.exe'
$Version = '7.0.4'
$OutDir = 'packages-base'

$packages = @(
	# Visual Studio Base Metadata Package
	'VSSDK.IDE'

	# Immutable COM-interop packages
	'VSSDK.Designer'
	'VSSDK.DTE'
	'VSSDK.OLE.Interop'
	'VSSDK.Shell.Interop'
	'VSSDK.TextManager.Interop'
	'VSSDK.VSHelp'
	'VSSDK.VSLangProj'
)

# Create the output folder if it doesn't exist
if (!(Test-Path $OutDir))
{
	mkdir $OutDir | Out-Null
}

foreach ($package in $packages)
{
	&$nuget pack "$package\$package.nuspec" -Version $Version -OutputDirectory $OutDir
}
