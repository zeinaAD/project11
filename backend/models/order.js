const mongoose = require("mongoose");

const { Sequence, getNextSequence } = require('./sequence'); 

const orderSchema = new mongoose.Schema({
  order_number: Number,
  user_id: { type:String , required:true},
  shipping_address: { type: String ,required:true },
  payment_method: { type: String , required:true},
  items: [
    {
      product_id: { type: String , required:true },
      product_name: {type: String, required:true},
      quantity: Number,
      price: Number
    }
  ],
  total_amount: Number,
  order_status: String,
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now }
});

orderSchema.pre('save', async function (next) {
  if (this.isNew) {  // Only set order_number for new documents
    this.order_number = await getNextSequence('order');
  }
  next();
});


const Order = mongoose.model('Order', orderSchema);

module.exports = Order;