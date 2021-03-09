import 'package:azul_project/models/categories.dart';
import 'package:azul_project/models/news.dart';
import 'package:azul_project/widgets/widget_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'content_screen.dart';

class ArticlePages extends StatelessWidget {
  final List<News> newsContent;
  final Categories caty;

  ArticlePages({@required this.newsContent, @required this.caty});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(),
      itemCount: newsContent.length,
      itemBuilder: (context, index) {
        return CardPostNews(
          title: newsContent[index].title.rendered,
          date: newsContent[index].date,
          linkFeature: newsContent[index].links.wpFeaturedmedia[0].href,
          category: caty,
          onTap: () {
            Get.to(() => ContentScreen());
          },
        );
      },
    );
  }
}
