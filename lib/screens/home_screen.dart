import 'package:azul_project/api/api.dart';
import 'package:azul_project/helpers/colors.dart';
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
      // if (_listCategories[_indexCategory].id == news.categories[0]) {
      //   print(
      //       '${_listCategories[_indexCategory].id} ${news.categories[0]} : ${news.title.rendered}');
      // } else {
      //   print(
      //       '${_listCategories[_indexCategory].id} ${news.categories[0]} : ${news.title.rendered}');
      // }

      setState(() {
        _listNews.add(News(
          id: news.id,
          title: news.title,
          date: news.date,
          links: news.links,
          content: news.content,
        ));
      });
    }

    setState(() {
      _progress = false;
    });
  }

  @override
  void initState() {
    _getCategories();
    _getNewsSelectedCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context);
    // _getNewsSelectedCategory();
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
                    onLoadMore: () {
                      setState(() {
                        _progress = true;
                        _pageCount = _pageCount + 1;
                      });
                      _getNewsSelectedCategory();
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
