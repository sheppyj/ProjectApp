class { "::mongodb::server": 
	port 	=> "27017",
	bind_ip	=> "10.1.2.13",
	noauth => "true",
}

mongodb::db { "UsersDB": 
	user		=> "Jack",
	password	=> "sheppard",
}