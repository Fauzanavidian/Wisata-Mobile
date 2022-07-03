import 'package:flutter/material.dart';
import 'package:wisatain_mobile/model/wisata.dart';
import 'package:wisatain_mobile/shared/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class listFav extends StatelessWidget {
  final Wisata wisata;
  listFav(this.wisata);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: kWhiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.network(
                  // "https://dummyimage.com/600x400/000/fff&text=image",
                  wisata.foto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(wisata.nama,
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: medium)),
                    const SizedBox(height: 10),
                    Text(wisata.lokasi,
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: light))
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star_purple500_sharp,
                    color: Color(0xFFFFA235)),
                Text(
                  wisata.rating,
                  style:
                      blackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
