import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*import 'package:flutter_';
import 'package:http' as http;*/
import 'package:toll_gates/res/snackbar.dart';

import '../../models/account_model.dart';
import 'dashboard.dart';

class RegisterAccount extends StatefulWidget {
  @override
  RegisterAccountState createState() {
    return RegisterAccountState();
  }
}

Future<AccountModel?> createAccount(
    String nida,
    String first_name,
    String middle_name,
    String surname,
    String password_hash,
    String email,
    String phone,
    dynamic created_by, amount,
    ) async {
  final String apiUrl = 'https://bridge-core.nssf.or.tz/account/create';
//  final String apiUrl = 'http://192.168.43.86/Ekanisa/web/vehicles';
  var http;
  final response = await http.post(apiUrl, body: {
    "nida": nida,
    "first_name": first_name,
    "middle_name": middle_name,
    "surname": surname,
    "password_hash": password_hash,
    "email": email,
    "phone": phone,
    "created_by": created_by,
    "amount": amount
  });
  print(response.body);
  var result = response.body;
  var status = json.decode(result);
  if (status['status'] == 1) {
    final String responseString = response.body;
    return accountModelFromJson(responseString);
  } else {
    return null;
  }
}

class RegisterAccountState extends State<RegisterAccount> {
  late AccountModel _account;
  final _formKey = GlobalKey<FormState>();
  bool amountUpdate_value = false;
  final TextEditingController nidaController = TextEditingController();
  final TextEditingController first_nameController = TextEditingController();
  final TextEditingController middle_nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController password_hashController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routes =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(
                    controller: first_nameController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      prefixIcon: Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Your First Name';
                      }
                      return null;
                    }),
                const SizedBox(height: 5.0),
                TextFormField(
                    controller: middle_nameController,
                    decoration: InputDecoration(
                      hintText: "Middle Name",
                      prefixIcon: Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your middle name";
                      }
                      return null;
                    }),
                const SizedBox(height: 5.0),
                TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      prefixIcon: Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Your Last name';
                      }
                      return null;
                    }),
                const SizedBox(height: 5.0),
                TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefixIcon: Icon(Icons.account_balance_wallet),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your phone number';
                      }
                      return null;
                    }),
                const SizedBox(height: 5.0),
                TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.mail),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your Email';
                      }
                      return null;
                    }),
                const SizedBox(height: 5.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: nidaController,
                  decoration: InputDecoration(
                    hintText: "NIDA number",
                    prefixIcon: Icon(Icons.nfc),
                    border: const OutlineInputBorder(),
                  ),
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'please enter your NIDA number';
                  //   }
                  //   return null;
                  // }
                ),
                const SizedBox(height: 5.0),
                Visibility(
                  visible: amountUpdate_value,
                  child: TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(
                      hintText: "Amount",
                      prefixIcon: Icon(Icons.money),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                CheckboxListTile(
                  title: Text("TopUp Account ?"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: amountUpdate_value='' as bool,
                  onChanged: (void amountUpdate_value) {
                             setState(() {
                      amountUpdate_value = amountUpdate_value;
                    });
                   /* if ( bool amountUpdate_value == true) {
                      print('test');
                    }*/
                  },
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.black,
                    onPressed: () async {
                      var user_id = await FlutterSession().get("user_id");
                      print(user_id);
                      if (_formKey.currentState!.validate()) {
                        final String nida = nidaController.text;
                        final String first_name = first_nameController.text;
                        final String middle_name = middle_nameController.text;
                        final String surname = surnameController.text;
                        final String password_hash = '12345';
                        final String phone = phoneController.text;
                        final String email = emailController.text;
                        final dynamic created_by = user_id.toString();
                        final dynamic amount = amountController.text;
                        final AccountModel? account = await createAccount(
                            nida,
                            first_name,
                            middle_name,
                            surname,
                            password_hash,
                            email,
                            phone,
                            created_by,
                            amount);

                        setState(() {
                          _account = account!;
                        });
                        _account == null
                            ? Scaffold.of(context).(BuildSnackbar()
                            .buildSnackBar(
                            'Failed to Register! Please Check your Inputs'))
                            : Navigator.push;
                            context;
                            MaterialPageRoute(
                                builder: (context) => Dashboard(
                                    response:
                                    'Account  Created Successfully'));
                        //                    : Text(" Owner ${_account.firstName},${_account.middleName} is created succesfullly "),

                      }
                    },
                    child: Text('Register'),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RaisedButton({required MaterialColor color, required Color textColor, required Future<Null> Function() onPressed, required Text child}) {}

  FlutterSession() {}
}