import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final _storage = GetStorage();
  final _list = <CartProduct>[].obs;
  List<CartProduct> get getItems => _list;

  double get totalPrice =>
      _list.fold(0.0, (sum, item) => sum + (item.price * item.qty));

  int get count => _list.length;

  CartController() {
    loadCart();
  }

  bool itemExists(int id) {
    return _list.any((item) => item.id == id);
  }

  void addItem(int id, String name, double price, int qty, String imageUrls) {
    final product = CartProduct(
        id: id, imageUrls: imageUrls, name: name, price: price, qty: qty);
    _list.add(product);
    saveCart();
  }

  void increment(CartProduct product) {
    product.increase();
    _list.refresh();
    saveCart();
  }

  void decrement(CartProduct product) {
    product.decrease();
    _list.refresh();
    saveCart();
  }

  void removeItem(CartProduct product) {
    _list.remove(product);
    saveCart();
  }

  void clearCart() {
    _list.clear();
    saveCart();
  }

  void saveCart() {
    final jsonList = _list.map((item) => item.toJson()).toList();
    _storage.write('cart', jsonList);
  }

  void loadCart() {
    final jsonList = _storage.read<List<dynamic>>('cart') ?? [];
    _list.value = jsonList.map((json) => CartProduct.fromJson(json)).toList();
  }
}

class CartProduct {
  int id;
  String name;
  String imageUrls;
  double price;
  int qty;

  CartProduct(
      {required this.id,
      required this.imageUrls,
      required this.name,
      required this.price,
      this.qty = 1});

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
      id: json["id"],
      imageUrls: json["image"],
      name: json["name"],
      price: json["price"],
      qty: json["qty"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "price": price, "image": imageUrls, "qty": qty};

  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }
}
