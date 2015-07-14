param(
)

$nuget = '.\.nuget\NuGet.exe'
$Version = '9.0.4'
$OutDir = 'packages-2008'

$packages = @(
	# Visual Studio 2008 Metadata Package
	'VSSDK.IDE.9'
	'VSSDK.IDE.9Only'

	# Immutable COM-interop packages
	'VSSDK.Debugger.Interop.9'
	'VSSDK.DTE.9'
	'VSSDK.Shell.Interop.9'
	'VSSDK.TextManager.Interop.9'
	'VSSDK.VSLangProj.9'

	# Managed packages with binding redirects in newer versions of Visual Studio
	'VSSDK.DebuggerVisualizers.9'
	'VSSDK.Shell.9'
	'VSSDK.TemplateWizardInterface.9'
)

$wrappedPackages = @{
	# Managed packages with binding redirects in newer versions of Visual Studio
	# Note: the commented lines are packages which use unique assembly names in addition to binding redirects, so
	# wrapping is not necessary.
	'VSSDK.DebuggerVisualizers.9' = 'VSSDK.DebuggerVisualizers'
	#'VSSDK.Shell.9' = 'VSSDK.Shell'
	'VSSDK.TemplateWizardInterface.9' = 'VSSDK.TemplateWizardInterface'
}

# Create the output folder if it doesn't exist
if (!(Test-Path $OutDir))
{
	mkdir $OutDir | Out-Null
}

foreach ($package in $packages)
{
	&$nuget pack "$package\$package.nuspec" -Version $Version -OutputDirectory $OutDir
}

foreach ($package in $wrappedPackages.GetEnumerator())
{
	&$nuget pack "$($package.Key)\$($package.Value).nuspec" -Version $Version -OutputDirectory $OutDir
}
