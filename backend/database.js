const mongoose = require("mongoose");

//db
//mongodb+srv://zeinafawziad:x69qBREA7fLZcXYd@database.qfgldpf.mongodb.net/?retryWrites=true&w=majority&appName=database
//mongodb+srv://zeinafawziad:x69qBREA7fLZcXYd@database.qfgldpf.mongodb.net/?retryWrites=true&w=majority&appName=database
async function connectDB(){
    await mongoose.connect("mongodb+srv://zeinafawziad:x69qBREA7fLZcXYd@database.qfgldpf.mongodb.net/?retryWrites=true&w=majority&appName=database");
    console.log(" DB connected ");
}

connectDB();

