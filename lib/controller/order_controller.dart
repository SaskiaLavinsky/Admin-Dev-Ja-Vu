import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderController extends GetxController {
  var orders = [].obs; // Observable list of orders

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() {
    try {
      var firestore = FirebaseFirestore.instance;
      firestore.collection('orders').snapshots().listen((snapshot) {
        orders.value = snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  void updateOrderStatus(String orderId, String newStatus) async {
    try {
      var firestore = FirebaseFirestore.instance;
      await firestore.collection('orders').doc(orderId).update({'status': newStatus});
    } catch (e) {
      print(e);
    }
  }
}
