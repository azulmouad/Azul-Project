import 'package:azul_project/helpers/colors.dart';
import 'package:azul_project/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RawButtonShare extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String label;
  final IconData icon;

  RawButtonShare({
    @required this.onTap,
    @required this.color,
    @required this.label,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            color,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: kColorWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              icon,
              color: kColorWhite,
            ),
          ],
        ),
      ),
    );
  }
}

class CardBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context);

    return Container(
      width: mSize.size.width,
      height: 60.0,
      decoration: BoxDecoration(
        color: kColorWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.alignRight,
              color: kColorGrey02,
            ),
            onPressed: () {},
          ),
          Image(
            image: AssetImage('assets/images/logo.png'),
            width: 25.0,
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: kColorGrey02,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class CardTopBarContent extends StatelessWidget {
  final selectedIndexPost;

  CardTopBarContent({@required this.selectedIndexPost});

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context);
    final paddingTopBar = mSize.padding.top;
    return Container(
      width: mSize.size.width,
      height: 30.0 + paddingTopBar,
      decoration: BoxDecoration(
        gradient: kGradientBar,
      ),
      padding: EdgeInsets.only(top: paddingTopBar),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 10; i++)
            Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: selectedIndexPost == i
                    ? kColorWhite
                    : kColorWhite.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class CardSharePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          RawButtonShare(
            color: Color(0xff2fb1e3),
            icon: FontAwesomeIcons.twitter,
            label: 'غرد',
            onTap: () {},
          ),
          SizedBox(width: 5.0),
          RawButtonShare(
            color: Color(0xff496399),
            icon: FontAwesomeIcons.facebookF,
            label: 'شارك',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
