import 'package:flutter/material.dart';
import 'package:wisatain_mobile/shared/theme.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg2.jpg'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'around our country',
                  style: whiteTextStyle.copyWith(
                      fontSize: 32, fontWeight: semiBold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Explore new world with us and let \n yourself get an amazing experiences',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 220,
                  height: 55,
                  margin: EdgeInsets.only(top: 50, bottom: 80),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up_page');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
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
