class PropertyCredential {
  int? id;
  String? propertyName;
  bool? phoneProperty;
  Tokens? tokens;

  PropertyCredential(
      {this.id, this.propertyName, this.phoneProperty, this.tokens});

  PropertyCredential.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyName = json['name'];
    phoneProperty = json['phone1'];
    tokens =
        json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = propertyName;
    data['phone1'] = phoneProperty;
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    return data;
  }
}

class Tokens {
  String? refresh;
  String? access;

  Tokens({this.refresh, this.access});

  Tokens.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    return data;
  }
}
