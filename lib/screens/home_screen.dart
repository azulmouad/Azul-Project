
import 'dart:io';

import 'package:azul_project/api/api.dart';

import 'package:azul_project/helpers/constants.dart';
import 'package:azul_project/models/categories.dart';
import 'package:azul_project/models/news.dart';
import 'package:azul_project/screens/page_feed_news.dart';
import 'package:azul_project/widgets/widget_home.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  ScrollController _listController = ScrollController();

  int _indexCategory = 0; // Home as Default
  int _pageCount = 1; // Count 1 as Default
  bool _progress = true;
  bool _deviceIsOnline = true;

  List<Categories> _listCategories = [];
  List<News> _listNews = [];

  _getCategories() async {
    final _categories = await ApiHelper.getHomeCategories();

    for (var i = 0; i < _categories.length; i++) {
      setState(() {
        _listCategories.add(Categories(
          name: _categories[i].name,
          id: _categories[i].id,
        ));
      });
    }
  }

  _getNewsSelectedCategory() async {
    final List<News> _listNewsApi =
        await ApiHelper.getHomeNews(pageIndex: _pageCount);
    for (var news in _listNewsApi) {
      setState(() {
        _listNews.add(News(
          id: news.id,
          title: news.title,
          date: news.date,
          links: news.links,
          content: news.content,
          image: news.image,
        ));
      });
    }

    setState(() {
      _progress = false;
    });
  }

  _checkDeviceConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          _deviceIsOnline = true;
          _progress = true;
        });
        _listCategories.clear();
        _listNews.clear();
        _getCategories();
        _getNewsSelectedCategory();
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        _deviceIsOnline = false;
      });
      //show snack to user
      final snackBar = SnackBar(
          content: Text(
              'يرجى تشغيل اتصال الإنترنت الخاص بك للحصول على آخر الأخبار'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    _getCategories();
    _getNewsSelectedCategory();
    _checkDeviceConnection();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context);
    return Scaffold(
      body: Column(
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
            child: ListView(
              controller: _listController,
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < _listCategories.length; i++)
                  CardTab(
                    name: _listCategories[i].name,
                    isSelected: _indexCategory == i,
                    onTap: () {
                      setState(() {
                        _indexCategory = i;
                        _pageController.animateToPage(_indexCategory,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInBack);
                      });
                    },
                  ),
              ],
            ),
          ),
          _progress ? LinearProgressIndicator() : SizedBox(),
          Flexible(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _indexCategory = index;
                });
                _listController.animateTo(
                  50.0 * index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                );
              },
              children: [
                for (int i = 0; i < _listCategories.length; i++)
                  ArticlePages(
                    newsContent: _listNews,
                    caty: _listCategories[_indexCategory],
                    onRefrech: () async {
                      await _checkDeviceConnection();
                    },
                    onLoadMore: _deviceIsOnline
                        ? () {
                            setState(() {
                              _progress = true;
                              _pageCount = _pageCount + 1;
                            });
                            _getNewsSelectedCategory();
                          }
                        : null,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
