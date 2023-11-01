class UserType {
  int? id;
  String? slug;

  UserType({this.id, this.slug});

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      id: json['id'],
      slug: json['slug'],
    );
  }
  factory UserType.fromMap(Map<String, dynamic> map) {
    return UserType(
      id: map['id'],
      slug: map['slug'],
    );
  }
}
