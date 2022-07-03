import 'package:flutter/material.dart';
import 'package:wisatain_mobile/shared/theme.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Wisata-In",
          style: blackTextStyle.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/wisata.in.png'),
                  fit: BoxFit.contain,
                  width: 300,
                ),
              ),
              Text(
                "\n           Indonesia masih memiliki tempat-tempat yang belum terjamah. Tempat-tempat seperti ini bisa dijadikan sebagai objek wisata. Karena banyaknya tempat-tempat yang masih belum diketahui ini, kami membuat aplikasi yang melihat semua tempat yang bisa dijadikan objek wisata. Aplikasi yang kami buat ini, melihat tempat objek wisata dengan beragam tempat yang dapat dikunjungi wisatawan lokal.",
                style: blackTextStyle,
                textAlign: TextAlign.justify,
              ),
              Text(
                "\nCreated By Kelompok 4: \n",
                style: blackTextStyle,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Naufal Rezky Ananda (1301190478)",
                style: blackTextStyle,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Yusuf Kamal Siregar (1301190464)",
                style: blackTextStyle,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Muhammad Fauzan Avidiansyah (1301194166)",
                style: blackTextStyle,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Muhammad Kamil Hasan (1301190420)",
                style: blackTextStyle,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/location');
                    },
                    child: const Text(
                      "Our Office",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff59CAFF),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
