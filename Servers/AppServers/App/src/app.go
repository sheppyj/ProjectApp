package main

import (
	"os"
    "fmt"
    "net/http"
    "gopkg.in/mgo.v2"
    "gopkg.in/mgo.v2/bson"
    "time"
)

//
func signuppage(response http.ResponseWriter, request *http.Request, ){
	if request.Method != "POST" {
		http.ServeFile(response, request, "pages/signup.html" )
		return
	}

	username := request.FormValue("username")
	password := request.FormValue("password")

	type Auth struct {
	ID        bson.ObjectId `bson:"_id,omitempty"`
	UserID      string `bson:"UserID"`
	UserPassword     string `bson:"UserPassword"`
	Timestamp time.Time 
	}

	session, err := mgo.Dial("10.1.2.13")
		if err != nil {
			panic(err)
        }
        defer session.Close()
	
	// Collection People
	DBSession := session.DB("UsersDB").C("Logins")

	// Index
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

	result := Auth{}
	err = DBSession.Find(bson.M{"UserID": username}).One(&result)
	if err != nil {

		// Insert Datas
		err = DBSession.Insert(&Auth{UserID: username, UserPassword: password, Timestamp: time.Now()})
		if err != nil {
			panic(err)
		} else {
			fmt.Fprint(response, "User created succesfully!")
		}
	} else {
		fmt.Fprint(response, "That user already exists!")
	}
}

func returnuserspage(response http.ResponseWriter, request *http.Request, ) {

	if request.Method != "POST" {
		http.ServeFile(response, request, "pages/returnuser.html" )
		return
	}

	username := request.FormValue("username")

	type Auth struct {
		UserID      string `bson:"UserID"`
	}

	session, err := mgo.Dial("10.1.2.13")
		if err != nil {
			panic(err)
		}
		defer session.Close()


	DBSession := session.DB("UsersDB").C("Logins")

	result := Auth{}
	err = DBSession.Find(bson.M{"UserID": username}).One(&result)
	if err != nil {
		fmt.Fprint(response, "User " + username + " doesn't exist!")
	} else {
		fmt.Fprint(response, username + " exists!")
	}
}

func main() {
	http.HandleFunc("/signup.html", signuppage)
	http.HandleFunc("/returnuser.html", returnuserspage)
	http.ListenAndServe(":" + (os.Args[1]), nil)
}
