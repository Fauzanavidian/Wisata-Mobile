import 'package:flutter/material.dart';
import 'package:wisatain_mobile/model/booked.dart';
import 'package:wisatain_mobile/shared/theme.dart';
import 'package:wisatain_mobile/model/transaksi.dart';
import 'package:intl/intl.dart';

class listTransaction extends StatelessWidget {
  final Booked booked;
  listTransaction(this.booked);

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
                  booked.foto,
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
                    Text(
                      booked.nama,
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      booked.payment_date,
                      style: greyTextStyle.copyWith(
                          fontSize: 14, fontWeight: light),
                    ),
                    Text(
                      booked.paymentStatus,
                      style: redTextStyle.copyWith(
                          fontSize: 14, fontWeight: light),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star_purple500_sharp,
                    color: Color(0xFFFFA235)),
                Text(
                  booked.rating,
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
