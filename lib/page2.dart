import 'package:flutter/material.dart';
import 'package:project1_ayasaatii/login.dart';
import 'page3.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
//const String _baseURL = 'ayasaatiliu.000webhostapp.com';
const String _baseURL='https://ayasaatiliu.000webhostapp.com';
Map<String, String> temporaryArguments = {};


class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerfname = TextEditingController();
  final TextEditingController _controllerlname = TextEditingController();
  final TextEditingController _controllernumber = TextEditingController();
  final TextEditingController _controlleremail = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  final TextEditingController _controlleraddress = TextEditingController();



  bool _loading = false;


  @override
  void dispose() {
    _controllerfname.dispose();
    _controllerlname.dispose();
    _controllernumber.dispose();
    _controlleremail.dispose();
    _controllerpassword.dispose();
    _controlleraddress.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }
  // final TextEditingController _controllernbofnights = TextEditingController();


 // void update(String text) {
    //Navigator.of(context).push(MaterialPageRoute(builder:(context)=> AddCustomer()));
   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
 // }


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
              title: Text("Book Now"),
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
                  Form(
                      key: _formKey,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
            children:[
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
                  const SizedBox(height: 0),
                  Text("Enter Your First Name:",
                      style: TextStyle(color: Colors.red),
                     textAlign: TextAlign.left)
              , const SizedBox(height: 10),
                  SizedBox(width: 300, height: 50,

                    child: TextFormField(controller: _controllerfname,
                       keyboardType: TextInputType.name,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Your First Name',
                  ), validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first name';
                }
                return null;
              })),
                  const SizedBox(height: 10),
                  Text("Enter Your Last Name:", textAlign: TextAlign.left),
                  const SizedBox(height: 10),
                  SizedBox(width: 300, height: 50,

                    child: TextFormField(controller: _controllerlname,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Your Last Name',),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        })),



                  const SizedBox(height: 10),
                  Text("Enter Your Password:", style: TextStyle(),
                      textAlign: TextAlign.left),
                  const SizedBox(height: 12),
                  SizedBox(width: 300, height: 60,
                    child: TextFormField(controller: _controllerpassword,
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter password'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        })),
                  Text("Enter Your Phone Number:",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.left),
                  const SizedBox(height: 12),
                  SizedBox(width: 300, height: 60,
                    child: TextFormField(controller: _controllernumber,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter phone number'),
                        validator: (String? value) {
                      if (value == null || value.isEmpty) {
                      return 'Please enter id';
                      }
                      return null;
                      })),

                  Text("Enter Your Address:", style: TextStyle(),
                      textAlign: TextAlign.left),
                  const SizedBox(height: 12),
                  SizedBox(width: 300, height: 60,
                    child: TextFormField(controller: _controlleraddress,
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your address'),
                        validator: (String? value) {
                      if (value == null || value.isEmpty) {
                      return 'Please enter address';
                      }
                      return null;
                      })),
              const SizedBox(height: 10),
              ElevatedButton(style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Colors.brown)),
                // we need to prevent the user from sending another request, while current
                // request is being processed
                onPressed: _loading ? null : () { // disable button while loading
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    insertCustomer(update,_controlleremail.text,_controllerfname.text,_controllerlname.text,_controllerpassword.text,_controllernumber.text,_controlleraddress.text);
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Colors.brown)),
                onPressed: () {
    temporaryArguments = {
    'fname': _controllerfname.text,
    'lname': _controllerlname.text,
    'phonenb': _controllernumber.text,
    };
    Navigator.pushNamed(context, '/LoginPage');
    }
                  /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Page3(
                        fname: temporaryArguments['fname'],
                        lname: temporaryArguments['lname'],
                        phonenb: temporaryArguments['phonenb'],
                      ),
                    ),
                  );*/
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
               //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page3(fname: _controllerfname.text, lname: _controllerlname.text, phonenb: _controllernumber.text)));
                ,
                child: const Text('Continue'),
              ),
              const SizedBox(height: 10),
              Visibility(visible: _loading, child: const CircularProgressIndicator())


            ]))]
            ),

        )
    ),

    );

                  /*Text("Enter The number of Nights:",style:TextStyle(color:Colors.red),textAlign: TextAlign.left),
      const SizedBox(height:15),
      SizedBox(width:300,height:60,
        child:TextField(controller:_controllernbofnights,keyboardType: TextInputType.number,decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter nb of nights')),
      ),*/
                /*  const SizedBox(height: 15),

                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.brown),
                      //  foregroundColor: MaterialStatePropertyAll<Color>(Colors.black)
                    ),

       onPressed: () {
          String fname = _controllerfname.text;
          String lname = _controllerlname.text;
          String email = _controlleremail.text;
          String password = _controllerpassword.text;
          String phonenb = _controllernumber.text;
          String address = _controlleraddress.text;


          if (fname.isNotEmpty && lname.isNotEmpty && email.isNotEmpty &&
              password.isNotEmpty && address.isNotEmpty && phonenb != null) {
            addCustomer(update, fname, lname, email, password, phonenb, address);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    Page3(
                        fname: fname,
                        lname: lname,
                        phonenb: phonenb,


                    ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Enter All Fields!!'),
                duration: Duration(seconds: 2),
              ),
            );
          }

        },

  child: Text('Submit'),
  )


  ]
  )
  )
  ),

  );


}


@override
void dispose(){
  _controllerfname.dispose();
  _controllerlname.dispose();
  _controllernumber.dispose();

}
}

void addCustomer(Function(String text) update,String fname,String lname, String email, String password,String phonenb,String address)async
{
  try {
    // final url = Uri.https(_baseURL, 'getProducts.php');
    var url = "https://ayasaatiliu000webhostapp.com/insertCustomer.php";
    final response = await http.post(Uri.parse(url),

        //Uri.parse('http://$_baseURL/insertCustomer.php'),
        //Uri.parse('$_baseURL/insertCustomer.php'),

        //headers: <String, String > {
        //'Content-Type': 'application/json; charset=UTF-8',


        // body: convert.jsonEncode(<String, String>{
        body: {
          'email': email,
          'fname': fname,
          'lname': lname,
          'password': password,
          'phonenb': phonenb,
          'address': address,
        });

    if (response.statusCode == 200) {
      var res = convert.jsonDecode(response.body);
      update(res);
    }
  }
  catch (e) {
    update('connection error:$e');
  }
  */

               /*     onPressed: () async {
                      String fname = _controllerfname.text;
                      String lname = _controllerlname.text;
                      String email = _controlleremail.text;
                      String password = _controllerpassword.text;
                      String phonenb = _controllernumber.text;
                      String address = _controlleraddress.text;

                      if (fname.isNotEmpty &&
                          lname.isNotEmpty &&
                          email.isNotEmpty &&
                          password.isNotEmpty &&
                          address.isNotEmpty &&
                          phonenb != null) {
                        // All fields are filled, proceed with API call
                        var url = Uri.parse('http://$_baseURL/insertCustomer.php');
                        var response = await http.post(
                          url,
                          body: {
                            'email': email,
                            'fname': fname,
                            'lname': lname,
                            'password': password,
                            'phonenb': phonenb,
                            'address': address,
                          },
                        );

                        if (response.statusCode == 200) {
                          var data = convert.jsonDecode(response.body);
                          if (data['status'] == 'success') {
                           /* ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Signup Information Saved Successfully!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            // Data inserted successfully, navigate to Page3
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Page3(
                                  fname: fname,
                                  lname: lname,
                                  phonenb: phonenb,
                                ),
                              ),
                            );*/
                          } else {
                            // Server returned an error, show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: ${data['message']}'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          // HTTP request failed, show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('HTTP Error: ${response.statusCode}}'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        // One or more fields are empty, show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please Fill All Fields!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
  child: Text('Submit'),
  ),SizedBox(height:10),
                  ElevatedButton( style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.brown)),onPressed:(){ if (_controllerfname.text.isNotEmpty && _controllerlname.text.isNotEmpty && _controlleremail.text.isNotEmpty  && _controllerpassword.text.isNotEmpty && _controllernumber.text.isNotEmpty && _controlleraddress.text.isNotEmpty){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Page3(
                          fname: _controllerfname.text,
                          lname: _controllerlname.text,
                          phonenb: _controllernumber.text,
                        ),
                      ),
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Fill All Fields!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }

                  }, child: Text('Choose Your Bundle'))
        ]))]
            ),

        )
    ),

    );
*/
}

}

void insertCustomer(Function(String text) update, String email, String fname, String lname,String password,String phonenb,String address) async {
  try {
    // we need to first retrieve and decrypt the key
    // send a JSON object using http post
    final response = await http.post(
        Uri.parse('$_baseURL/insertCustomer.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }, // convert the cid, name and key to a JSON object
        body: convert.jsonEncode(<String, String>{
          'email': email, 'fname': fname, 'lname':lname,'password': password, 'phonenb': phonenb,'address': address,'key': 'your_key'
        })).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      // if successful, call the update function
      update(response.body);
    }
  }
  catch(e) {
    update(e.toString());
  }
}

