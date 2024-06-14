var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});
var connection=require('./database');

const Shipping = require('./models/payment');

async function handlePaymentStoring(req, res) {
    console.log('********* Request body:', req.body);
    const { name, address, city, state,zipCode, phoneNumber,date } = req.body;
  
    try {
      // Create a new Shipping document
      const shipping = new Shipping({
        name,
        address,
        city,
        state,
        zipCode,
        phoneNumber,
        date
      });
  
      // Save the shipping document to the database
      await shipping.save();
  
      res.status(201).send('Shipping information storing successful');
    } catch (error) {
      console.error('Error inserting data into the database:', error.message);
      res.status(500).send('Error inserting data into the database: ' + error.message);
    }
  }
  
  module.exports = {handlePaymentStoring};