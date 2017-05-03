class { "apache": }
class { "apache::mod::proxy": }
class { "apache::mod::proxy_balancer": }
class { "sudo": }

apache::balancer { "GoApp": }
	apache::balancermember { "10.1.2.11": 
		balancer_cluster	=> "GoApp",
		url					=> "http://10.1.2.11:8081",
	}
	apache::balancermember { "10.1.2.12": 
		balancer_cluster	=> "GoApp",
		url					=> "http://10.1.2.12:8082",
	}

apache::vhost { "10.1.2.10":
    servername => "10.1.2.10",
   	port => "8080",
   	docroot => "/var/www",
   	proxy_pass=> [
  		{ "path" => "/signup.html", "url" => "balancer://GoApp/signup.html" },
      { "path" => "/returnuser.html", "url" => "balancer://GoApp/returnuser.html" }
   		],
   	}

sudo::conf { "vagrant":
  ensure => present,
  content  => "vagrant ALL=(ALL) NOPASSWD: ALL",
}

sudo::conf { "%admin":
  ensure => present,
  content  => "%admin ALL=(ALL) NOPASSWD: ALL",
}

