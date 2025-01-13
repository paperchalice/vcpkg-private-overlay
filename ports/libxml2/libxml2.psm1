$default_prefix = Resolve-Path -Path "$PSScriptRoot\..\..\.."

function Get-Xml2Config {
  param (
    [switch]$Help,
    [string]$Prefix,
    [switch]$ShowPrefix,
    [switch]$Libs,
    [switch]$Cflags,
    [switch]$Module,
    [switch]$Dynamic,
    [switch]$Version
  )

  $prefix = $default_prefix

  if ($Help) {
    $help_text = @'
Usage: Get-Xml2Config [OPTION]

Known values for OPTION are:
  -Prefix:DIR		change libxml prefix [default {0}]
  -Libs		      print library linking information
  -Cflags		    print pre-processor and compiler flags
  -Help		      display this help and exit
  -Version		  output version information
'@ -f $default_prefix
    return $help_text
  }

  if ($Prefix) {
    $prefix = $Prefix
  }

  if ($ShowPrefix) {
    return $prefix
  }

  if ($Version) {
    return "@VERSION@"
  }

  if ($Module) {
    $true
    return
  }

  $output = @()
  if ($Cflags) {
    $output += "/I", "$prefix\include"
  }
  if ($Libs) {
    if ($Dynamic) {
      $output += "/LIBPATH:$prefix\lib", "xml.lib"
    }
    else {
      $output += "/LIBPATH:$prefix\lib", "xml.lib", "lzma.lib", "zlib.lib", "iconv.lib", "WS2_32.lib", "bcrypt.lib"
    }
  }

  return $output
}

Export-ModuleMember -Function Get-Xml2Config
