########################################################################## <br />
Introduction <br />
This is a side project for fun to try out vagrant. <br />
Vagrant built infrastructure that provisions four servers; two application <br />
servers running a very basic golang application that talks to a database <br />
server running mongodb and one apache loadbalancer. The go application <br />
has a sign up page for a user to put in a username and password and there <br />
is also a returnuser page that will look in the database for a username <br />
and return if it exists or not. Each server is using puppet as it's <br />
configuration manager to install and configure certain aspects of the <br />
the solution eg apache loadbalancing configuration. <br />
 <br />
########################################################################## <br />
Solution built using macOS Sierra v10.12.4 <br />
Solution built using Vagrant 1.9.3 <br />
Solution built using VirtualBox 5.1.18 r114002 <br />
 <br />
########################################################################## <br />
Design decisions <br />
Each server "type" has its own directory to try and logically separate <br />
things. <br />
CommonScripts was supposed to be a repository for scripts that were used <br />
more than once across the solution however only one script of its kind <br />
was needed. <br />
 <br />
root <br />
├── README.md <br />
├── Servers <br />
│   ├── AppServers <br />
│   │   ├── App <br />
│   │   │   └── src <br />
│   │   │       ├── app.go <br />
│   │   │       └── pages <br />
│   │   │           ├── returnuser.html <br />
│   │   │           └── signup.html <br />
│   │   ├── Manifests <br />
│   │   │   └── AppServers.pp <br />
│   │   └── Scripts <br />
│   │       ├── InstallGo.sh <br />
│   │       ├── InstallMods.sh <br />
│   │       └── StartWebserver.sh <br />
│   ├── CommonScripts <br />
│   │   └── ReadyMachine.sh <br />
│   ├── DBServers <br />
│   │   ├── Manifests <br />
│   │   │   └── DBServers.pp <br />
│   │   └── Scripts <br />
│   │       └── InstallMods.sh <br />
│   └── LBServers <br />
│       ├── Manifests <br />
│       │   └── LBServers.pp <br />
│       └── Scripts <br />
│           ├── InstallMods.sh <br />
│           └── TestApache.sh <br />
└── vagrantfile <br />
 <br />
########################################################################## <br />
Improvements <br />
Everything is very barebones, each aspect of the solution could be improved <br />
eg a more interesting/better golang application, better security on the <br />
database and better rules on the loadbalancer server. <br />
 <br /> 
