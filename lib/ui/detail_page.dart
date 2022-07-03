import 'package:flutter/material.dart';
import 'package:wisatain_mobile/model/wisata.dart';
import 'package:wisatain_mobile/shared/theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime date = DateTime(2022, 12, 24);
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
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
      return print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Wisata _wisata = ModalRoute.of(context)!.settings.arguments as Wisata;
    String urlBooking =
        'http://127.0.0.1:8000/api/insert_transaksi/${_wisata.id}';
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        color: kbackgroundColor,
        child: buildBody(_wisata, urlBooking),
      ),
    );
  }

  ListView buildBody(Wisata _wisata, String urlBooking) {
    return ListView(children: [
      Column(
        children: [
          Stack(
            children: [
              //image
              image(_wisata),
              //Text
              title(_wisata),
              //Detail box
              detailBox(_wisata),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //price and button
          priceAndButton(_wisata, urlBooking)
        ],
      ),
    ]);
  }

  Container image(Wisata _wisata) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_wisata.foto),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
    );
  }

  Container title(Wisata _wisata) {
    return Container(
      margin:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 310),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_wisata.nama,
                  style: whiteTextStyle.copyWith(
                      fontSize: 24, fontWeight: semiBold)),
              const SizedBox(height: 10),
              Text(_wisata.lokasi,
                  style:
                      whiteTextStyle.copyWith(fontSize: 16, fontWeight: light))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star_purple500_sharp, color: Color(0xFFFFA235)),
              Text(
                _wisata.rating,
                style:
                    whiteTextStyle.copyWith(fontSize: 14, fontWeight: medium),
              )
            ],
          ),
        ],
      ),
    );
  }

  Center detailBox(Wisata _wisata) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 400),
        height: 350,
        width: 367,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: kWhiteColor),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About",
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold)),
              const SizedBox(height: 6),
              Text(_wisata.deskripsi,
                  style: blackTextStyle.copyWith(
                      fontSize: 14, fontWeight: regular)),
              const SizedBox(height: 20),
              SizedBox(
                height: 24,
              ),
              dateInput(),
            ],
          ),
        ),
      ),
    );
  }

  Container priceAndButton(Wisata _wisata, String urlBooking) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
      decoration: BoxDecoration(
        color: kWhiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("IDR ${_wisata.harga}",
                  style: blackTextStyle.copyWith(
                      fontSize: 18, fontWeight: medium)),
              const SizedBox(height: 5),
              Text("per orang",
                  style:
                      blackTextStyle.copyWith(fontSize: 14, fontWeight: light))
            ],
          ),
          //button

          ClipRRect(
            borderRadius: BorderRadius.circular(defaultRadius),
            child: Container(
              height: 55,
              width: 170,
              color: const Color(0XFF31A5BE),
              child: TextButton(
                  onPressed: () =>
                      transaction(dateFormat.format(date), urlBooking),
                  child: Text("Pay now",
                      style: whiteTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium))),
            ),
          ),
        ],
      ),
    );
  }

  //list photo
  Widget photoList() => Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          image: const DecorationImage(
            image: NetworkImage(
                "https://raw.githubusercontent.com/Fauzanavidian/Wisata-Mobile/master/assets/bg3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget backbutton() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/list_wisata_page');
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }

  Widget dateInput() {
    return Center(
      child: Column(
        children: [
          Text(
            '${date.year}/${date.month}/${date.day}',
            style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            child: Text(
              'Select Date',
              style: whiteTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2021),
                lastDate: DateTime(2025),
              );

              if (newDate == null) return;
              setState(() => date = newDate);
            },
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
