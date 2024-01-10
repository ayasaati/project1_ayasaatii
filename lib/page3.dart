import 'package:flutter/material.dart';
import 'reservation.dart';
import 'page2.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
const String _baseURL='https://ayasaatiliu.000webhostapp.com';
const String _baseeURL = 'ayasaatiliu.000webhostapp.com';
final List<String> _customers = [];
bool _load=false;
class Page3 extends StatefulWidget {
  Page3({ super.key,required this.fname,required this.lname,required this.phonenb });
  final String fname;
  final String lname;
 final String phonenb;
  Map<String, String> temporaryArguments = {};
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 //final int nbofNights;



  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final TextEditingController _controllernbofnights = TextEditingController();
  bool _loading = false;
  bool _load=false;
  String bundle='Luxury';
  int bundleprice=100;
  final TextEditingController radioController = TextEditingController();
  Map<String, String> temporaryArguments = {};
  final GlobalKey<FormState> _formKeyy = GlobalKey<FormState>();
  List<Reservation> dropdownItems = [
    Reservation(roomtype: 'Single', price: 30),
    Reservation(roomtype: 'Double', price: 50),
    Reservation(roomtype: 'Suite', price: 70),
  ];
  Reservation room= Reservation( roomtype: 'Single', price: 30);
  bool spaSelected =false;
  bool gymSelected=false;
  bool tennisSelected=false;
  final TextEditingController dropdownController = TextEditingController();
  String image = 'assets/resort.jpeg';
  int  spaFee=0;
  int tennisFee=0;
  int gymFee=0;
 int totalPrice=0;

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }


  void update1(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }


  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
  displayCustomers(update1);
  displayCustomersResort(update1);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar:
        PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: AppBar(


                title:Text('Welcome ${widget.fname} ${widget.lname}! Choose Your Bundle'),
                backgroundColor:Colors.brown[700],
                shadowColor: Colors.black

            )
        ),

        backgroundColor: Colors.grey[300]
        ,body: Scaffold(
    // backgroundColor: Colors.grey[300],
       body:
       SingleChildScrollView(
    //reverse:true,
    //padding:EdgeInsets.all(32),
       padding:EdgeInsets.only(top:40,left:32,right:32),
        child:SingleChildScrollView(
        reverse:true,
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,


    children:[
         SizedBox(height:10),
         Text("Enter The number of Nights:",textAlign: TextAlign.start),
         const SizedBox(height:15),
         SizedBox(width:300,height:60,
           child:TextField(controller:_controllernbofnights,keyboardType: TextInputType.number,decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter nb of nights')),
         ),
         SizedBox(height:10),
        Text('Choose Your Bundle:'),
        RadioListTile(
         title: Text('Luxury Bundle (\$100 per night)'),
         value: 'Luxury',
        groupValue: bundle,
           onChanged: (value) {
          setState(() {
          bundle = value as String;
          radioController.text = value.toString();
          bundleprice=100;
          });
         },
        ),
         Image.asset('assets/luxury.jpeg',width:600.0,height:250.0),
          RadioListTile(
           title: Text('Resort Bundle (\$200 per night) '),
           value: 'Resort',
           groupValue: bundle,
            onChanged: (value) {
            setState(() {
            bundle = value as String;
            radioController.text = value.toString();
            bundleprice=200;
            });
           },
          ), Image.asset('assets/resort.jpeg',width:600.0,height:250.0),
          const  SizedBox(height: 20),

         DropdownMenu(
         inputDecorationTheme: InputDecorationTheme(isDense:true) ,
         width:300.0, initialSelection: dropdownItems[0],
         onSelected:(value){
         setState(() {
         room= value as Reservation;
         dropdownController.text=room.toString();
          });
         },
          dropdownMenuEntries: dropdownItems.map<DropdownMenuEntry<Reservation>>((item){
          return DropdownMenuEntry(value: item, label:item.toString() );
           }).toList(),
         ),
             const SizedBox(height:120),
            Row(
            children:[
             Text('Add Spa & Beauty Treatment(\$20 per night)',style:TextStyle(fontSize:18.0)),
        Checkbox(value:spaSelected,onChanged:(bool?value){
          setState((){
           spaSelected= value as bool;
           spaFee = spaSelected ?20:0;
    });
    })]), SizedBox(height:20),Row( children:[
           Text('Add Tennis Court(\$40 per night)',style:TextStyle(fontSize:18.0)),
           Checkbox(value:tennisSelected,onChanged:(bool?value){
             setState((){
               tennisSelected= value as bool;
               tennisFee = tennisSelected ?40:0;
             });
           })]),const SizedBox(height:20),Row( children:[
          Text('Add Gym Activities(\$60 per night)',style:TextStyle(fontSize:18.0)),
          Checkbox(value:gymSelected,onChanged:(bool?value){
            setState((){
              gymSelected= value as bool;
              gymFee = gymSelected ?60:0;
            });

          })])
    , SizedBox(height:20)
    ,ElevatedButton(
    onPressed: () {int? nbofNights; nbofNights= int.parse(_controllernbofnights.text).toInt();
    if(bundle=='Luxury'){
    totalPrice=((100+room.price+spaFee+tennisFee+gymFee)*nbofNights);
    }
    else{
    totalPrice=((200+room.price+spaFee+tennisFee+gymFee)*nbofNights);
    }
    showDialog(context: context, builder: (context)=>AlertDialog(
      actions:[
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child:const Text('Close'),
        ),
      ],
      title:const Text('Successful Booking!'),
      contentPadding:const EdgeInsets.all(20.0),
      content:const Text('Your hotel residence has been booked successfully!')
    ));
    }

     /* Navigator.push(
          context,
          MaterialPageRoute(

              builder: (context) =>
                  DisplayPage(bundle: bundle,
                      radioValue: radioController.text,
                      dropdownValue: room,
                      bundleprice: bundleprice,
                      spaSelected: spaSelected,
                      tennisSelected: tennisSelected,
                      gymSelected: gymSelected,
                      fname: widget.fname,
                      lname: widget.lname,
                      phonenb: widget.phonenb,
                      nbofNights: nbofNights)));
    }}*/
    ,child:const Text('Book Now!'),style: const ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),

    ),
    ),
    const SizedBox(height:20),
    ElevatedButton(
    onPressed: () {int? nbofNights = int.tryParse(_controllernbofnights.text);

      if (nbofNights!=null) {
        insertBooking(update,radioController.text,dropdownController.text,spaFee,tennisFee,gymFee,totalPrice);
      }



    else{
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text('Please Enter You Desired Number of Nights'),
      duration: Duration(seconds: 2), // Adjust the duration as needed
      ));

      }
    }

    ,child:const Text('Submit!'),style: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),))
         ,const SizedBox(height: 20),
      ElevatedButton(
          onPressed: () {

            Navigator.push(
                context,
                MaterialPageRoute(

                builder: (context) =>
            DisplayLuxury()));
          }

          ,child:const Text('Display The Luxury Bookings!'),style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),))
      ,const SizedBox(height: 20),
      ElevatedButton(
          onPressed: () {

            Navigator.push(
                context,
                MaterialPageRoute(

                    builder: (context) =>
                        DisplayResort()));
          }

          ,child:const Text('Display The Resort Bookings!'),style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),))
    ],
    ),))
    ));
  }

  @override
  void dispose() {
    radioController.dispose();
    dropdownController.dispose();
    _controllernbofnights.dispose();
    super.dispose();
  }
}




class DisplayPage extends StatelessWidget {
  final String bundle;
  final Reservation dropdownValue;
  final String radioValue;
  final int bundleprice;
  bool spaSelected,tennisSelected,gymSelected;
  int spaFee=0,tennisFee=0,gymFee=0;
  final String fname;
  final String lname;
  String phonenb;
  int nbofNights;

  int getSpaFee(){
    return spaFee = spaSelected ?20:0;
  }
  int getTennisFee(){
    return tennisFee = tennisSelected ?40:0;
  }
  int getGymFee(){
    return gymFee = gymSelected ?60:0;
  }

  String  getTotalPrice(){spaFee =getSpaFee();
  tennisFee = getTennisFee();
  gymFee= getGymFee();

  if(bundle=='Luxury'){
    return((100+dropdownValue.price+spaFee+tennisFee+gymFee)*nbofNights).toStringAsFixed(0);
  }
  return((200+dropdownValue.price+spaFee+tennisFee+gymFee)*nbofNights).toStringAsFixed(0);
  }


  DisplayPage({required this.bundle,required this.dropdownValue,required this.radioValue,required this.bundleprice,required this.spaSelected,required this.tennisSelected,required this.gymSelected, required this.fname,required this.lname,required this.phonenb,required this.nbofNights});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child:AppBar(
        backgroundColor:Colors.brown[700],
        title: Text('Display Page'),
      )),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height:20),
            Text('You Residence has been booked!',style:TextStyle(fontWeight:FontWeight.bold,fontSize: 20,fontStyle: FontStyle.italic))
            , const SizedBox(height:20)
            ,Text('Resident Name: $fname $lname'),
            const SizedBox(height:20),
            Text('Phone Number: $phonenb'),
            const SizedBox(height:20),
            Text('Number of Nights: $nbofNights'),
            const SizedBox(height:20),
            Text('Type of Bundle: $bundle'),
            const SizedBox(height:20),
            Text('Bundle Price Per Night: \$$bundleprice'),
            const SizedBox(height:20),
            Text('Type of Room : ${dropdownValue.roomtype}'),
            const SizedBox(height:20),
            Text('Price of Room Per Night : \$${dropdownValue.price}'),
            const SizedBox(height:20),
            Text('Spa & Beauty Treatments: \$${getSpaFee()}'),
            const SizedBox(height:20),
            Text('Tennis Court: \$${getTennisFee()}'),
            const SizedBox(height:20),
            Text('Gym Activities: \$${getGymFee()}'),
            const SizedBox(height:20),
            Text('Total price: \$${getTotalPrice()}')
            //Text('Controller Value: $radiocontrollerValue'),
          ]
        ),
      ),
    );




}
}


void insertBooking(Function(String text) update, String bundle, String room,int spaFee,int tennisFee,int gymFee,int totalPrice) async {
  try {
    // we need to first retrieve and decrypt the key
    // send a JSON object using http post
    final response = await http.post(
        Uri.parse('$_baseURL/insertBooking.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }, // convert the cid, name and key to a JSON object

        body: convert.jsonEncode(<String, String>{
          'bundle': bundle, 'room': room, 'spaFee':'$spaFee','tennisFee':'$tennisFee','gymFee':'$gymFee','totalPrice':'$totalPrice'
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

class DisplayLuxury extends StatefulWidget {

  const DisplayLuxury({super.key});

  @override
  State<DisplayLuxury> createState() => _DisplayLuxury();
}

class _DisplayLuxury extends State<DisplayLuxury> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Available Customers'),
          centerTitle: true,
        ),
        body: _load ? const ListCustomers() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}



void displayCustomers(Function(bool success) update1) async {
  try {
    final url = Uri.https(_baseeURL, 'displayCustomers.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    _customers.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(
          response.body); // create dart json object from json array
      for (var row in jsonResponse) {
        if (row['bundle'] =="Luxury"){
          //  'Luxury') { // iterate over all rows in the json array
          _customers.add(
              'bundle: ${row['bundle']} room: ${row['room']} spaFee: int.tryParse(${row['room']}) tennisFee: int.tryParse(${row['tennisFee']})  gymFee: int.tryParse(${row['gymFee']})  totalPrice: ${row['totalPrice']}');
        }
      }
      update1(true); // callback update method to inform that we completed retrieving data
    }
  }
  catch(e) {
    update1(false); // inform through callback that we failed to get data
  }
}


class DisplayResort extends StatefulWidget {
  const DisplayResort({super.key});

  @override
  State<DisplayResort> createState() => _DisplayResortState();
}

class _DisplayResortState extends State<DisplayResort> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Available Customers'),
          centerTitle: true,
        ),
        body: _load ? const ListCustomers() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}


class ListCustomers extends StatelessWidget {
  const ListCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _customers.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(child: Text(_customers[index], style: TextStyle(fontSize: 18)))
          ])
        ])
    );
  }
}






void displayCustomersResort(Function(bool success) update1) async {
  try {
    final url = Uri.https(_baseeURL, 'displayCustomers.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    _customers.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(
          response.body); // create dart json object from json array
      for (var row in jsonResponse) {
        if (row['bundle'] =="Resort"){
          //  'Luxury') { // iterate over all rows in the json array
          _customers.add(
              'bundle: ${row['bundle']} room: ${row['room']} spaFee: int.tryParse(${row['room']}) tennisFee: int.tryParse(${row['tennisFee']})  gymFee: int.tryParse(${row['gymFee']})  totalPrice: ${row['totalPrice']}');
        }
      }
      update1(true); // callback update method to inform that we completed retrieving data
    }
  }
  catch(e) {
    update1(false); // inform through callback that we failed to get data
  }
}
