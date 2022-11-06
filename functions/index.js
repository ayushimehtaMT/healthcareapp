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

//Create post
app.post("/api/v1/login/",(req,res) => {
    (async () => {
        try {
            await db.collection("userDetails").doc(`/${Date.now()}/`).create({
                userId: Date.now(),
                name: req.body.name,
                password: req.body.password,
            })
            return res.status(200).send({status: "Success", msg: "data saved"})
        }
        catch(error){
            console.log(error)
            return res.status(500).send({status: "Failed", msg: "error"})
        }
    })()
})

app.get('/api/v1/getLoginDetail/', async (req, resp) => {
    db.collection('userDetails').get()
        .then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                resp.status(200).send(doc.data());
        })
    });
  });

app.get('/api/v1/search/:id', async (req, resp) => {
    db.collection('medicineList').where("id", "==", req.params.id)
        .get()
        .then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                resp.status(200).send(doc.data());
        })
    });
});

app.get('/api/v1/checkout/:userId', async (req, resp) => {
  db.collection('orderedList').where("userId", "==", req.params.userId)
      .get()
      .then((querySnapshot) => {
          querySnapshot.forEach((doc) => {
              resp.status(200).send(doc.data());
      })
  });
});

app.post("/api/v1/checkout", async (req, resp) => {
  const cart = req.body;
  await db.collection('orderedList').add(cart);
  resp.status(201).send();
});

//export our api to firebase and cloud functions
exports.app = functions.https.onRequest(app)
