import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soft_dev_ja_vu/model/product/product.dart';

class HomeController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference orderCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'Category';
  String from = 'From';
  bool offer = false;

  List<Product> products = [];
  List<Order> orders = [];

  
 @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    orderCollection = firestore.collection('orders');
    await fetchProducts();
    super.onInit();
  }
  

  addProduct(){
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        from: from,
        image: productImgCtrl.text,
        offer: offer,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Succes', 'Product added successfully', colorText: Colors.green, backgroundColor: Colors.grey[300]);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red, backgroundColor: Colors.grey[300]);
      print(e);
  }
    
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs.map((doc) => 
        Product.fromJson(doc.data() as Map<String,dynamic>)).toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Product fetch successfully', colorText: Colors.green, backgroundColor: Colors.grey[300]);
    } catch (e) {
      Get.snackbar('Error', 'e.toString()', colorText: Colors.red, backgroundColor: Colors.grey[300]);
      print(e);
    }finally{
      update();
    }
  }

  deleteProduct(String id) async{
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
  } catch (e) {
    Get.snackbar('Error', e.toString(), colorText: Colors.red, backgroundColor: Colors.grey[300]);
    print(e);
  }
  }

  setValuesDefault(){
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productImgCtrl.clear();
    productPriceCtrl.clear();

     category = 'Category';
     from = 'From';
     offer = false;
     update();
  }
}