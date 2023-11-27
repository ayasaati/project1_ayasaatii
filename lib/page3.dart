import 'package:flutter/material.dart';
import 'reservation.dart';
import 'page2.dart';
class Page3 extends StatefulWidget {
  Page3({ super.key,required this.name,required this.phonenb,required this.nbofNights });
  final String name;
 final int phonenb;
 final int nbofNights;


  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {

  String bundle='Luxury';
  int bundleprice=100;
  final TextEditingController radioController = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar:
        PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: AppBar(


                title:Text('Welcome ${widget.name} Choose Your Bundle'),
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
       children: [


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

    });
    })]),const SizedBox(height:20),Row( children:[
           Text('Add Tennis Court(\$40 per night)',style:TextStyle(fontSize:18.0)),
           Checkbox(value:tennisSelected,onChanged:(bool?value){
             setState((){
               tennisSelected= value as bool;

             });
           })]),const SizedBox(height:20),Row( children:[
          Text('Add Gym Activities(\$60 per night)',style:TextStyle(fontSize:18.0)),
          Checkbox(value:gymSelected,onChanged:(bool?value){
            setState((){
              gymSelected= value as bool;

            });
          })])
    ,const SizedBox(height:20)
    ,ElevatedButton(
    onPressed: () {
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

    },
    child:const Text('Book Now!'),style: const ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),

    ),
    ),
    const SizedBox(height:20),
    ElevatedButton(
    onPressed: () {Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => DisplayPage(
        bundle: bundle,
        radioValue: radioController.text,
        dropdownValue: room,
        bundleprice: bundleprice,
        spaSelected:spaSelected,
        tennisSelected:tennisSelected,
        gymSelected:gymSelected,
        name:widget.name,
        phonenb:widget.phonenb,
        nbofNights:widget.nbofNights,
    ),
    ),
    );

    },child:const Text('View Booking Information=>'),style: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),))
         ,const SizedBox(height: 20)
    ],
    ),))
    ));
  }

  @override
  void dispose() {
    radioController.dispose();
    dropdownController.dispose();
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
  final String name;
  int phonenb;
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


  DisplayPage({required this.bundle,required this.dropdownValue,required this.radioValue,required this.bundleprice,required this.spaSelected,required this.tennisSelected,required this.gymSelected, required this.name,required this.phonenb,required this.nbofNights});



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
            ,Text('Resident Name: $name'),
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
          ],
        ),
      ),
    );




}
}

