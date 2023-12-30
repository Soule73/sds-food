import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sds_food/components/app_bar.dart';
import 'package:sds_food/components/bottom_nav.dart';
import 'package:sds_food/components/cart.dart';
import 'package:sds_food/components/drawer.dart';

class ScaffoldDefault extends StatelessWidget {
  const ScaffoldDefault({
    super.key,
    required this.body,
    this.actions,
    required this.title,
    this.bottomNameFalse = false,
    this.leading,
  });

  final List<Widget>? actions;
  final Widget body;
  final Widget? leading;
  final String title;
  final bool bottomNameFalse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: buildAppBar(context,
            leading: leading ??
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.bars,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
            // leading: const FaIcon(FontAwesomeIcons.bars),
            title: title,
            actions: actions ??
                <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0), child: Cart())
                ]),
        bottomNavigationBar: bottomNameFalse ? null : const BottomNavBar(),
        extendBody: true,
        body: SafeArea(child: body));
  }
}
