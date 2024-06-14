const mongoose = require('mongoose');

const bestSellerSchema = new mongoose.Schema({
  name: { type: String, required: true },
  category: { type: String, required: true },
  price: { type: Number, required: true },
  description: { type: String, required: true },
  image: { type: String, required: true },
  quantity: { type: Number, required: true },
  date: {type: String, required:true}

});

const BestSeller = mongoose.model('BestSeller', bestSellerSchema);

module.exports = BestSeller;
