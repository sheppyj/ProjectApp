class { "sudo": }

sudo::conf { "vagrant":
  ensure => present,
  content  => "vagrant ALL=(ALL) NOPASSWD: ALL",
}

sudo::conf { "%admin":
  ensure => present,
  content  => "%admin ALL=(ALL) NOPASSWD: ALL",
}

