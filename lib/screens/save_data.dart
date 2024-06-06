// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart';
// //import 'package:data';

// class StoreData {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//     Reference ref = _storage.ref().child(childName + '.jpg');
//     UploadTask uploadTask = ref.putData(file);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }

//   Future<String> saveData({
//     required String id,
//     required Uint8List file,
//   }) async {
//     String resp = "error occurred";
//     try {
//       String imageUrl = await uploadImageToStorage("itemImage", file);

//       // MongoDB document to insert
//       var document = {
//         'id': id,
//         'imageurl': imageUrl,
//       };

//       // Access the 'items' collection and insert the new document
//       var collection = db!.collection('items');
//       await collection.insert(document);

//       resp = 'success';
//     } catch (e) {
//       resp = e.toString();
//     }
//     return resp;
//   }

//   Future<String?> getImageUrl(String id) async {
//     try {
//       var collection = db!.collection('items');
//       var result = await collection.findOne({'id': id});
//       if (result != null) {
//         return result['imageurl'] as String?;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("Error getting image URL: $e");
//       return null;
//     }
//   }
// }
