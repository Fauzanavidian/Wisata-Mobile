//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:wisatain_mobile/shared/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wisatain_mobile/model/wisata.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wisatain_mobile/ui/list_transaction_page.dart';

class nextPage extends StatefulWidget {
  const nextPage({Key? key}) : super(key: key);

  @override
  State<nextPage> createState() => _nextPageState();
}

class _nextPageState extends State<nextPage> {
  var date = TextEditingController();
  final _storage = const FlutterSecureStorage();

  Future<void> transaction(String dateText, String url) async {
    var value = await _storage.read(key: "token");
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $value',
      },
      body: jsonEncode(<String, String>{'payment_date': dateText}),
    );

    if (response.statusCode == 201) {
      Navigator.pushNamed(context, '/success_page');
      return print('success');
    } else {
      // throw Exception('Failed to login');
      return print('error');
    }
  }

  // var firstName = TextEditingController();
  // var lastName = TextEditingController();
  // var age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Wisata _wisata = ModalRoute.of(context)!.settings.arguments as Wisata;
    String urlBooking =
        'http://127.0.0.1:8000/api/insert_transaksi/${_wisata.id}';

    Widget backbutton() {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            ),
            SizedBox(
              height: 75,
            ),
          ],
        ),
      );
    }

    Widget inputSection() {
      Widget firstnameInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('First Name'),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                // controller: firstName ,
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  hintText: 'Your First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }

      Widget lastnameInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Last Name'),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                // controller: lastName,
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  hintText: 'Your Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }

      Widget ageInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Age'),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                // controller: age,
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  hintText: 'Your age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }

      Widget dateInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date'),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: date,
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  hintText: 'dd/mm/yy',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      defaultRadius,
                    ),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }

      Widget submitButton() {
        return Container(
          width: double.infinity,
          height: 55,
          child: TextButton(
            onPressed: () => transaction(date.text, urlBooking),
            style: TextButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ),
              ),
            ),
            child: Text(
              'Booking Now',
              style: whiteTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          children: [
            firstnameInput(),
            lastnameInput(),
            ageInput(),
            dateInput(),
            submitButton(),
          ],
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
            backbutton(),
            inputSection(),
          ],
        ),
      ),
    );
  }
}
