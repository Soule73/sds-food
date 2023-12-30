import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sds_food/layouts/app_footer.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          automaticallyImplyLeading: false, // cache la flèche de retour
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: screenWidth > 500
                    ? null
                    : Transform.translate(
                        offset: const Offset(0,
                            -5), // Décale le widget de 10 pixels vers le haut
                        child: Container(
                          width: double.infinity, // Prend toute la largeur
                          height: 50,
                          alignment: Alignment.topCenter, // Aligné en haut
                          child: SvgPicture.asset(
                            "assets/icons/wave.svg",
                            fit: BoxFit
                                .cover, // Remplit la largeur tout en conservant les proportions
                          ),
                        ),
                      ),
              ),
              Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 500, // Définissez la largeur maximale ici
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Stack(
                      children: <Widget>[
                        child,
                        const AppFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
