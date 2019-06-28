---
title: Consuming a Moodle webservice 
categories:
    - Moodle
    - dev
    - webservices
tags:
    

---

This post describes how to consume a Moodle core webservice.

##Set up Moodle

### Enable REST protocol

In `Dashboard / ► Site administration / ► Plugins / ► Web services / ► Manage protocols` 

- enable REST protocol.
- enable `Web services documentation` too.
    

###Create a custom webservice

In `Dashboard / ► Site administration / ► Plugins / ► Web services / ► External services` 

- add a custom services named `test ws` for example

    
###Create a custom user for webservice
In `Dashboard / ► Site administration / ► Users / ► Accounts / ► Add a new user` 

- create a `wsuser` user.

###Create a custom role for webservice

In `Dashboard / ► Site administration / ► Users / ► Permissions / ► Define roles` 

- create a `ws_user_role`.
- allow at least `Create a web service token` 


###Assign role to user

`Dashboard / ► Site administration / ► Users / ► Permissions / ► Assign system roles`

##Test

### Get a cool REST client 
Getting a user friendly REST client is important, [POSTMAN is pretty cool](https://www.getpostman.com/).

###Get a token
Make a GET request to get a token. 

For instance:`https://192.168.33.10/login/token.php?service=test_ws&username=wsuser&password=Wsuser123456-`. You should get:

            {
              "token": "19f315a127eef1f7f381da40fefd7b75"
            }
###Consuming a Moodle core webservice

Now we get a token! So let's consume the `core_course_get_courses` WS. Results in JSON with `moodlewsrestformat=json`.

Make a POST request on `https://192.168.33.10/webservice/rest/server.php?wstoken=19f315a127eef1f7f381da40fefd7b75&wsfunction=core_course_get_courses&options[ids][0]=1&moodlewsrestformat=json`. You should get :
            
            [
              {
                "id": 1,
                "shortname": "test",
                "categoryid": 0,
                "fullname": "Site de test",
                "summary": "",
                "summaryformat": 1,
                "format": "site",
                "startdate": 0,
                "numsections": 1
              }
            ]

###API DOCUMENTATION

This can be found at `Dashboard / ► Site administration / ► Plugins / ► Web services / ► API Documentation`