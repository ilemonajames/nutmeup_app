// NUTMEUP
const functions = require('firebase-functions');
const debug = require('debug')('firestore-snippets-node');
const unirest = require('unirest');
const files = require('fs');
const mailler = require('nodemailer');

const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { getFirestore, Timestamp, FieldValue, GeoPoint } = require('firebase-admin/firestore');
const { user } = require('firebase-functions/v1/auth');
const { messaging } = require('firebase-admin');
const { ref } = require('firebase-functions/v1/database');

const geofirex = require('geofirex');
const admin = require('firebase-admin');
const { async } = require('rxjs');



initializeApp();
const db = getFirestore();
const gb = geofirex.init(admin);
const cities = db.collection('cities');




const USERS_TABLE = 'USERS';
const PRODUCTS_TABLE = 'PRODUCTS';
const STORE_TABLE = 'STORE';

exports.UPDATE_PRODUCTS_COUNT = functions.firestore.document(`${PRODUCTS_TABLE}/{productId}`)
    .onWrite(async (change, context) => {

        const productId = context.params.productId;
        await db.runTransaction(async (t) => {
            // read about new product
            await t.get(db.collection(PRODUCTS_TABLE).doc(productId)).then(async (doc) => {
                let storeOwnerId = doc.data().userId;
                // count all store product
                return t.get(db.collection(PRODUCTS_TABLE).where('storeId', '==', storeOwnerId)).then(async (docs) => {
                    let allStoreOwersProduct = docs.size;
                    return t.set(db.collection(STORE_TABLE).doc(storeOwnerId), { "_products": `${allStoreOwersProduct}` }, { merge: true });
                });
            });
        }).then(result => {
            console.log("Done")

        }).catch(err => {
            console.log("Error" + err)
        })
    });


exports.CREATE_SUGGESTIONS_I = functions.firestore
    .document(`${USERS_TABLE}/{userId}`)
    .onWrite(async (change, context) => {

        const center = gb.point(40.1, -119.1); // My location
        const radius = 100; // space around
        const field = 'position';


        const query = gb.query(cities).within(center, radius, field);
        console.log(query);
        query.subscribe(console.log);
        return "Empty";
    });

