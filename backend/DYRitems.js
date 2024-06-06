var bodyParser=require('body-parser');
var urlencoderParser=bodyParser.urlencoded({extended:false});
var connection=require('./database');

const DYRitem = require('./models/DYRitem');

async function handleDYRItemsStoring(req, res) {
    console.log('********* Request body:', req.body);
    const {name,price,image,date,rname} = req.body;
  
    try {
      // Create a new student document
      const Ditem = new DYRitem({
        name , 
        price,
        image,
        date,
        rname
      });
  
      // Save the student document to the database
      await Ditem.save();
  
      res.status(200).send('DYR item storing successful');
    } catch (error) {
      console.error('Error inserting data into the database:', error.message);
      res.status(500).send('Error inserting data into the database: ' + error.message);
    }
  }
  
  module.exports = {handleDYRItemsStoring};