import 'package:flutter/material.dart';
import 'page3.dart';


class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  final TextEditingController _controllername=TextEditingController();
  final TextEditingController _controllernumber = TextEditingController();
  final TextEditingController _controllernbofnights = TextEditingController();
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
     size:30
    ),
        ],
    title:Text("Book Now"),
    backgroundColor:Colors.brown[700],
    shadowColor: Colors.black

    )

        ), backgroundColor: Colors.grey[300]
      ,body:Padding(

        padding:EdgeInsets.only(top:40,left:32,right:32),
        child:SingleChildScrollView(
            reverse:true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

    children:[
    const SizedBox(height:0),
    Text("Enter Your Full Name:",style:TextStyle(color:Colors.red),textAlign: TextAlign.left),
      const SizedBox(height:10),
    SizedBox(width:300,height:50,

    child:TextField(controller:_controllername,keyboardType: TextInputType.datetime,decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Your Full Name')),
    ),
    const SizedBox(height:10),
      Text("Enter Your Email:",style:TextStyle(),textAlign: TextAlign.left),
      const SizedBox(height:10),
    SizedBox(width:300,height:50,
    child:TextField(keyboardType: TextInputType.emailAddress,decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Your email')),
    ),
    const SizedBox(height:10),
      Text("Enter Your Password:",style:TextStyle(),textAlign: TextAlign.left),
      const SizedBox(height:12),
      SizedBox(width:300,height:60,
        child:TextField(keyboardType: TextInputType.visiblePassword,decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter password')),
      ),
      Text("Enter Your Phone Number:",style:TextStyle(color:Colors.red),textAlign: TextAlign.left),
      const SizedBox(height:12),
      SizedBox(width:300,height:60,
        child:TextField(controller:_controllernumber,keyboardType: TextInputType.phone,decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter phone number')),
      ),
      Text("Enter Your Address:",style:TextStyle(),textAlign: TextAlign.left),
      const SizedBox(height:12),
      SizedBox(width:300,height:60,
        child:TextField(keyboardType: TextInputType.streetAddress,decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter your address')),
      ),
      Text("Enter The number of Nights:",style:TextStyle(color:Colors.red),textAlign: TextAlign.left),
      const SizedBox(height:15),
      SizedBox(width:300,height:60,
        child:TextField(controller:_controllernbofnights,keyboardType: TextInputType.number,decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter nb of nights')),
      ),
       const SizedBox(height:15),
      ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),
          //  foregroundColor: MaterialStatePropertyAll<Color>(Colors.black)
        ),
        onPressed: () {
          String name = _controllername.text;
          int? phonenb = int.tryParse(_controllernumber.text);
          int? nbofNights = int.tryParse(_controllernbofnights.text);

    if (phonenb != null && nbofNights != null && name.isNotEmpty) {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => Page3(
    name: name,
    phonenb: phonenb,
    nbofNights: nbofNights,
    ),
    ),
    );
    } else {

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Invalid name or phone number or number of nights'),
    duration: Duration(seconds: 2), // Adjust the duration as needed
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
    _controllername.dispose();
    _controllernumber.dispose();
    _controllernbofnights.dispose();
  }
}
