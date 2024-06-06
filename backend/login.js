const User = require('./models/user'); // Assuming you have a User model defined
const bodyParser = require('body-parser');
const urlencoderParser = bodyParser.urlencoded({ extended: false });
const connection = require('./database');

async function handleLogin(req, res) {
    console.log('********* Request body:', req.body);
    const { email, password } = req.body;

    try {
        // Find the user by email in MongoDB
        const user = await User.findOne({ email: email }).exec();

        if (user) {
            // Compare passwords
            if (password === user.password) {
                req.email = user.email; // Assuming you're using sessions
               // res.json({token:"1234567890"});/////
                res.status(200).send('Login successful');
                
                console.log("login successful");
            } else {
                res.status(401).send('Incorrect password');
                console.log("incorrect password");
            }
        } else {
            res.status(404).send('User not found');
            console.log("user not found");
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Error querying the database');
    }
}

module.exports = {handleLogin};