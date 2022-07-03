class Booked {
    Booked({
      required this.rating,
      required this.foto,
      required this.nama,
      required this.emailCustomer,
      required this.totalPrice,
      required this.paymentStatus,
      required this.payment_date,
    });

    String rating;
    String foto;
    String nama;
    String emailCustomer;
    int totalPrice;
    String paymentStatus;
    String payment_date;

    factory Booked.fromJson(Map<String, dynamic> json) => Booked(
        rating: json["rating"],
        foto: json["foto"],
        nama: json["nama"],
        emailCustomer: json["email_customer"],
        totalPrice: json["total_price"],
        paymentStatus: json["payment_status"],
        payment_date: json["payment_date"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "foto": foto,
        "nama": nama,
        "email_customer": emailCustomer,
        "total_price": totalPrice,
        "payment_status": paymentStatus,
        "payment_date": payment_date,
    };
}
