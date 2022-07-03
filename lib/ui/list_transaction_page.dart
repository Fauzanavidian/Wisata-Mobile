import 'package:flutter/material.dart';
import 'package:wisatain_mobile/model/booked.dart';
import 'package:wisatain_mobile/model/transaksi.dart';
import 'package:wisatain_mobile/shared/theme.dart';
import 'package:wisatain_mobile/ui/list_transaction.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class transactionPage extends StatefulWidget {
  const transactionPage({Key? key}) : super(key: key);

  @override
  State<transactionPage> createState() => _transactionPageState();
}

class _transactionPageState extends State<transactionPage> {
  final _storage = const FlutterSecureStorage();
  String urlBooked = "http://127.0.0.1:8000/api/show_history";
  Future<List<Booked>> getBooked() async {
    var value = await _storage.read(key: "token");
    var response =
        await http.get(Uri.parse(urlBooked), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $value',
    });
    return (json.decode(response.body)['data'] as List)
        .map((e) => Booked.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kbackgroundColor,
          child: buildBody(),
        ),
      ),
    );
  }

  ListView buildBody() {
    return ListView(
      children: [
        //text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Text("Transaction",
              style:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold)),
        ),
        //list
        Column(
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
              height: 1000,
              child: FutureBuilder(
                future: getBooked(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Booked> booked = snapshot.data as List<Booked>;
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: booked.length,
                      itemBuilder: (context, index) =>
                          listTransaction(booked[index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 16),
                    );
                  } else {
                    return Text('${snapshot.data}');
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
