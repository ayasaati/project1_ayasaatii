import 'package:flutter/material.dart';
import 'page2.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  String image = 'assets/pool.jpg';
  List<String>images = [
    'assets/pool.jpg',
    'assets/hallway1.jpeg',
    'assets/reception1.jpeg',
    'assets/reception2.jpeg',
  ];
  static int count = 0;



  void updateText() {
    setState(() {
      image = images[count];
      count = (count + 1) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
       preferredSize: Size.fromHeight(40.0),
       child: AppBar(

        backgroundColor:Colors.brown[700],
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(100),

    )
        ),

        centerTitle: true,
      )
      ),
      backgroundColor: Colors.grey[300],
    body:Padding(


      padding:EdgeInsets.only(top:30,left:32,right:32),
    child:SingleChildScrollView(


    child: Column(


    mainAxisAlignment: MainAxisAlignment.center,

    children:[
     /* body:Center(
      child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
      */


        // const SizedBox(height:100),
          //SizedBox(width:400,height:150,

     // const SizedBox(height:50,child:
            Text('GrandHorizon',textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 50,fontStyle: FontStyle.italic))
     // )
           ,Text('Hotel',textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 40,fontStyle: FontStyle.italic),)

        ,Row(mainAxisAlignment: MainAxisAlignment.center,
             // crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Icon(
              Icons.hotel_class,
              size: 40,
            ),Icon(
              Icons.hotel_class,
              size: 40,
            ),
                  Icon(
                    Icons.hotel_class,
                    size: 40,
                  ),
                  Icon(
                    Icons.hotel_class,
                    size: 40,
                  ),
                  Icon(
                    Icons.hotel_class,
                    size: 40,
                  ),
          ]
            ),
      const SizedBox(height:10),

            Image.asset(image,width:600.0,height:250.0),
      const SizedBox(height:20),
          ElevatedButton(onPressed:(){updateText();},child: Icon(
            Icons.double_arrow,
            size: 40,),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),
          ),
          ) //Text('>',style:TextStyle(fontSize:24.0),)),
          , const SizedBox(height:10),




           Text('-Welcome to GrandHorizon Hotel Booking, where luxury meets convenience. Unleash a world of seamless travel experiences at your fingertips with our user-friendly app.-',textAlign: TextAlign.start,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic,color: Colors.brown,fontWeight:FontWeight.bold)),
          const SizedBox(height:20),
          Text('-Discover, book, and indulge in the epitome of hospitality with just a tap – your gateway to unforgettable stays awaits!-',textAlign: TextAlign.start,style:TextStyle(fontSize: 15,fontStyle: FontStyle.italic,color: Colors.brown,fontWeight:FontWeight.bold))

        ,const SizedBox(height:10),
             ElevatedButton(
                 style: const ButtonStyle(
                   backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),
                 //  foregroundColor: MaterialStatePropertyAll<Color>(Colors.black)
                 ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder:(context)=>const Page2()));
                // Add navigation logic or further actions here
              },
              //  style:ElevatedButton(backgroun)
              child: Text('Get Started'),
            ),
        ]),





      ),

    )
    );

  //  );
  }
}

