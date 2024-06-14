const mongoose = require('mongoose');

const cartSchema = new mongoose.Schema({
    userId: { type: String,required:true },
    
    items: [
      {
        productName: {type:String},
        productId: { type: String,required:true },
        size : {type:Number,required:false},
        quantity: { type: Number, min: 1 },
        image:{type: String , required:false},
        price: { type: Number, required: true },
      }
    ],
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
  });

const Cart = mongoose.model('Cart', cartSchema);

module.exports = Cart;
