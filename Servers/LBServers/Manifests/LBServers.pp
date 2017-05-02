class { "apache": }
class { "apache::mod::proxy": }
class { "apache::mod::proxy_balancer": }

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
  		{ "path" => "/sign*", "url" => "balancer://GoApp/signup.html" },
  		{ "path" => "/", "url" => "balancer://GoApp/signup.html" },
  		{ "path" => "/returnuser*", "url" => "balancer://GoApp/returnuser.html" },
  		{ "path" => "/user*", "url" => "balancer://GoApp/returnuser.html" },
      { "path" => "/health*", "url" => "balancer://GoApp/health.html" }
   		],
   	}