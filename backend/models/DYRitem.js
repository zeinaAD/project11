const mongoose = require('mongoose');

const DYRitemSchema = new mongoose.Schema({
  name: { type: String, required: true },
  price: { type: String, required: true },
  image: { type: String, required: true },
  date: {type: String, required:true}

});

const DYRitem = mongoose.model('DYRitem', DYRitemSchema);

module.exports = DYRitem;
