import 'package:azul_project/helpers/colors.dart';
import 'package:azul_project/helpers/constants.dart';
import 'package:azul_project/widgets/widgets_content_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  int _selectedIndexPost = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CardTopBarContent(selectedIndexPost: 5),
          CardBarContent(),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
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
                          child: Center(
                            child: Image(
                              image:
                                  AssetImage('assets/images/img_no_media.png'),
                              width: 100.0,
                            ),
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
                              'يحسم',
                              style: kStyleCategory,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'مجلس النواب يحسم في جدل تقاعد البرلمانيين الأسبوع المقبل',
                      style: kStyleTitlePost,
                    ),
                    SizedBox(height: 3),
                    Text(
                      '12 yonyo 2020',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    CardSharePost(),
                    Text(
                      'مجلس النواب يحسم في جدل تقاعد البرلمانيين الأسبوع المقبل',
                      style: kStyleDecripPost,
                    ),
                    CardSharePost(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
