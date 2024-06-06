const mongoose = require("mongoose");

const paymentSchema = new mongoose.Schema({
  user_id: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  order_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Order' },
  payment_method: String,
  card_number: String,
  expiration_date: String,
  cvv: String,
  billing_address: String,
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now }
});

const Payment = mongoose.model('Payment', paymentSchema);

module.exports = Payment;
