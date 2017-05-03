class { "::mongodb::server": 
	port 	=> "27017",
	bind_ip	=> "10.1.2.13",
	noauth => "true",
}

mongodb::db { "UsersDB": 
	user		=> "Jack",
	password	=> "sheppard",
}

class { "sudo": }

sudo::conf { "vagrant":
  ensure => present,
  content  => "vagrant ALL=(ALL) NOPASSWD: ALL",
}

sudo::conf { "%admin":
  ensure => present,
  content  => "%admin ALL=(ALL) NOPASSWD: ALL",
}
