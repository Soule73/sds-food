import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sds_food/Models/item_model.dart';
import 'package:sds_food/Screens/details/details.dart';
import 'package:sds_food/components/scaffold_default.dart';
import 'package:get/get.dart';
import 'package:sds_food/controllers/checkout_controller.dart';
import 'package:sds_food/controllers/stripe_payment_handle.dart';
import 'package:sds_food/utils/get_image_color_dominant.dart';

class CartOutScreen extends StatelessWidget {
  CartOutScreen({super.key});

  final StripePaymentHandle stripePaymentHandle = StripePaymentHandle();

  final CheckOutController checkOutController = Get.put(CheckOutController());
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
        leading: IconButton(
            icon: SvgPicture.asset('assets/icons/back.svg'),
            onPressed: () {
              Get.back();
            }),
        title: "Panier",
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Obx(() => checkOutController.itemInCart.isNotEmpty
              ? ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    for (int i = 0;
                        i < checkOutController.itemInCart.length;
                        i++)
                      CartItemWidget(
                        item: checkOutController.itemInCart[i].item,
                        qty: checkOutController.itemInCart[i].qty,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Total du panier : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "${checkOutController.totalCart} Mru",
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 50, // Fixé en bas
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () =>
                                stripePaymentHandle.stripeMakePayment(),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.pink,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                const Size(double.infinity, 50),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => checkOutController.payementInit.value
                                      ? const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                                Obx(
                                  () => checkOutController.payementInit.value
                                      ? Text(
                                          " En cours...",
                                          style: TextStyle(
                                              color: Colors.grey[100],
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20),
                                        )
                                      : Text(
                                          "Valider la commande",
                                          style: TextStyle(
                                              color: Colors.grey[100],
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20),
                                        ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Votre panier est vide"),
                ))),
        ));
  }
}

class CartItemWidget extends StatelessWidget {
  final Item item;
  final int qty;
  CartItemWidget({super.key, required this.item, required this.qty});

  final PaletteColorUtil paletteColorUtil = PaletteColorUtil();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Color?>>(
        future: paletteColorUtil
            .updatePaletteGenerator(NetworkImage(item.image!)), // async work
        builder: (BuildContext context, AsyncSnapshot<List<Color?>> snapshot) {
          final List<Color?> color = snapshot.data ??
              [
                Theme.of(context).cardColor,
                Theme.of(context).primaryColor,
                Colors.pink
              ];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: GestureDetector(
              onTap: () => Get.to(DetailsScreen(item: item)),
              child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color[0],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image(
                          image: NetworkImage(item.image!),
                          fit: BoxFit.fill,
                          height: double.infinity,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                item.name!.capitalize!,
                                style: TextStyle(
                                    color: color[1],
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'Prix : ',
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '${item.price} Mru',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: color[2],
                                              )),
                                        ],
                                        style: TextStyle(
                                          color: color[1],
                                        )),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Quantité : ',
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '$qty',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: color[2],
                                              )),
                                        ],
                                        style: TextStyle(
                                          color: color[1],
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Prix total ',
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '${qty * item.price!} Mru',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: color[2],
                                          )),
                                    ],
                                    style: TextStyle(
                                      color: color[1],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
