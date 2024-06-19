const mongoose = require('mongoose');

const gbestSellerSchema = new mongoose.Schema({
  name: { type: String, required: true },
  category: { type: String, required: true },
  price: { type: Number, required: true },
  description: { type: String, required: true },
  image: { type: String, required: true },
  quantity: { type: Number, required: true },
  date: {type: String, required:true}

});

const GBestSeller = mongoose.model('GBestSeller', gbestSellerSchema);

module.exports = GBestSeller;
