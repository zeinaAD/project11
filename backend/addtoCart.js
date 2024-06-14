const bodyParser = require('body-parser');
const connection = require('./database');
const Cart = require('./models/cart'); // Import the Cart model

async function handleAddToCart(req, res) {
    console.log('********* Request body:', req.body);
    const { name ,productId, quantity, userId, size , image,price } = req.body;

   console.log('product id ' + productId);
   console.log('user id ' + userId);
   console.log('quantity ' + quantity);

    if (!productId) {
        return res.status(400).send('Missing product ID');
    }
    if (!userId) {
        return res.status(400).send('Missing user ID');
    }
    if (!quantity) {
        return res.status(400).send('Missing quantity');
    }

    try {
        // Check if the cart for the user exists
        let cart = await Cart.findOne({ userId: userId });

        if (cart) {
            // Find item index in the cart's items array
            const itemIndex = cart.items.findIndex(item => item.productId === productId && item.size === size);

            if (itemIndex > -1) {
                // Item exists in cart, update the quantity
                cart.items[itemIndex].quantity += quantity;
            } else {
                // Item does not exist, add new item to the array
                cart.items.push({

                    name,
                    productId,
                    quantity,
                    size,
                    image,
                    price
                });
            }
        } else {
            // No cart for this user, create a new one with the item
            cart = new Cart({
                userId,
                items: [{
                    name,
                    productId,
                    quantity,
                    size,
                    image,
                    price
                }]
            });
        }

        // Save the updated or new cart
        await cart.save();
        res.status(200).send('Item added to cart successfully');
    } catch (error) {
        console.error('Error adding item to cart:', error.message);
        res.status(500).send('Error adding item to cart: ' + error.message);
    }
}

module.exports = { handleAddToCart };
