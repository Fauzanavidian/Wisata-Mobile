class Wisata {
  Wisata({
    required this.id,
    required this.nama,
    required this.foto,
    required this.lokasi,
    required this.koordinat,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nama;
  String foto;
  String lokasi;
  String koordinat;
  String deskripsi;
  int harga;
  String rating;
  DateTime createdAt;
  DateTime updatedAt;

  factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
        id: json["id"],
        nama: json["nama"],
        foto: json["foto"],
        lokasi: json["lokasi"],
        koordinat: json["koordinat"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "foto": foto,
        "lokasi": lokasi,
        "koordinat": koordinat,
        "deskripsi": deskripsi,
        "harga": harga,
        "rating": rating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
