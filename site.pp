class apache ($disable = "false") {
  if $disable == "false" {
    $installed = present
    $enable = true
    $ensure = "running"
  } else {
    $installed = absent
    $enable = false
    $ensure = "stopped"
  }
}
