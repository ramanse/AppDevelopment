//nodemon dbHandle.js
const express = require("express");
const morgan = require("morgan");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const dbConfig = require("./dbConfig.js");

const dbApp = express();
const connection = mysql.createConnection({
  host: dbConfig.HOST,
  user: dbConfig.USER,
  password: dbConfig.PASSWORD,
  database: dbConfig.DB,
  port: dbConfig.PORT
});

const Customer = function(customer) {
  this.customerName = customer.name;
  this.contact = customer.contact;
  this.dob = customer.dob;
};
// parse requests of content-type: application/x-www-form-urlencoded
dbApp.use(bodyParser.urlencoded({ extended: false }));

Customer.create = (req, res) => {
  console.log("inserting entry " + req.body.contact)
  var newCustId = 7
  const query = "SELECT COUNT(*) AS rowsCount FROM StyleCuts.appointments;"
  connection.query(query, (err, rows, fields) => {
      if (err) {
        console.log("Failed coz " + err)
      }
     console.log("connection successfull")
     newCustId = rows[0].rowsCount + 1
     const postQuery = "INSERT INTO appointments (customerId, customerName, contact, doa) VALUES (?, ?, ?, ?)"
     connection.query(postQuery, [newCustId, req.body.name, req.body.contact, req.body.doa], (err, res) => {
       if(err){
         console.log("Unable to insert " + err);
         return;
       }
       console.log("created customer")
       return;
     });
  });


};

dbApp.use(morgan('combined'));
dbApp.post("/customers/add", Customer.create);
dbApp.get("/customers/:id",(req,res)=>{
  console.log("Fetching customer details " + req.params.id);

  const id = req.params.id;
  const query = "SELECT * FROM appointments WHERE customerId = ?"
  connection.query(query, [id], (err, rows, fields) => {
      if (err) {
        console.log("Failed coz " + err)
      }
     console.log("connection successfull")
     res.json(rows)
  });
});


dbApp.get("/customers",(req,res)=>{

  const query = "SELECT * FROM appointments"
  connection.query(query, (err, rows, fields) => {
      if (err) {
        console.log("Failed coz " + err)
      }
     console.log("connection successfull")
     res.json(rows)
  });
});

// parse requests of content-type: application/json
dbApp.use(bodyParser.json());


// simple route
dbApp.get("/", (req, res) => {
  res.json({ message: "Welcome to StyleCuts." });
});

// set port, listen for requests
dbApp.listen(5001, () => {
  console.log("Server is running on port 5001.");
});
