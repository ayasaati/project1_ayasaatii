import 'package:flutter/material.dart';
import 'page2.dart';
import 'page3.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
const String _baseURL = 'ayasaatiliu.000webhostapp.com';
final List<String> _logcustomers = [];
Map<String, String> temporaryArguments = {};
bool _load = false;
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controlleremail = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();





  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect email or password')));
      }
    });
  }
  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    checkCustomer(context,update,_controlleremail.text,_controllerpassword.text);
    super.initState();
  }
  @override
  void dispose() {
    _controlleremail.dispose();
    _controllerpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: AppBar(
                actions: <Widget>[
                  Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 30
                  ),
                ],
                title: Text("Log In"),
                automaticallyImplyLeading: false,

                backgroundColor: Colors.brown[700],
                shadowColor: Colors.black

            )

        ), backgroundColor: Colors.grey[300]
        , body: Padding(

        padding: EdgeInsets.only(top: 40, left: 32, right: 32),
    child: SingleChildScrollView(
    reverse: true,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Text("Enter Your Email:", style: TextStyle(color: Colors.red),
          textAlign: TextAlign.left),
      const SizedBox(height: 10),
      SizedBox(width: 300, height: 50,
          child: TextFormField(controller: _controlleremail,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your email'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              })),
      const SizedBox(height: 10),
      Text("Enter Your Password:", style: TextStyle(color: Colors.red),
          textAlign: TextAlign.left),
      const SizedBox(height: 10),
      SizedBox(width: 300, height: 50,
          child: TextFormField(controller: _controllerpassword,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your Password'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              })),
      const SizedBox(height: 10),
      ElevatedButton(style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
              Colors.brown)),
        onPressed: () {
         // Navigator.pushNamed(context, '/LoginPage');
          //checkCustomer(update());
          // Remove the code below from here

          checkCustomer(
            context,
            update,
            _controlleremail.text,
            _controllerpassword.text,
          );
  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));

          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page3(fname: _controllerfname.text, lname: _controllerlname.text, phonenb: _controllernumber.text)));
        },
        child: const Text('Login'),
      ),
    ]))));


  }
}
void  checkCustomer( BuildContext context,Function(bool success) update,String email,String password)async {
  try {
    final url = Uri.https(_baseURL, 'loginCustomers.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    _logcustomers.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(
          response.body); // create dart json object from json array
      for (var row in jsonResponse) {
        print('Entered email: $email, Entered password: $password');
        print('Database email: ${row['email']}, Database password: ${row['password']}');
        if (row['email'] == email && row['password'] == password) {
          // If the email and password match, update the temporaryArguments
         temporaryArguments = {
            'fname': row['fname'] ?? '',
          'lname': row['lname'] ?? '',
           'phonenb': row['phonenb'] ?? '',
        };

          // Navigate to Page3
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Page3(
                fname: temporaryArguments['fname'] ?? '',
                lname: temporaryArguments['lname'] ?? '',
                phonenb: temporaryArguments['phonenb'] ?? '',
              ),
            ),
          );
          return; // Exit the loop after navigation
        }
      }

      update(true); // Callback update method to inform that we completed retrieving data
    }
    else{
      update(false);
    }
  } catch (e) {
    update(false); // Inform through callback that we failed to get data
  }
}

