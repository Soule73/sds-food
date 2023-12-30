import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sds_food/Models/item_model.dart';
import 'package:sds_food/Screens/cart/cart_out_screen.dart';

class CheckOutController extends GetxController {
  RxList<CartItem> itemInCart = <CartItem>[].obs;
  RxInt qtyCounter = 1.obs;
  RxInt itemInCartCount = 0.obs;
  RxDouble totalCart = 0.0.obs;
  RxBool payementInit = false.obs;

  setPayementInit(bool bool) => payementInit.value = bool;

  void incrementQtyCounter() => qtyCounter++;

  void addItemToCart(CartItem item) {
    // Check if any element in itemInCart has the same item as the given item, regardless of qty
    if (itemInCart.any((element) => element.item == item.item)) {
      itemInCart.remove(item);
    }
    itemInCart.add(item);

    itemInCartCount.value = itemInCart.length;
    sumTotalCart();

    Get.defaultDialog(
        title: "Ajouté !",
        content: const Center(
          child: FaIcon(
            FontAwesomeIcons.check,
            color: Colors.green,
            size: 40,
          ),
        ),
        confirm: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.pink,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(double.infinity, 50),
            ),
          ),
          onPressed: () => Get.to(() => CartOutScreen()),
          child: const Text(
            "Voir le panier",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onConfirm: () => Get.to(() => CartOutScreen()),
        confirmTextColor: Colors.pink);
  }

  void clearCart() {
    qtyCounter.value = 1;
    itemInCartCount.value = 0;
    totalCart.value = 0.0;
    payementInit.value = false;
    itemInCart.value = <CartItem>[];
  }

  void sumTotalCart() {
    totalCart.value = 0.0;
    for (int i = 0; i < itemInCart.length; i++) {
      CartItem itemCart = itemInCart[i];
      totalCart.value += itemCart.item.price! * itemCart.qty;
    }
  }

  void removeItemInCart(CartItem item) {
    itemInCart.remove(item);
    itemInCartCount.value = itemInCart.length;
    sumTotalCart();
  }

  void deIncrementQtyCounter() => qtyCounter > 1 ? qtyCounter-- : null;
}

class CartItem {
  final Item item;
  final int qty;

  // Override == operator to compare values
  @override
  bool operator ==(Object other) {
    if (other is CartItem) {
      return item == other.item;
      //  && qty == other.qty;
    } else {
      return false;
    }
  }

  // Override hashCode to be consistent with ==
  @override
  int get hashCode => item.hashCode;
  //  ^ qty.hashCode;
  CartItem({required this.item, required this.qty});
}
