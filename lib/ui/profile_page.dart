import 'package:flutter/material.dart';
import 'package:wisatain_mobile/model/profile.dart';
import 'package:wisatain_mobile/shared/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _storage = const FlutterSecureStorage();

  final String urlProfile = 'http://127.0.0.1:8000/api/get_profile';

  Future<Profile> getProfile() async {
    var value = await _storage.read(key: "token");
    var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/get_profile"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $value',
        });
    return Profile.fromJson(json.decode(response.body)['data']);
  }

  Future<void> logout() async {
    var value = await _storage.read(key: "token");
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/customer_logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $value',
        });

    if (response.statusCode == 200) {
      var value = await _storage.delete(key: "token");
      Navigator.pushNamed(context, '/sign_in_page');
      return print('Logout success');
    } else {
      return print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildBody()),
    );
  }

  Container buildBody() {
    return Container(
      margin:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 24),
      color: kbackgroundColor,
      child: ListView(
        children: [
          textAndProfile(),
          submitButton(),
        ],
      ),
    );
  }

  Container textAndProfile() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder(
            future: getProfile(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Profile _profile = snapshot.data as Profile;
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        _profile.fullName,
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: regular),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Email Address',
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        _profile.email,
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: regular),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Phone Number',
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        _profile.phone.toString(),
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: regular),
                      ),
                    ],
                  ),
                );
              } else {
                return Text(' ${snapshot.error}');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget submitButton() {
    return Container(
      width: double.infinity,
      height: 55,
      child: TextButton(
        onPressed: () => logout(),
        style: TextButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
          ),
        ),
        child: Text(
          'Log Out',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
