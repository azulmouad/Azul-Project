import 'package:azul_project/helpers/colors.dart';
import 'package:azul_project/helpers/constants.dart';
import 'package:azul_project/models/categories.dart';
import 'package:azul_project/models/news.dart';
import 'package:azul_project/widgets/widgets_content_news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class ContentScreen extends StatefulWidget {
  final List<News> listNews;
  final int indexNews;
  final Categories caty;

  ContentScreen({
    @required this.listNews,
    @required this.indexNews,
    @required this.caty,
  });

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  int _selectedPage = 0;
  bool _progress = false;
  PageController _pageController;

  @override
  void initState() {
    _selectedPage = widget.indexNews;
    _pageController = PageController(
      initialPage: _selectedPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CardTopBarContent(selectedIndexPost: _selectedPage),
          _progress ? LinearProgressIndicator() : SizedBox(),
          CardBarContent(),
          Flexible(
            child: PageView(
              onPageChanged: (val) {
                setState(() {
                  _selectedPage = val;
                });
              },
              controller: _pageController,
              children: [
                for (int i = 0; i < widget.listNews.length; i++)
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: widget.listNews[i].image,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 230.0,
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  color: kColorGreyNoMedia,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.listNews[i].image,
                                    fit: BoxFit.cover,
                                    errorWidget: (c, v, i) {
                                      return Center(
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/img_no_media.png'),
                                          width: 100.0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Text(
                                      '${widget.caty.name}',
                                      style: kStyleCategory,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${widget.listNews[i].title.rendered}',
                            style: kStyleTitlePost,
                          ),
                          SizedBox(height: 3),
                          Text(
                            '${getDatePostArticle(widget.listNews[i].date)}',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          CardSharePost(),
                          Html(
                            data:
                                "<div>${widget.listNews[i].content.rendered}</div>",
                            style: {
                              'div': Style(
                                fontWeight: FontWeight.normal,
                                color: kColorBlack01,
                                fontFamily: 'AlJazeera',
                                fontSize: FontSize(18.0),
                              ),
                            },
                          ),
                          CardSharePost(),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
