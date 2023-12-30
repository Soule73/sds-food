import 'dart:convert';

import 'package:currency_converter/currency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sds_food/Screens/home/home.dart';
import 'package:sds_food/components/alerte.dart';
import 'package:sds_food/controllers/checkout_controller.dart';
// import 'package:currency_converter/Currency.dart' as cc;
import 'package:currency_converter/currency_converter.dart';

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  CheckOutController checkOutController = Get.put(CheckOutController());
  Future<void> stripeMakePayment() async {
    try {
      double amount = await convertMRUToEUR(checkOutController.totalCart.value);
      checkOutController.setPayementInit(true);
      paymentIntent = await createPaymentIntent(
          amount.toString().replaceAll('.', ''), 'EUR');
      await Stripe.instance
          .initPaymentSheet(paymentSheetParameters: setupPayMentSheet())
          .then((value) {});
      checkOutController.setPayementInit(false);
      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      AlertMessage().alertMessage("Info", e.toString(), 'info', Get.back);
    }
  }

  SetupPaymentSheetParameters setupPayMentSheet() {
    return SetupPaymentSheetParameters(
      merchantDisplayName: 'SDS Food', // le nom de votre entreprise à afficher

      billingDetails: const BillingDetails(
          name: 'SDS',
          email: 'sds@gmail.com',
          phone: '+222 41308524',
          address: Address(
              city: 'Nouakchott',
              country: 'MR',
              line1: 'Capital ilot G',
              line2: '',
              postalCode: 'BP 58767',
              state: 'Tevragh-zeina')),
      paymentIntentClientSecret:
          paymentIntent!['client_secret'], //Gotten from payment intent
      style: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet().then((value) {
        if (kDebugMode) {
          print(value);
        }
      });
      checkOutController.clearCart();
      Get.defaultDialog(
          title: "Confirmation !",
          content: const Center(
              child: Column(
            children: [
              FaIcon(
                FontAwesomeIcons.check,
                color: Colors.green,
                size: 100,
              ),
              Text("Paiement effectué avec succès"),
              SizedBox(
                height: 50,
              )
            ],
          )),
          confirm: ElevatedButton(
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
            onPressed: () => Get.to(() => HomeScreen()),
            child: const Text("Ok"),
          ),
          onConfirm: () => Get.to(() => HomeScreen()),
          confirmTextColor: Colors.pink);
      // AlertMessage()
      //     .alertMessage("Succées", 'Paiement effectué avec succès', 'success');
    } on Exception catch (e) {
      if (e is StripeException) {
        if (kDebugMode) {
          print("Erreur de Stripe: ${e.error.localizedMessage}");
        }
        AlertMessage()
            .alertMessage("Erreur", 'Une erreur se produit', 'error', Get.back);
      } else {
        AlertMessage()
            .alertMessage("Erreur", 'Erreur imprévue: $e', 'error', Get.back);
      }
    }
  }

  Future<double> convertMRUToEUR(double amount) async {
    var usdConvert = await CurrencyConverter.convert(
      from: Currency.mro,
      to: Currency.eur,
      amount: amount,
    );
    return usdConvert!;
  }

//create Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//calculate Amount
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
