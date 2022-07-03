import 'package:flutter/material.dart';
import 'package:wisatain_mobile/model/profile.dart';
import 'package:wisatain_mobile/shared/theme.dart';
import 'package:wisatain_mobile/ui/list_favorite.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wisatain_mobile/model/wisata.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storage = const FlutterSecureStorage();
  final String urlWisata = 'http://127.0.0.1:8000/api/admin-wisata';

  final String urlProfile = 'http://127.0.0.1:8000/api/get_profile';

  Future<List<Wisata>> getWisata() async {
    var response = await http.get(Uri.parse(urlWisata));
    // print(json.decode(response.body));
    return (json.decode(response.body)['data'] as List)
        .map((e) => Wisata.fromJson(e))
        .toList();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildBody()),
    );
  }

  Container buildBody() {
    return Container(
      color: kbackgroundColor,
      child: ListView(
        children: [
          textAndProfile(),
          text(),
          listWisata(),
          textFav(),
          listCard()
        ],
      ),
    );
  }

  Column listCard() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          height: 350,
          child: FutureBuilder(
            future: getWisata(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Wisata> wisata = snapshot.data as List<Wisata>;
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: wisata.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/detail_page",
                          arguments: wisata[index]);
                    },
                    child: listFav(wisata[index]),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                );
              } else {
                return Text(' ${snapshot.error}');
              }
            },
          ),
        ),
      ],
    );
  }

  Padding textFav() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: defaultMargin, vertical: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Favorite Vacation",
            style: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 14),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/list_wisata_page');
            },
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }

  Container listWisata() {
    return Container(
      margin: EdgeInsets.only(left: defaultMargin, top: 8),
      height: 323,
      width: 200,
      child: FutureBuilder(
        future: getWisata(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Wisata> wisata = snapshot.data as List<Wisata>;
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: wisata.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/detail_page",
                      arguments: wisata[index]);
                },
                child: card(wisata[index]),
              ),
              separatorBuilder: (content, _) => const SizedBox(width: 12),
            );
          } else {
            return Text(' data gk ada');
          }
        },
      ),
    );
  }

  Container text() {
    return Container(
      margin:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's Explore our wonderful",
            style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
          ),
          Text(
            "Indonesia",
            style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
          ),
        ],
      ),
    );
  }

  Container textAndProfile() {
    return Container(
      margin:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder(
            future: getProfile(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Profile _profile = snapshot.data as Profile;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hallo,",
                        style: blackTextStyle.copyWith(
                            fontSize: 24, fontWeight: bold)),
                    Text(_profile.fullName,
                        style: blackTextStyle.copyWith(
                            fontSize: 24, fontWeight: bold)),
                  ],
                );
              } else {
                return Text(' ${snapshot.error}');
              }
            },
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Image.network(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //card wisata
  Widget card(Wisata wisata) => ClipRRect(
        borderRadius: BorderRadius.circular(defaultRadius),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: kWhiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 220,
                    width: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.network(
                        wisata.foto,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 125,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultRadius)),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        height: 30,
                        width: 56,
                        color: kWhiteColor,
                        child: Row(
                          children: [
                            const Icon(Icons.star_purple500_sharp,
                                color: Color(0xFFFFA235)),
                            Text(
                              wisata.rating,
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(wisata.nama,
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold)),
                    const SizedBox(height: 6),
                    Text(wisata.lokasi,
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: light))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
