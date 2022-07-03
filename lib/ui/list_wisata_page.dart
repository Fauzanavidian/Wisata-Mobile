import 'package:flutter/material.dart';
import 'package:wisatain_mobile/model/wisata.dart';
import 'package:wisatain_mobile/shared/theme.dart';
import 'package:wisatain_mobile/ui/list_favorite.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WisataPage extends StatefulWidget {
  const WisataPage({Key? key}) : super(key: key);

  @override
  State<WisataPage> createState() => _ListWisataPage();
}

final String url = 'http://127.0.0.1:8000/api/admin-wisata';

Future<List<Wisata>> getwisata() async {
  var response = await http.get(Uri.parse(url));
  return (json.decode(response.body)['data'] as List)
      .map((e) => Wisata.fromJson(e))
      .toList();
}

class _ListWisataPage extends State<WisataPage> {
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
        backbutton(),
        //Text
        Padding(
          padding: EdgeInsets.only(
              left: defaultMargin, right: defaultMargin, top: 3),
          child: Text("List Wisata",
              style:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold)),
        ),
        //Input
        searchInput(),
        //text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Text("Favorite Vacation",
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
                future: getwisata(),
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
                          SizedBox(height: 16),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.hasError}');
                  } else {
                    return Text(' data gk ada');
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget searchInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: kBlackColor,
            decoration: InputDecoration(
              hintText: 'Search Wisata',
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
              prefixIcon: const Icon(Icons.search),
            ),
          )
        ],
      ),
    );
  }

  Widget backbutton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/main_page');
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
