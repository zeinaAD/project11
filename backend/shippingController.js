var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});
var connection=require('./database');

const Shipping = require('./models/shipping');

async function handleShippingStoring(req, res) {
    console.log('********* Request body:', req.body);
    const { user_id,name, address, city, state,zipCode, phoneNumber,created_at,updated_at} = req.body;
  
    try {
      // Create a new Shipping document
      const shipping = new Shipping({
        user_id,
        name,
        address,
        city,
        state,
        zipCode,
        phoneNumber,
        created_at,
        updated_at///
      });
  
      // Save the shipping document to the database
      await shipping.save();
  
      res.status(201).send('Shipping information storing successful');
    } catch (error) {
      console.error('Error inserting data into the database:', error.message);
      res.status(500).send('Error inserting data into the database: ' + error.message);
    }
  }
  
  module.exports = {handleShippingStoring};