// Import the Firebase SDK for Google Cloud Functions.
const functions = require('firebase-functions');

// Import other required modules (e.g., Firebase Admin SDK).
const admin = require('firebase-admin');
admin.initializeApp();

// Example of an HTTP Cloud Function.
exports.helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});