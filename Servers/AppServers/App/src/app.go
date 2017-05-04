package main

import (
	//required for commandline arguements
	"os"
	//required for display of text I/O functions
	"fmt"
	//required for http
	"net/http"
	//required for interacting with the mongodb database
	"gopkg.in/mgo.v2"
	//required for communication with the mongodb eg data transfer/storage
	"gopkg.in/mgo.v2/bson"
	//required for timestamping user
	"time"
)

//create signuppage function that will serve the signup page to the user to allow them to create a username and password.
//Error if the user already exists.
func signuppage(response http.ResponseWriter, request *http.Request, ){
	//if request isn't a post server the html page, else post the data to below functions
	if request.Method != "POST" {
		http.ServeFile(response, request, "pages/signup.html" )
		return
	}
	//retrieved from the fields found in the html file
	username := request.FormValue("username")
	password := request.FormValue("password")
	
	//create the structure of my data, ID being a unique, UserID being the username input from the user
	//UserPassword being the plaintext user password and Timestamp being the time.
	type Auth struct {
	ID        bson.ObjectId `bson:"_id,omitempty"`
	UserID      string `bson:"UserID"`
	UserPassword     string `bson:"UserPassword"`
	Timestamp time.Time 
	}
	//Make sure the Database is actually alive and serving requests else panic
	session, err := mgo.Dial("10.1.2.13")
		if err != nil {
			panic(err)
        }
        defer session.Close()
	
	//Create the dbsession in the UsersDB database (created by vagrant/puppet) and connect to the logins collection.
	DBSession := session.DB("UsersDB").C("Logins")

	//make the index for the data we care about and are about to insert
	index := mgo.Index{
		Key:        []string{"UserID", "UserPassword"},
		Unique:     true,
		DropDups:   true,
		Background: true,
		Sparse:     true,
	}
	err = DBSession.EnsureIndex(index)
	if err != nil {
		panic(err)
	}
	
	//using the session we created try and find the userID input by the user in the database
	result := Auth{}
	err = DBSession.Find(bson.M{"UserID": username}).One(&result)
	if err != nil {
		//Good! looks like our userID is free, input the userID and the userPassword into the database
		err = DBSession.Insert(&Auth{UserID: username, UserPassword: password, Timestamp: time.Now()})
		if err != nil {
			panic(err)
		} else {
			//print message to the user that their userID has been created
			fmt.Fprint(response, "User created succesfully!")
		}
	} else {
		//Bad! looks like the user already exists. Print message.
		fmt.Fprint(response, "That user already exists!")
	}
}

//create returnuser function that will serve the returnuser page to the user to allow them to search the database for
//the existance of the username and return a "found" or "not found" type message
func returnuserspage(response http.ResponseWriter, request *http.Request, ) {
	//if request isn't a post server the html page, else post the data to below functions
	if request.Method != "POST" {
		http.ServeFile(response, request, "pages/returnuser.html" )
		return
	}
	
	//retrieved from the html fields
	username := request.FormValue("username")
	
	//create our data structure for when we do our search
	type Auth struct {
		UserID      string `bson:"UserID"`
	}
	
	//Make sure the Database is actually alive and serving requests else panic
	session, err := mgo.Dial("10.1.2.13")
		if err != nil {
			panic(err)
		}
		defer session.Close()

	//Create the dbsession in the UsersDB database (created by vagrant/puppet) and connect to the logins collection.
	DBSession := session.DB("UsersDB").C("Logins")
	
	//using the session we created earlier try and find the input userID in the database.
	result := Auth{}
	err = DBSession.Find(bson.M{"UserID": username}).One(&result)
	if err != nil {
		//cant find the userID in the database therefore print message the the user doesn't exist.
		fmt.Fprint(response, "User " + username + " doesn't exist!")
	} else {
		//found the user so print the message accoringly
		fmt.Fprint(response, username + " exists!")
	}
}

//main function
func main() {
	//serve the signup page function	
	http.HandleFunc("/signup.html", signuppage)
	//serve the return user page function
	http.HandleFunc("/returnuser.html", returnuserspage)
	//using a command line argument eg "80" listen port
	http.ListenAndServe(":" + (os.Args[1]), nil)
}
