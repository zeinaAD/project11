const mongoose = require("mongoose");

const sequenceSchema = new mongoose.Schema({
  _id: String,
  seq: { type: Number, default: 0 }
});

const getNextSequence = async (sequenceName) => {
    const sequenceDocument = await Sequence.findOneAndUpdate(
      { _id: sequenceName },
      { $inc: { seq: 1 } },
      { new: true, upsert: true }  // Create the sequence if it doesn't exist
    );
    return sequenceDocument.seq;
  };
  

const Sequence = mongoose.model('Sequence', sequenceSchema);

module.exports = { Sequence, getNextSequence };
