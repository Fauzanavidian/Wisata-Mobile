class Profile {
  Profile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String fullName;
  String email;
  int phone;
  DateTime createdAt;
  DateTime updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
      id: json["id"],
      fullName: json["full_name"],
      email: json["email"],
      phone: json["phone"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "full_name": fullName,
      "email": email,
      "phone": phone,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
  };
}
