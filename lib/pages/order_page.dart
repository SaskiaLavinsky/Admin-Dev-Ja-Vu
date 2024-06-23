import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soft_dev_ja_vu/controller/order_controller.dart';

class OrdersPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 148, 45, 38),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Daftar Pesanan',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: orderController.orders.length,
            itemBuilder: (context, index) {
              final order = orderController.orders[index];
              print("Order Data: $order");
              
              final isCompleted = order['status'] == 'Completed';
              final isBeingDelivered = order['status'] == 'Being Delivered';
              final isInPreparation = order['status'] == 'In Preparation';

              Color cardColor;
              if (isCompleted) {
                cardColor = Colors.grey[300]!;
              } else if (isBeingDelivered) {
                cardColor = Colors.green[100]!;
              } else if (isInPreparation) {
                cardColor = Colors.yellow[100]!;
              } else {
                cardColor = Colors.white;
              }

              Color textColor = isCompleted ? Colors.grey[700]! : Colors.black;

              return Card(
                color: cardColor,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: order['products'].length,
                        itemBuilder: (ctx, idx) {
                          final product = order['products'][idx];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: product['image'] != null
                                    ? Image.network(
                                        product['image'],
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(Icons.image_not_supported, size: 60),
                                title: Text(
                                  product['menu'] ?? '',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Harga satuan menu: Rp ${product['price'] ?? 0}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Alegreya",
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      'Qty: ${product['quantity'] ?? 1}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Alegreya",
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      'Harga total: Rp ${(product['quantity'] ?? 1) * (product['price'] ?? 0)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Alegreya",
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Total Harga: Rp ${order['totalPrice'] ?? 0}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Alegreya",
                            color: textColor,
                          ),
                        ),
                      ),
                      Text(
                        'Nama Customer: ${order['customer'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Alegreya",
                          color: textColor,
                        ),
                      ),
                      Text(
                        'No Telpon: ${order['phoneNumber'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Alegreya",
                          color: textColor,
                        ),
                      ),
                      Text(
                        'Service Option: ${order['serviceOption'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Alegreya",
                          color: textColor,
                        ),
                      ),
                      if (order['serviceOption'] == 'Delivery')
                        Text(
                          'Alamat: ${order['address'] ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Alegreya",
                            color: textColor,
                          ),
                        ),
                      SizedBox(height: 5),
                      Text(
                        'Waktu Pesanan: ${order['dateTime'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status: ${order['status'] ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                          DropdownButton<String>(
                            value: order['status'],
                            items: <String>['In Preparation', 'Being Delivered', 'Completed']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newStatus) {
                              if (newStatus != null) {
                                orderController.updateOrderStatus(order['id'], newStatus);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
