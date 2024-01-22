class vehicle_detail {
  late int id;
  late String plate_no;
  late String account_no;

  vehicle_detail({required this.plate_no, required this.account_no});

  factory vehicle_detail.fromJson(Map<String, dynamic> parsedJson) {
    return vehicle_detail(
        plate_no: parsedJson["plate_no"], account_no: parsedJson["account_no"]);
  }
}