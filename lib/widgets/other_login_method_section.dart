import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sds_food/widgets/other_login_icon.dart';

class OtherLoginMethod extends StatelessWidget {
  const OtherLoginMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Center(
        child: SizedBox(
          width: 230,
          child: Column(
            children: [
              Text(
                "Or connect with",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  OtherLoginIcon(
                      bgColor: Colors.indigo,
                      faIcon: FontAwesomeIcons.facebookF),
                  OtherLoginIcon(
                      bgColor: Colors.blue, faIcon: FontAwesomeIcons.twitter),
                  OtherLoginIcon(
                      bgColor: Colors.red, faIcon: FontAwesomeIcons.google),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
