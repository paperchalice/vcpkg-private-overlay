function New-PslDafsa() {
  $default_prefix = Resolve-Path -Path "$PSScriptRoot\..\..\..\.."
  python ${default_prefix}\libexec\psl-make-dafsa $Args
}

Set-Alias -Name psl-make-dafsa -Value New-PslDafsa

Export-ModuleMember -Function New-PslDafsa -Alias psl-make-dafsa
