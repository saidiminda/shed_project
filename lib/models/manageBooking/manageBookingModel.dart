// ignore_for_file: non_constant_identifier_names

class BookingModel {
  int? id;
  String? user_nameAgent;
  String? sales_types;
  String? bankId;
  String? exchange_code;
  String? hotel_id;
  String? start_date;
  String? exchange_rate;
// the given area of the table 
  BookingModel(
      {this.id,
      // ignore: non_constant_identifier_names
      this.user_nameAgent,
      this.sales_types,
      this.bankId,
      this.exchange_code,
      this.hotel_id,
      this.start_date,
      this.exchange_rate
      });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_nameAgent = json['user_agent'];
    bankId = json['bank_id'];
    sales_types = json['sales_type'];
    exchange_rate = json['exchange_rate'];
    exchange_code = json['exchange_code'];
    hotel_id = json['hotel_id'];
    start_date = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_agent'] = user_nameAgent;
    data['bank_id'] = sales_types;
    data['sales_type'] = bankId;
    data['exchange_rate'] = exchange_code;
    data['exchange_code'] = hotel_id;
    data['hotel_id'] = start_date;
    data['start_date'] = exchange_rate;
    return data;
  }
}
// the following area of the table ..