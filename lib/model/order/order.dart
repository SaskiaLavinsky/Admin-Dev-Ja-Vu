
class Order {
  final String customer;
  final String dateTime;
  final String menu;
  final String phone;
  final double price;
  final String serviceOptions;
  final String transactionId;

  Order({
    required this.customer,
    required this.dateTime,
    required this.menu,
    required this.phone,
    required this.price,
    required this.serviceOptions,
    required this.transactionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'customer': customer,
      'dateTime': dateTime,
      'menu': menu,
      'phone': phone,
      'price': price,
      'serviceOptions': serviceOptions,
      'transactionId': transactionId,
    };
  }
}
