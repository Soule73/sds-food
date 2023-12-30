import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sds_food/Screens/home/home.dart';
import 'package:get/get.dart';
import 'package:sds_food/components/scaffold_default.dart';

class CircleImagesController extends GetxController {
  var menu = {}.obs;

  void setMenu(Map<String, String> menu) {
    menu = menu;
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleImages();
  }
}

class CircleImages extends StatelessWidget {
  CircleImages({super.key});

  // Variable pour suivre l'image sélectionnée
  final CircleImagesController _ciircleImagesController =
      Get.put(CircleImagesController());

  void _showDetailsBottomSheet(BuildContext context, Map<String, String> menu) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
              // leading: const Icon(Icons.image),
              title: Center(
                  child: Text(
                menu['name'] ?? "Detail du menu",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.pink),
              )),
              subtitle: Image.asset(menu['img']!),
            ),
            // Ajoutez d'autres ListTile ici pour plus de détails
          ],
        );
      },
    ).whenComplete(() {
      // Lorsque le BottomSheet est fermé, réinitialisez les variables
      _ciircleImagesController.setMenu({});
    });
  }

  // Une liste de menu à afficher
  final List<Map<String, String>> menuImg = [
    {'name': 'Hamburger', 'img': 'assets/food/hamburger_1.png'},
    {'name': 'Salade', 'img': 'assets/food/salade_1.png'},
    {
      'name': 'Gateau au chocola',
      'img': 'assets/food/gateau_chocolat_round.png'
    },
    {
      'name': 'Créme au chocola',
      'img': 'assets/food/boisson_creme_cholocat.png'
    },
    {'name': 'Begné', 'img': 'assets/food/begné.png'},
    {'name': 'Boisson coca', 'img': 'assets/food/boisson_coca_black.png'},
    {'name': 'Frutes', 'img': 'assets/food/frutes.png'},
    {'name': 'Zrig', 'img': 'assets/food/boisson_chocolat.png'},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // La taille du cercle imaginaire
    const double circleSize = 350.0;
    // Le rayon des images circulaires
    const double avatarRadius = 35;
    // L'angle entre chaque image circulaire
    final double angleStep = 2 * pi / menuImg.length;
    // Le centre du cercle imaginaire
    const Offset center = Offset(circleSize / 2, circleSize / 2);

    return ScaffoldDefault(
        bottomNameFalse: true,
        title: "",
        body: Stack(
          children: [
            screenWidth > 500
                ? Container()
                : Transform.translate(
                    offset: const Offset(
                        0, -5), // Décale le widget de 10 pixels vers le haut
                    child: Container(
                      width: double.infinity, // Prend toute la largeur
                      height: 80,
                      alignment: Alignment.topCenter, // Aligné en haut
                      child: SvgPicture.asset(
                        "assets/icons/wave.svg",
                        fit: BoxFit
                            .cover, // Remplit la largeur tout en conservant les proportions
                      ),
                    ),
                  ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    Text(
                      "Bienvenue",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "SDS Food",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Sofia',
                          fontWeight: FontWeight.w700,
                          color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              // Utilisez un Container pour définir la taille du Stack
              child: SizedBox(
                width: circleSize,
                height: circleSize,
                child: Stack(
                  children: <Widget>[
                    // Pour chaque URL d'image, on crée un widget CircleAvatar
                    // et on le positionne sur le cercle imaginaire
                    for (int i = 0; i < menuImg.length; i++)
                      Positioned(
                        // Les coordonnées du widget CircleAvatar sont calculées
                        // à partir du centre, du rayon et de l'angle du cercle imaginaire
                        left: center.dx +
                            (circleSize / 2 - avatarRadius) *
                                cos(i * angleStep) -
                            avatarRadius,
                        top: center.dy +
                            (circleSize / 2 - avatarRadius) *
                                sin(i * angleStep) -
                            avatarRadius,
                        child: GestureDetector(
                          onTap: () =>
                              _showDetailsBottomSheet(context, menuImg[i]),
                          child: CircleAvatar(
                            radius: avatarRadius -
                                2, // Le rayon intérieur pour l'image
                            backgroundColor:
                                Colors.pink, // La couleur de la bordure

                            child: ClipOval(
                              child: Image.asset(
                                menuImg[i]['img']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Ajoutez un grand cercle au milieu avec le texte
                    Positioned(
                      left: center.dx - 90,
                      top: center.dy - 90,
                      // left: 50,
                      // top: 50,
                      child: Container(
                        width: 90 * 2,
                        height: 90 * 2,
                        decoration: BoxDecoration(
                            // color: Colors.black, // La couleur du cercle
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/food/bg.png"),
                              fit: BoxFit
                                  .cover, // Couvre toute la zone disponible
                            ),
                            border: Border.all(color: Colors.pink, width: 5)),
                        alignment: Alignment.center,
                        child: const Text(
                          'Nos Plats',
                          style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sofia",
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50, // Fixé en bas
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => Get.to(() => HomeScreen()),
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
                    child: Text(
                      "Aller au menu",
                      style: TextStyle(
                          color: Colors.grey[100],
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    )),
              ),
            ),
          ],
        ));
  }
}
