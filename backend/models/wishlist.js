const mongoose = require('mongoose');

const wishlistSchema = new mongoose.Schema({
    userId: { type: String,required:true },
    
    items: [
      {
        name: {type:String},
        productId: { type: String,required:true },
        price: { type: Number, required: true },
        image:{type: String , required:false},
        description:{type: String , required:false}
      }
    ],
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
  });

const Wishlist = mongoose.model('Wishlist', wishlistSchema);

module.exports = Wishlist;
