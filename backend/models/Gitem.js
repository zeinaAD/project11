const mongoose = require('mongoose');

const GitemSchema = new mongoose.Schema({
  name: { type: String, required: true },
  category: { type: String, required: true },
  carat: {type: String, required: true},
  price: { type: Number, required: true },
  weight:{type: String, required:true},
  description: { type: String, required: true },
  image: { type: String, required: true },
  quantity: { type: Number, required: true },
  date: {type: String, required:true}

});

const GItem = mongoose.model('GItem', GitemSchema);

module.exports = GItem;
