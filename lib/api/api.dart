import 'dart:convert';
import 'dart:core';

import 'package:azul_project/models/categories.dart';
import 'package:azul_project/models/news.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'offline.dart';

class ApiHelper {
  /// GET Home page News
  static Future<List<News>> getHomeNews({@required pageIndex}) async {
    try {
      final _response = await Dio()
          .get('https://soltana.ma/wp-json/wp/v2/posts?page=$pageIndex');

      if (_response.statusCode == 200) {
        List<News> _newListNews = [];
        for (var news in newsFromJson(jsonEncode(_response.data))) {
          _newListNews.add(News(
            id: news.id,
            title: news.title,
            content: news.content,
            date: news.date,
            image: await getImagePost(link: news.links.wpFeaturedmedia[0].href),
            link: news.link,
            links: news.links,
            categories: news.categories,
            featuredMedia: news.featuredMedia,
          ));

        }

        await OfflineHelper.putDataNews(newsToJson(_newListNews));

        return _newListNews;
      }
    } catch (e) {
      print('No Internet!!');
      //return null;
    }

    //GET Offline data
    try {
      var _listNews = await OfflineHelper.getDataNews();
      return newsFromJson(_listNews);
    } catch (e) {
      print('DB error news :$e');
      return null;
    }
  }

  /// GET Categories
  static Future<List<Categories>> getHomeCategories() async {
    try {
      final _response =
          await Dio().get('https://soltana.ma/wp-json/wp/v2/categories');

      if (_response.statusCode == 200) {
        List<Categories> _listCaties =
            categoriesFromJson(jsonEncode(_response.data));

        await OfflineHelper.putDataCategories(categoriesToJson(_listCaties));

        return _listCaties;
      }
    } catch (e) {
      print('No Internet for Categories');
    }
    //GET data caty from DB
    try {
      final _listCategories = await OfflineHelper.getDataCategories();

      return categoriesFromJson(_listCategories);
    } catch (e) {
      print('Offline caty error: $e');
      return null;
    }
  }

  ///GET IMAGE URL
  static Future<dynamic> getImagePost({link}) async {
    try {
      final _response = await Dio().get('$link');

      if (_response.statusCode == 200) {
        // print(_response.data['source_url']);

        return _response.data['source_url'] ?? 'no_image';
      } else {
        print('${_response.statusCode} : ${_response.data}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
