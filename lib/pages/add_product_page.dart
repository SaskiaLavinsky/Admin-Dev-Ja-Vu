import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soft_dev_ja_vu/controller/home_controller.dart';
import 'package:soft_dev_ja_vu/widgets/drop_down_btn.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 148, 45, 38), // Set the background color
            title: Text(
              "Dev Ja Vu Admin",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),
            iconTheme: IconThemeData(
          color: Colors.white, // Set the icon color to white
        ),
          ),
          body:  SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add Product', 
                      style: TextStyle(
                        fontSize: 30, 
                        color: Color.fromARGB(255, 148, 45, 38), 
                        fontWeight: FontWeight.bold),
                  ),
                  
                  SizedBox(height: 10,),
                  TextField(
                    controller: ctrl.productNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      label: Text('Product Name'),
                      hintText: 'Enter Your Product Name'
                    ),
                  ),
                  
                  SizedBox(height: 10,),
                  TextField(
                    controller: ctrl.productDescriptionCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      label: Text('Product Description'),
                      hintText: 'Enter Your Product Description'
                    ),
                    maxLines: 4,
                  ),
                  
                  SizedBox(height: 10,),
                  TextField(
                    controller: ctrl.productImgCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      label: Text('Image Url'),
                      hintText: 'Enter Your Image Url'
                    ),
                  ),
                  
                  SizedBox(height: 10,),
                  TextField(
                    controller: ctrl.productPriceCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      label: Text('Price'),
                      hintText: 'Enter Your Product Price'
                    ),
                  ),
                  
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Flexible(
                        child: DropDownBtn(
                          items: ['Makanan Utama', 'Makanan Ringan', 'Minuman', 'Paket Hemat'], 
                          selectedItemText: ctrl.category, 
                          onSelected: (selectedValue) {
                            ctrl.category = selectedValue ?? 'general';
                            ctrl.update();
                          },
                        )
                      ),
                      Flexible(
                        child: DropDownBtn(
                          items: ['Sumatra', 'Jawa', 'Sulawesi', 'Kalimantan', 'Papua', 'General'], 
                          selectedItemText: ctrl.from, 
                          onSelected: (selectedValue) { 
                            ctrl.from = selectedValue ?? 'Unknown';
                            ctrl.update();
                           },
                        )
                      ),
                    ],
                  ),
                
                  SizedBox(height: 10,),
                  Text('Offer Product?'),
                  DropDownBtn(
                    items: ['true', 'false'], 
                    selectedItemText: ctrl.offer.toString(), 
                    onSelected: (selectedValue ) { 
                      ctrl.offer = bool.tryParse(selectedValue ?? 'false') ?? false;
                      ctrl.update();
                     },
                  ),
        
                  SizedBox(height: 10,),
                  ElevatedButton(
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 148, 45, 38),
                    foregroundColor: Colors.white
                   ), 
                    onPressed: (){
                      ctrl.addProduct();
                    }, child: Text('Add Product'))
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}