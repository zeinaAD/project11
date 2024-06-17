const bodyParser = require('body-parser');
const connection = require('./database');
const Wishlist = require('./models/wishlist'); // Import the Cart model

async function handleAddToWishlist(req, res) {
    console.log('********* Request body 11:', req.body);
    const { productName ,productId,  userId,price ,image, description } = req.body;

    try {
        // Check if the cart for the user exists
        let wishlist = await Wishlist.findOne({ userId: userId });

        if (wishlist) {
            // Find item index in the cart's items array
            const itemIndex = wishlist.items.findIndex(item => item.productId === productId );

            // if (itemIndex > -1) {
            //     // Item exists in cart, update the quantity
            //     wishlist.items[itemIndex].quantity += quantity;
            // } else {
                // Item does not exist, add new item to the array
                wishlist.items.push({
                    productName,
                    productId,
                    price,
                    image,
                    description
                });
          //  }
        } else {
            // No cart for this user, create a new one with the item
            wishlist = new Wishlist({
                userId,
                items: [{
                    productName,
                    productId,
                    price,
                    image,
                    description
                }]
            });
        }
        // Save the updated or new cart
        await wishlist.save();
        res.status(200).send('wishlist Item added to cart successfully');
    } catch (error) {
        console.error('Error adding wishlist item :', error.message);
        res.status(500).send('Error adding wishlist item : ' + error.message);
    }
}

module.exports = { handleAddToWishlist };
