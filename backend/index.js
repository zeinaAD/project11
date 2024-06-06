const express = require('express');
const app = express();
var connection=require('./database');
var bodyParser=require('body-parser');
const session = require('express-session');
var jsonParser = bodyParser.json();

var urlencoderParser=bodyParser.urlencoded({extended:false});

app.use(jsonParser); 

const signupController = require('./sign_up');
const loginController = require('./login');
const itemsController = require('./items');
const DYRitemsController = require('./DYRitems');
const GitemsController = require('./Gitems');
const ShippingController=require('./shippingController');
const CartController=require('./addtoCart');

app.post('/signup',urlencoderParser, signupController.handleSignup);
app.post('/login',urlencoderParser, loginController.handleLogin);
app.post('/itemStoring',urlencoderParser, itemsController.handleItemsStoring);
app.post('/DYRStoring',urlencoderParser, DYRitemsController.handleDYRItemsStoring);
app.post('/GitemStoring',urlencoderParser, GitemsController.handleGItemsStoring);
app.post('/shippingStoring',urlencoderParser, ShippingController.handleShippingStoring);
app.post('/addtoCart',urlencoderParser, CartController.handleAddToCart);

const Item = require('./models/item');
app.get('/fetchItems/:category', async (req, res) => {
    try {
      const category = req.params.category;
      const items = await Item.find({ category: category });
      res.status(200).json(items);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });

  const DYRItem = require('./models/DYRitem');

  app.get('/fetchDYR/:name', async (req, res) => {
    try {
      const name = req.params.name;
      console.log('Searching for:', name); // Debug: Log the name being searched
      const dyritem = await DYRItem.findOne({ name: name });
  
      if (dyritem) {
        res.status(200).json(dyritem);
      } else {
        res.status(404).json({ message: 'Item not found' });
      }
    } catch (error) {
      console.error('Error:', error.message); // Debug: Log errors
      res.status(500).json({ message: error.message });
    }
  });


const GItem = require('./models/Gitem');
app.get('/fetchGItems/:category', async (req, res) => {
    try {
      const category = req.params.category;
      const Gitems = await GItem.find({ category: category });
      res.status(200).json(Gitems);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });


  const User = require('./models/user');
  app.get('/getName/:email', async (req, res) => {
    const email = req.params.email; 

    if (!email) {
      return res.status(400).send('Email parameter is required');
    }
  
    try {
      const user = await User.findOne({ email: email });
      if (user) {
       res.json({ username: user.username }); // Corrected to user.username
       // res.status(200).json(user);
      } else {
        res.status(404).send('User not found');
      }
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });

  app.get('/getID/:email', async (req, res) => {
    const email = req.params.email; 

    if (!email) {
      return res.status(400).send('Email parameter is required');
    }
  
    try {
      const user = await User.findOne({ email: email });
      if (user) {
       res.json({ id: user._id }); // 
      // return user._id
       // res.status(200).json(user);
      } else {
        res.status(404).send('User not found');
      }
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });

  
  
  const Cart = require('./models/cart');
// app.get('/fetchCartItems/:userId', async (req, res) => {
//     try {
//       const userId = req.params.userId;
//       const Cartitems = await Cart.find({ userId: userId });
//       res.status(200).json(Cartitems);
//     } catch (error) {
//       res.status(500).json({ message: error.message });
//     }
//   });

app.get('/fetchCartItems/:userId', async (req, res) => {
  var quantity;
  try {
    const userId = req.params.userId;
    const cart = await Cart.findOne({ userId: userId }).lean();
    

    if (!cart) {
      return res.status(404).json({ message: "No cart found for this user." });
    }

    // Fetching product details for each item in the cart
    const itemsWithDetails = await Promise.all(
      cart.items.map(async item => {
        console.log("Current item:", item);
         quantity = item['quantity'];
         console.log(quantity);

         item = await Item.findById(item.productId).lean();
        if (!item) {
          return {
            //...item._doc,  // Spread operator to include all cart item properties
          ...item._doc,
            productName: "Product not found",
            producrImage: "image not found",
            productPrice: 0,
            productQuantity:0
          };
        }
        return {
          //...item._doc,  // Include other cart item properties like size, etc.
          ...item._doc,
          productName: item.name,
          productImage:item.image,
          productPrice: item.price,
          productQuantity:item['quantity']

        };
        
      })
    );
   // console.log("Processed items:", itemsWithDetails);
    // Construct the response object with cart details and the enhanced items array
    const response = {
      cartId: cart._id,
      userId: cart.userId,
      created_at: cart.created_at,
      updated_at: cart.updated_at,
      items: itemsWithDetails
    };

    res.status(200).json(response);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});
  

app.get('/', (req, res) => {
    res.send('Hello World!');
});


const port = 5000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});



