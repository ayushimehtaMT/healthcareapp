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
                id: Date.now(),
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


// Create Cart
app.post("/api/v1/carts", async (req, resp) => {
    const cart = req.body;
    await db.collection('carts').add(cart);
    resp.status(201).send();
});

// Get User's Cart
app.get('/api/v1/carts/:userId', async (req, resp) => {
    db.collection('carts').where("userId", "==", req.params.userId)
        .get()
        .then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                resp.status(200).send(doc.data());
        })
    });
});

// Update User's Cart
app.put("/api/v1/carts/:userId", async (req, resp) => {
    db.collection('carts').where("userId", "==", req.params.userId).get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
            db.collection('carts').doc(doc.id).update(req.body);
            resp.status(200).send();
        })
    });
});

// Place Order
app.post("/api/v1/orders", async (req, resp) => {
    const cart = req.body;
    await db.collection('orders').add(cart);
    resp.status(201).send();
});

// Get User's All Orders
app.get('/api/v1/userorders/:userId', async (req, resp) => {
    db.collection('orders').where("userId", "==", req.params.userId)
        .get()
        .then((querySnapshot) => {
            var orders = new Array();
            querySnapshot.forEach((doc) => {
                orders.push(doc.data());
            })
            resp.status(200).send(orders);
        });
});

// Get order by id
app.get('/api/v1/orders/:id', async (req, resp) => {
    db.collection('orders').where("id", "==", req.params.id)
        .get()
        .then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                resp.status(200).send(doc.data());
        })
    });
});

//export our api to firebase and cloud functions
exports.app = functions.https.onRequest(app)
