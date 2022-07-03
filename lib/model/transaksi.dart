class Transaksi {
  Transaksi({
    required this.id,
    required this.email_customer,
    required this.nama_wisata,
    required this.payment_date,
    required this.date,
    required this.payment_status,
    required this.rating,
    required this.total_price,
    required this.foto,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String email_customer;
  String nama_wisata;
  String payment_date;
  String date;
  String payment_status;
  String rating;
  int total_price;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        email_customer: json["email_customer"],
        nama_wisata: json["nama_wisata"],
        payment_date: json["payment_date"],
        date: json["date"],
        payment_status: json["payment_status"],
        rating: json["rating"],
        total_price: json["total_price"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email_customer": email_customer,
        "nama_wisata": nama_wisata,
        "payment_date": payment_date,
        "payment_status": payment_status,
        "rating": rating,
        "date": date,
        "total_price": total_price,
        "foto": foto,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
