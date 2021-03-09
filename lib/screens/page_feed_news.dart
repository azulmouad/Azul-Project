import 'package:azul_project/helpers/colors.dart';
import 'package:azul_project/models/categories.dart';
import 'package:azul_project/models/news.dart';
import 'package:azul_project/widgets/widget_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'content_screen.dart';

class ArticlePages extends StatelessWidget {
  final List<News> newsContent;
  final Categories caty;
  final Function onLoadMore;

  ArticlePages({
    @required this.newsContent,
    @required this.caty,
    @required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(),
      children: [
        for (int index = 0; index < newsContent.length; index++)
          CardPostNews(
            title: newsContent[index].title.rendered,
            date: newsContent[index].date,
            linkFeature: newsContent[index].links.wpFeaturedmedia[0].href,
            category: caty,
            idNews: newsContent[index].id,
            onTap: () {
              Get.to(() => ContentScreen(
                    listNews: newsContent,
                    indexNews: index,
                    caty: caty,
                  ));
            },
          ),
        CardLoadMoreNews(onLoadMore: onLoadMore),
      ],
    );
  }
}

class CardLoadMoreNews extends StatelessWidget {
  final onLoadMore;

  CardLoadMoreNews({this.onLoadMore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.0, top: 10.0),
      child: RawMaterialButton(
        onPressed: onLoadMore,
        shape: CircleBorder(),
        child: Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
          ),
          child: Center(
            child: Icon(
              FontAwesomeIcons.plus,
              color: Colors.grey.shade300,
              size: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
