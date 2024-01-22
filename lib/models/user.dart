class User{
  int id;
  String first_name;
  String middle_name;
  String surname;
  String account_no;

  User({required this.id,required this.first_name, required this.account_no,required this.middle_name, required this.surname});
  factory User.fromJson(Map<String, dynamic> parsedJson)
  {
    return User(
      id: parsedJson["id"],
      first_name: parsedJson["first_name"],
      account_no: parsedJson["account_no"],
      middle_name: parsedJson["middle_name"],
      surname: parsedJson["surname"],
    );
  }
}