var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});
var connection=require('./database');
const GItem = require('./models/Gitem');

async function handleGItemsStoring(req, res) {
    console.log('********* Request body:', req.body);
    const { name, category, image ,carat ,price ,weight, quantity  , description ,date} = req.body;
  
    try {
      // Create a new student document
      const Gitem = new GItem({
        name , 
        category , 
        image ,
        carat,
        price , 
        weight,
        quantity  , 
        description,
        date
      });
  
      // Save the student document to the database
      await Gitem.save();
  
      res.status(200).send('Gitem storing successful');
    } catch (error) {
      console.error('G Error inserting data into the database:', error.message);
      res.status(500).send('G Error inserting data into the database: ' + error.message);
    }
  }
  
  module.exports = {handleGItemsStoring};