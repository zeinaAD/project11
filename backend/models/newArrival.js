const mongoose = require('mongoose');

const newArrivalSchema = new mongoose.Schema({
  name: { type: String, required: true },
  category: { type: String, required: true },
  price: { type: Number, required: true },
  description: { type: String, required: true },
  image: { type: String, required: true },
  quantity: { type: Number, required: true },
  date: {type: String, required:true}

});

const NewArrival = mongoose.model('NewArrival', newArrivalSchema);

module.exports = NewArrival;
