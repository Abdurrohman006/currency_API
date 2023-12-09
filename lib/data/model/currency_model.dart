class Currency {
  // "title": "UAE Dirham",
  // "code": "AED",
  // "cb_price": "2978.51",
  // "nbu_buy_price": "",
  // "nbu_cell_price": "",
  // "date": "06/03/2023"
  //

  String title;
  String code;
  String cb_price;
  String data;

  Currency({
    required this.title,
    required this.code,
    required this.cb_price,
    required this.data,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    String title = json["title"] ?? "no data";
    String code = json["code"] ?? "no data";
    String cb_price = json["cb_price"] ?? "no data";
    String data = json["data"] ?? "no data";
    return Currency(title: title, code: code, cb_price: cb_price, data: data);
  }
}
