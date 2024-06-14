var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});
var connection=require('./database');

//const User = require('./models/user');
const Item = require('./models/item');

async function handleItemsStoring(req, res) {
    console.log('********* Request body:', req.body);
    const { name, category, image,price , quantity  , description } = req.body;
  
    try {
      // Create a new student document
      const item = new Item({
        name , 
        category , 
        image ,
        price , 
        quantity  , 
        description,
       // date
      });
  
      // Save the student document to the database
      await item.save();
  
      res.status(200).send('item storing successful');
    } catch (error) {
      console.error('Error inserting data into the database:', error.message);
      res.status(500).send('Error inserting data into the database: ' + error.message);
    }
  }
  
  module.exports = {handleItemsStoring};