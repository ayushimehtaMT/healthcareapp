const functions = require("firebase-functions");
const admin = require("firebase-admin")

var serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://healthcareapp-a9eb7-default-rtdb.firebaseio.com"
});

const express = require("express");
const cors = require("cors")

//Main app
const app = express()
app.use(cors({ origin: true }))

//Main Database refference
const db = admin.firestore();

//Create get
app.get('/',(req,res) => {
return res.status(200).send('Test API response')
})

//Create post
app.post("/api/login/",(req,res) => {
    (async () => {
        try {
            await db.collection("userDetails").doc(`/${Date.now()}/`).create({
                id: Date.now(),
                name: req.body.name,
                mobile: req.body.password,
            })
            return res.status(200).send({status: "Success", msg: "data saved"})
        }
        catch(error){
            console.log(error)
            return res.status(500).send({status: "Failed", msg: "error"})
        }
    })()
})

//export our api to firebase and cloud functions
exports.app = functions.https.onRequest(app)
