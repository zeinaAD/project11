const express = require('express');
const app = express();
var connection = require('./database');
var bodyParser = require('body-parser');
const session = require('express-session');
var jsonParser = bodyParser.json();
const cors = require("cors");
const mongoose = require("mongoose");

var urlencoderParser = bodyParser.urlencoded({ extended: false });

app.use(jsonParser);
app.use(cors());

const signupController = require('./sign_up');
const loginController = require('./login');
const itemsController = require('./items');
const DYRitemsController = require('./DYRitems');
const GitemsController = require('./Gitems');
const ShippingController = require('./shippingController');
const CartController = require('./addtoCart');
const OrderController = require('./orderController');
const WishlistController = require('./addtoWishlist');

app.post('/signup', urlencoderParser, signupController.handleSignup);
app.post('/login', urlencoderParser, loginController.handleLogin);
app.post('/itemStoring', urlencoderParser, itemsController.handleItemsStoring);
app.post('/DYRStoring', urlencoderParser, DYRitemsController.handleDYRItemsStoring);
app.post('/GitemStoring', urlencoderParser, GitemsController.handleGItemsStoring);
app.post('/shippingStoring', urlencoderParser, ShippingController.handleShippingStoring);
app.post('/addtoCart', urlencoderParser, CartController.handleAddToCart);
app.post('/orderStoring', urlencoderParser, OrderController.handleOrderStoring);
app.post('/addtoWishlist', urlencoderParser, WishlistController.handleAddToWishlist);

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

const Wishlist = require('./models/wishlist');
app.get('/fetchWishlistItems/:id', async (req, res) => {
  try {
    const userId = req.params.id;
    const wishlist = await Wishlist.findOne({ userId: userId });

    if (!wishlist) {
      return res.status(404).send('no Wishlist found');
    }

    const items = await Promise.all(
      wishlist.items.map(async (item) => {
        let product = await Item.findById(item.productId);
        if (!product) {
          product = await GItem.findById(item.productId);
        }

        if (product) {
          return {
            ...item._doc,
            ...product._doc,
          };
        } else {
          return {
            ...item._doc,
            productName: 'Product not found',
            productPrice: 0,
            productImage: 'default_image.jpg', // Provide a default image if not found
          };
        }
      })
    );

    res.status(200).json(items);
  } catch (error) {
    res.status(500).send(error.message);
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

app.get('/getPhoneNumber/:email', async (req, res) => {
  console.log("inside get phone number");
  const email = req.params.email;

  if (!email) {
    return res.status(400).send('Email parameter is required');
  }

  try {
    const user = await User.findOne({ email: email });
    if (user) {
      res.json({ phoneNumber: user.phoneNumber }); // 
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
app.get('/fetchCartItems/:userId', async (req, res) => {

  try {
    const userId = req.params.userId;
    const cart = await Cart.findOne({ userId: userId });


    if (!cart) {
      return res.status(404).json({ message: "No cart found for this user." });
    }

    // Fetching product details for each item in the cart

    const itemsWithDetails = await Promise.all(
      cart.items.map(async item => {
        if (!mongoose.Types.ObjectId.isValid(item.productId)) {
          return {
            ...item,
            productName: "Invalid product ID",
            productPrice: 0,
            productSize: 'N/A',
            productQuantity: item.quantity,
            productImage: item.image || 'default_image.jpg', // Provide a default if none
            productName: item.name,
          };
        }
        let product = await Item.findById(item.productId);
        if (!product) {
          product = await GItem.findById(item.productId);
        }

        // const product = await Item.findById(item.productId);
        if (!product) {
          return {
            //...item._doc,  // Spread operator to include all cart item properties
            ...item,
            productId: item.productId,//
            productName: "Product not found",
            productPrice: 0,
            productSize: item.size || 'N/A',  // Default to 'N/A' if size is undefined
            productQuantity: item.quantity,
            productImage: item.image,
            productName: item.name,
          };
        }
        return {
          //...item._doc,  // Include other cart item properties like size, etc.
          ...product._doc,
          productId: product.id,///
          productName: product.name,
          productPrice: product.price,
          productSize: item.size || 'N/A',  // Use size from the cart, default to 'N/A' if not available
          productQuantity: item.quantity,
          productImage: product.image,
          productName: product.name,

        };

      })
    );
    // Construct the response object with cart details and the enhanced items array
    const response = {
      cartId: cart._id,
      userId: cart.userId,
      created_at: cart.created_at,
      updated_at: cart.updated_at,
      items: itemsWithDetails
    };
    // console.log(response);

    res.status(200).json(response);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//fetch orders of one user  
// const Order = require('./models/order');
// app.get('/orders/:userId', async (req, res) => {
//   try {
//     const userId = req.params.userId;
//     const orders = await Order.find({ user_id: userId })
//       .populate('user_id') // Optional: populate user details
//       .populate('shipping_address_id') // Optional: populate shipping address details
//       .populate('payment_id') // Optional: populate payment details
//       .populate('items.product_id'); // Optional: populate product details within items

//     if (!orders) {
//       return res.status(404).send('Orders not found');
//     }
//     res.json(order);
//   } catch (err) {
//     res.status(500).send('Server error');
//   }
// });

//fetch orders of one user  
const Order = require('./models/order');
app.get('/orders/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    const orders = await Order.find({ user_id: userId })
      .populate('user_id') // Optional: populate user details
      .populate('shipping_address_id') // Optional: populate shipping address details
      .populate('payment_id') // Optional: populate payment details
      .populate('items.product_id'); // Optional: populate product details within items

    if (!orders) {
      return res.status(404).send('Orders not found');
    }
    res.json(order);
  } catch (err) {
    res.status(500).send('Server error');
  }
});

// fetch one order 
app.get('/order/:userid', async (req, res) => {
  const userid = req.params.userid;
  console.log("inside order fetching api");
  try {
    const order = await Order.findOne({ user_id: userid });
    if (order) {
      const { _id, user_id, shipping_address, payment_method, items, total_amount, order_status, order_number } = order;
      res.json({ _id, user_id, shipping_address, payment_method, items, total_amount, order_status, order_number });
    } else {
      res.status(404).send('Order not found');
    }
  } catch (error) {
    console.error("Error in API logic:", error);
    res.status(500).send({ message: 'Error fetching order', error: error.message });
  }
});

//fetch best sellers 
const BestSeller = require('./models/bestSeller');
app.get('/fetchBestSellers', async (req, res) => {
  try {
    console.log("inside best sellers fetching api");

    const bestitems = await BestSeller.find();
    res.status(200).json(bestitems);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// fetch new arrivals 
const NewArrival = require('./models/newArrival');

app.get('/fetchNewArrivals', async (req, res) => {
  try {
    console.log("inside new arrivals fetching api");
    const newArrivals = await NewArrival.find({});
    res.status(200).json(newArrivals);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//fetch gbest sellers 
const GBestSeller = require('./models/gbestSellers');
app.get('/fetchGBestSellers', async (req, res) => {
  try {
    console.log("inside gbest sellers fetching api");

    const gbestitems = await GBestSeller.find();
    res.status(200).json(gbestitems);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// fetch gnew arrivals 
const GNewArrival = require('./models/gnewArrivals');

app.get('/fetchGNewArrivals', async (req, res) => {
  try {
    console.log("inside new arrivals fetching api");
    const gnewArrivals = await GNewArrival.find({});
    res.status(200).json(gnewArrivals);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//newest items
app.get('/fetchNewestItems', async (req, res) => {
  try {
    // Fetch items and sort them by 'createdAt' in descending order
    const items = await Item.find().sort({ date: -1 });
    res.status(200).json(items);
  } catch (error) {
    console.error('Failed to fetch items:', error);
    res.status(500).json({ message: error.message });
  }
});

//highest price 
app.get('/fetchItemsByHighestPrice', async (req, res) => {
  try {
    // Fetch items and sort them by 'price' in descending order
    const items = await Item.find().sort({ price: -1 });
    res.status(200).json(items);
  } catch (error) {
    console.error('Failed to fetch items:', error);
    res.status(500).json({ message: error.message });
  }
});

//lowest price
app.get('/fetchItemsByLowestPrice', async (req, res) => {
  try {
    // Fetch items and sort them by 'price' in ascending order
    const items = await Item.find().sort({ price: 1 });
    res.status(200).json(items);
  } catch (error) {
    console.error('Failed to fetch items:', error);
    res.status(500).json({ message: error.message });
  }
});

//search by name 
app.get('/searchItems', async (req, res) => {
  const searchTerm = req.query.name; // Get the search term from query parameters

  if (!searchTerm) {
    return res.status(400).json({ message: "No search term provided" });
  }

  try {
    // Use a case-insensitive regex search to find matching items
    const items = await Item.find({
      name: { $regex: new RegExp(searchTerm, 'i') } // 'i' makes it case insensitive
    });

    if (items.length === 0) {
      return res.status(404).json({ message: "No items found matching the search criteria" });
    }

    res.status(200).json(items);
  } catch (error) {
    console.error('Failed to fetch items:', error);
    res.status(500).json({ message: error.message });
  }
});

//search by description
app.get('/searchItemsByDescription', async (req, res) => {
  const searchTerm = req.query.description; // Get the search term from query parameters

  if (!searchTerm) {
    return res.status(400).json({ message: "No search term provided" });
  }

  try {
    // Use a case-insensitive regex search to find matching items by description
    const items = await Item.find({
      description: { $regex: new RegExp(searchTerm, 'i') } // 'i' makes it case insensitive
    });

    if (items.length === 0) {
      return res.status(404).json({ message: "No items found matching the search criteria" });
    }

    res.status(200).json(items);
  } catch (error) {
    console.error('Failed to fetch items:', error);
    res.status(500).json({ message: error.message });
  }
});


//update username
app.put('/editUsername/:id', (req, res) => {
  console.log("inside edit username api");
  console.log('Received body:', req.body);
  const { newUsername } = req.body;
  User.findByIdAndUpdate(req.params.id, { username: newUsername }, { new: true })
    .then(user => res.json(user))
    .catch(err => res.status(400).json('Error: ' + err));
});

// Update email
app.put('/editEmail/:id', (req, res) => {

  console.log("inside edit email api");
  console.log('Received body:', req.body);

  const { newEmail } = req.body;
  User.findOneAndUpdate({ _id: req.params.id, email: { $ne: newEmail } }, { email: newEmail }, { new: true, runValidators: true })
    .then(user => {
      if (user) {
        res.json(user);
      } else {
        res.status(400).json('Email update failed: Email may be in use or not changed.');
      }
    })
    .catch(err => res.status(400).json('Error: ' + err));
});

// Update phoneNumber
app.put('/editPhoneNumber/:id', (req, res) => {

  console.log("inside edit phonenumber api");
  console.log('Received body:', req.body);

  const { newPhoneNumber } = req.body;
  User.findOneAndUpdate({ _id: req.params.id, phoneNumber: { $ne: newPhoneNumber } }, { phoneNumber: newPhoneNumber }, { new: true, runValidators: true })
    .then(user => {
      if (user) {
        res.json(user);
      } else {
        res.status(400).json('Email update failed: Email may be in use or not changed.');
      }
    })
    .catch(err => res.status(400).json('Error: ' + err));
});

//update gold prices 
app.put('/update-prices', async (req, res) => {
  const { goldPrices } = req.body;

  // Convert the goldPrices array to a map for easier access
  const goldPricesMap = goldPrices.reduce((acc, price) => {
    acc[price.karat.toUpperCase()] = parseFloat(price.price);
    return acc;
  }, {});

  try {
    const items = await GItem.find({});
    const updates = items.map(async item => {
      const caratKey = item.carat.toUpperCase();
      console.log(`Updating item with ID ${item._id}: weight = ${item.weight}, carat = ${caratKey}, price per unit = ${goldPricesMap[caratKey]}`);

      const weight = parseFloat(item.weight);
      const pricePerUnit = goldPricesMap[caratKey];

      if (isNaN(weight) || pricePerUnit === undefined) {
        console.error(`Invalid data for item with ID ${item._id}: weight = ${weight}, pricePerUnit = ${pricePerUnit}`);
        return item; // Skip updating this item
      }

      const newPrice = weight * pricePerUnit;
      return GItem.findByIdAndUpdate(item._id, { $set: { price: newPrice } }, { new: true });
    });

    const updatedItems = await Promise.all(updates);
    res.json({ success: true, updatedItems });
  } catch (error) {
    res.status(500).send({ success: false, message: error.message });
  }
});

// get last item added to items collection
app.get('/last-item', async (req, res) => {
  try {
    const lastItem = await Item.findOne().sort({ date: -1 });
    if (!lastItem) {
      return res.status(404).json({ message: "No items found." });
    }
    res.json(lastItem);
  } catch (error) {
    res.status(500).json({ message: "Server error", error: error.message });
  }
});



app.get('/', (req, res) => {
  res.send('Hello World!');
});


const port = 5000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});



