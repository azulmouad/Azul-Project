import 'package:azul_project/helpers/constants.dart';
import 'package:azul_project/widgets/widget_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexCategory = 0; // Home as Default

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context);

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            CardBarHome(
              onTap: () {
                //TODO: open drawer
              },
            ),
            Divider(
              color: Colors.grey.withOpacity(0.2),
              height: 0.05,
            ),
            Container(
              width: mSize.size.width,
              height: 45.0,
              decoration: BoxDecoration(
                gradient: kGradientBar,
              ),
              child: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                      icon: Icon(
                    FontAwesomeIcons.home,
                    size: 20.0,
                  )),
                  Tab(text: 'سياسة'),
                  Tab(text: 'مجتمع'),
                ],
              ),
            ),
            Flexible(
                child: TabBarView(
              children: [
                for (int i = 0; i < 3; i++) ArticlePages(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
