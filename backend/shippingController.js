var bodyParser = require('body-parser');
var urlencoderParser = bodyParser.urlencoded({ extended: false });
var connection = require('./database');

const Shipping = require('./models/shipping');

async function handleShippingStoring(req, res) {
 // console.log('********* Request body:', req.body);
  const { user_id, name, address, city, state, zipCode, phoneNumber, created_at, updated_at } = req.body;

  try {
    // const existingShipping = await Shipping.findOne({ user_id: user_id });

    // if (existingShipping) {
    //   // If shipping info exists, return the existing document
    //   console.log('Existing shipping info found for user:', existingShipping);
    //   res.status(200).json({
    //     message: 'Existing shipping information found.',
    //     data: existingShipping,
        
    //   });
    // }
      // Create a new Shipping document
      const newShipping = new Shipping({
        user_id,
        name,
        address,
        city,
        state,
        zipCode,
        phoneNumber,
        created_at: new Date(),
        updated_at: new Date()
    });

    // Save the new shipping document to the database
    await newShipping.save();
    console.log(' shipping information stored:', newShipping);
    res.status(201).json({
        message: 'Shipping information stored successfully',
       // data: newShipping
    });
  
  } catch (error) {
    console.error('Error handling shipping information:', error.message);
    // Ensure no response is sent if headers have already been sent
    if (!res.headersSent) {
        res.status(500).send('Error handling shipping information: ' + error.message);
    }
}
}

module.exports = { handleShippingStoring };