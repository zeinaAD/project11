const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema({
  user_id: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  shipping_address_id: { type: mongoose.Schema.Types.ObjectId, ref: 'ShippingAddress' },
  payment_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Payment' },
  items: [
    {
      product_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Product' },
      quantity: Number,
      price: Number
    }
  ],
  total_amount: Number,
  order_status: String,
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now }
});

const Order = mongoose.model('Order', orderSchema);

module.exports = Order;