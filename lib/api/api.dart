import 'dart:convert';
import 'dart:core';

import 'package:azul_project/models/categories.dart';
import 'package:azul_project/models/news.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiHelper {
  static Future<List<News>> getHomeNews({@required pageIndex}) async {
    try {
      final _response = await Dio()
          .get('https://soltana.ma/wp-json/wp/v2/posts?page=$pageIndex');

      if (_response.statusCode == 200) {
        // print(_response.data);

        return newsFromJson(jsonEncode(_response.data));
      } else {
        print('${_response.statusCode} : ${_response.data}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<List<Categories>> getHomeCategories() async {
    try {
      final _response =
          await Dio().get('https://soltana.ma/wp-json/wp/v2/categories');

      if (_response.statusCode == 200) {
        //print(_response.data);

        return categoriesFromJson(jsonEncode(_response.data));
      } else {
        print('${_response.statusCode} : ${_response.data}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<dynamic> getImagePost({link}) async {
    //print('link image : $link');

    try {
      final _response = await Dio().get('$link');

      if (_response.statusCode == 200) {
        //  print(_response.data['source_url']);

        return _response.data['source_url'];
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
