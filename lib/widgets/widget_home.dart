import 'package:azul_project/api/api.dart';
import 'package:azul_project/helpers/colors.dart';
import 'package:azul_project/helpers/constants.dart';
import 'package:azul_project/models/categories.dart';
import 'package:azul_project/screens/content_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardPostNews extends StatelessWidget {
  final onTap;
  final title;
  final Categories category;
  final image;
  final date;
  final idNews;

  CardPostNews({
    @required this.onTap,
    @required this.title,
    @required this.image,
    @required this.date,
    @required this.category,
    @required this.idNews,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 230.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                  color: kColorGreyNoMedia,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    errorWidget: (c, v, i) {
                      return Center(
                        child: Image(
                          image: AssetImage('assets/images/img_no_media.png'),
                          width: 100.0,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      '${category.name}',
                      style: kStyleCategory,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              '$title',
              style: kStyleTitlePost,
            ),
            Text(
              '${getDatePostNews(date)}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardBarHome extends StatelessWidget {
  final onTap;

  CardBarHome({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context);
    final paddingTopBar = mSize.padding.top;
    return Container(
      width: mSize.size.width,
      height: 60.0 + paddingTopBar,
      decoration: BoxDecoration(
        gradient: kGradientBar,
      ),
      padding: EdgeInsets.only(top: paddingTopBar),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.alignRight,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: onTap,
          ),
          Image(
            width: 75.0,
            image: AssetImage(
              'assets/images/icon.png',
            ),
          ),
          SizedBox(
            width: 35.0,
          ),
        ],
      ),
    );
  }
}

class CardTab extends StatelessWidget {
  final name;
  final bool isSelected;
  final Function onTap;

  CardTab({this.name, this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        height: 45.0,
        child: Center(
          child: Text(
            '$name',
            style: TextStyle(
              fontSize: isSelected ? 16.0 : 14.0,
              fontWeight: FontWeight.normal,
              color: isSelected ? kColorWhite : kColorWhite.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
