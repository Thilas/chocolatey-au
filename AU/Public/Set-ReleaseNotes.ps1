<#
.SYNOPSIS
  Updates nuspec file release notes

.DESCRIPTION
  This script should be called in au_AfterUpdate to update the release notes
  into releaseNotes tag of the Nuspec file. The current release notes will be replaced.
  
  You need to call this function manually only if you want to pass it custom parameters.
  In that case use NoReleaseNotes parameter of the Update-Package.

.EXAMPLE
  function global:au_AfterUpdate  { Set-ReleaseNotes -Package $args[0] -SkipLast 2 -SkipFirst 2 }
#>
function Set-ReleaseNotes{
    param(
      [AUPackage] $Package,
      [string] $ReleaseNotes
    )

    "Setting package release notes from $ReadmePath"

    $cdata = $Package.NuspecXml.CreateCDataSection("$ReleaseNotes".Trim())
    $xml_ReleaseNotes = $Package.NuspecXml.GetElementsByTagName('releaseNotes')[0]
    $xml_ReleaseNotes.RemoveAll()
    $xml_ReleaseNotes.AppendChild($cdata) | Out-Null

    $Package.SaveNuspec()
}
