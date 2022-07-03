import 'package:flutter/material.dart';
import 'package:wisatain_mobile/shared/theme.dart';

class successPage extends StatelessWidget {
  const successPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imagelogo() {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 212,
            ),
            Container(
              width: 299.96,
              height: 212,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/scheduling.png'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget TextSession() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Well Booked 😍',
              style: blackTextStyle.copyWith(fontSize: 32, fontWeight: bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Are you ready to explore the new \n world of experiences?',
              style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    }

    Widget mybookingButton() {
      return Container(
        width: double.infinity,
        height: 55,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/main_page');
          },
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                defaultRadius,
              ),
            ),
          ),
          child: Text(
            'My Bookings',
            style: whiteTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            imagelogo(),
            TextSession(),
            mybookingButton(),
          ],
        ),
      ),
    );
  }
}
