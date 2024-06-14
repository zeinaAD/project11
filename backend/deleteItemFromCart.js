const express = require('express');
const Cart = require('./models/cart'); // Adjust the path as necessary
const router = express.Router();

// Delete an item from the cart
router.delete('/cart/:userId/item/:itemId', async (req, res) => {
    const { userId, itemId } = req.params;

    try {
        // Find the cart by userId
        const cart = await Cart.findOne({ userId: userId });

        if (!cart) {
            return res.status(404).json({ message: "Cart not found" });
        }

        // Remove the item from the cart
        const updatedItems = cart.items.filter(item => item._id.toString() !== itemId);

        cart.items = updatedItems;
        cart.updatedAt = new Date(); // Update the 'updatedAt' field
        await cart.save();

        res.status(200).json({
            message: "Item removed from cart",
            cart: cart
        });
    } catch (error) {
        console.error('Error removing item from cart:', error);
        res.status(500).json({ message: "Error removing item from cart" });
    }
});

module.exports = router;
