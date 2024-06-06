const mongoose = require("mongoose");

const shippingSchema = new mongoose.Schema({
  //username: { type: String, required: true },
//  user_id: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required:true },
user_id: { type: String, required:true },
  name: {type:String,required:true},
  address: {type:String,required:true},
  city: {type:String,required:true},
  state: {type:String,required:true},
  zipCode: {type:String,required:true},
  phoneNumber: {type:String,required:true},
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now }
});

const Shipping = mongoose.model('Shipping', shippingSchema);

module.exports = Shipping;
