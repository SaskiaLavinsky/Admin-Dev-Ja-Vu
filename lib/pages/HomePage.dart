import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soft_dev_ja_vu/controller/home_controller.dart';
import 'package:soft_dev_ja_vu/pages/add_product_page.dart';
import 'package:soft_dev_ja_vu/pages/order_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),  // Ensures HomeController is properly initialized
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 148, 45, 38),
            title: Text(
              "Dev Ja Vu Admin",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.list_alt, color: Colors.white),
                onPressed: () {
                  Get.to(OrdersPage());
                },
              ),
            ],
          ),
          body: ctrl.products.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: ctrl.products.length,
                  itemBuilder: (context, index) {
                    final product = ctrl.products[index];
                    return ListTile(
                      leading: product.image != null
                          ? Image.network(product.image!, width: 50, height: 50, fit: BoxFit.cover)
                          : Icon(Icons.image, size: 50),
                      title: Text(product.name ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: ${(product.price ?? 0).toString()}'),
                          Text('Category: ${product.category}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteDialog(context, ctrl, product.id ?? '');
                        },
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(AddProductPage());
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 148, 45, 38),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, HomeController ctrl, String productId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Product'),
        content: Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ctrl.deleteProduct(productId);
              Get.back();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
