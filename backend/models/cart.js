const mongoose = require('mongoose');

const cartSchema = new mongoose.Schema({
    userId: { type: String,required:true },
    items: [
      {
        productId: { type: String,required:true },
        size : {type:Number,required:false},
        quantity: { type: Number, required: true, min: 1 },
      }
    ],
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
  });

const Cart = mongoose.model('Cart', cartSchema);

module.exports = Cart;
