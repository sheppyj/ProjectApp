##########################################################################
Introduction
This is a side project for fun to try out vagrant.
Vagrant built infrastructure that provisions four servers; two application
servers running a very basic golang application that talks to a database
server running mongodb and one apache loadbalancer. The go application
has a sign up page for a user to put in a username and password and there
is also a returnuser page that will look in the database for a username
and return if it exists or not. Each server is using puppet as it's 
configuration manager to install and configure certain aspects of the
the solution eg apache loadbalancing configuration.

##########################################################################
Solution built using macOS Sierra v10.12.4
Solution built using Vagrant 1.9.3
Solution built using VirtualBox 5.1.18 r114002

##########################################################################
Design decisions
Each server "type" has its own directory to try and logically separate
things.
CommonScripts was supposed to be a repository for scripts that were used
more than once across the solution however only one script of its kind 
was needed.

root
├── README.md
├── Servers
│   ├── AppServers
│   │   ├── App
│   │   │   └── src
│   │   │       ├── app.go
│   │   │       └── pages
│   │   │           ├── returnuser.html
│   │   │           └── signup.html
│   │   ├── Manifests
│   │   │   └── AppServers.pp
│   │   └── Scripts
│   │       ├── InstallGo.sh
│   │       ├── InstallMods.sh
│   │       └── StartWebserver.sh
│   ├── CommonScripts
│   │   └── ReadyMachine.sh
│   ├── DBServers
│   │   ├── Manifests
│   │   │   └── DBServers.pp
│   │   └── Scripts
│   │       └── InstallMods.sh
│   └── LBServers
│       ├── Manifests
│       │   └── LBServers.pp
│       └── Scripts
│           ├── InstallMods.sh
│           └── TestApache.sh
└── vagrantfile

##########################################################################
Improvements
Everything is very barebones, each aspect of the solution could be improved
eg a more interesting/better golang application, better security on the
database and better rules on the loadbalancer server.
