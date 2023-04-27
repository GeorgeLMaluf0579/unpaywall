# Unpaywall

This project try to solve the following challenge:

"Use the Unpaywall Api to query the data snapshot (or live api), create an ROR api where you pass the text to the api, it returns a number of responses as a result, go through the results and extract only the ones which has pdf_url in them, display them and on the back download these all pdf files, now parse these pdf files to extract their text and save them in a data frame or db of choice. one row signifies text from one file, its DOI, title and authors in separate columns"

## Requirements

The requirements is just any computer with a internet conection and Docker and Docker-Compose installed

## Setup
### Download the source code
Run the follwing command on your shell:
````
$ git clone https://github.com/GeorgeLMaluf0579/unpaywall.git
````

### Build the containers
Get inside into project folder and run the command bellow:
````
$ make docker-build
````
### Setup database
Before run the project, you need setup the project database.To do that, call the following command:
````
$ make docker-setupdb
````

## Runing the project
To run the project, execute the following command:
````
$ docker-compose up
````

## Make a query
Can you use the follow URL request on Postman to see the results:
```
http://localhost:3000/api/v1/search?email=georgelmaluf286@gmail.com&expression=cardiology```

## Stop the project
Just call the docker to stop the containers, as bellow:
````
$ docker-compose down
````