import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project1/api/firebase_api.dart';
import 'package:project1/models/designRings.dart';
import 'package:project1/models/product.dart';
import 'package:project1/screens/admin_page.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/chat.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/screens/productDetails.dart';
import 'package:project1/screens/profile.dart';
import 'package:project1/screens/ring_page.dart';
import 'package:project1/screens/screen.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/widgets/UserPreferences.dart';
import 'package:project1/widgets/imagePicker.dart';
import 'package:project1/models/user.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAZQ8JL_MGVA2SoXlpy1pOhs-E8k8wJKjs",
            authDomain: "gradprojfb.firebaseapp.com",
            databaseURL:
                "https://gradprojfb-default-rtdb.europe-west1.firebasedatabase.app",
            projectId: "gradprojfb",
            storageBucket: "gradprojfb.appspot.com",
            messagingSenderId: "9155793675",
            appId: "1:9155793675:web:4ae867ecae4fe113ea480e"));
    await FirebaseAppCheck.instance.activate();
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  await UserPreferences.init();
  runApp(const MyApp());
  // await FirebaseApi().initNotifications();
  //runApp(MyApp());
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => User(),
  //     child: MyApp(),
  //   ),
  // );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Product product;
  late design Design;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const CupertinoScrollBehavior(),
      initialRoute: '/',
      routes: {
        '/': (context) => loginpagee(),
        'ForgetPassword': (context) => ForgetPassword(),
        'CreateNewAccount': (context) => CreateNewAccount(),
        'MainScreen': (context) => MainScreen(),
        'DiamondScreen': (context) => DiamondScreen(),
        'GoldScreen': (context) => GoldScreen(),
        'DesignRingScreen': (context) => DesignRing(name: 'round diamond'),
        'SetPage': (context) =>
            RingPage(category: 'Set', title: '    Sets            '),
        'RingPage': (context) =>
            RingPage(category: 'Ring', title: '    Rings            '),
        'NecklacePage': (context) =>
            RingPage(category: 'Necklace', title: '   Necklaces      '),
        'BraceletPage': (context) =>
            RingPage(category: 'Bracelet', title: 'Bracelets       '),
        'EarringPage': (context) =>
            RingPage(category: 'Earring', title: 'Earings          '),
        'bestSellersPage': (context) =>
            RingPage(category: 'best', title: '  Our Best Sellers  '),
        'NewArrivalPage': (context) =>
            RingPage(category: 'new', title: '  Our New Ariivals  '),
        'chatPage': (context) => chat(),
        'ProductDetails': (context) => ProductDetails(product: product),
        'wishlist': (context) => wishlist(),
        'profile': (context) => profile(),
        'Cart': (context) => Cart(),
        'AdminPage': (context) => AdminPage(),
        'ImagePickerPage': (context) => ImagePickerPage(),

        //  'RingFingerDetection': (context) => RingFingerDetection(),
      },
    );
  }
}
