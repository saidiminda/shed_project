import 'package:flutter/material.dart';
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final double height=MediaQuery.of(context).size.height;
       final double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Colors.white,
      body: Column(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              color:Color(0xFF363f93),
            ),
            child: Stack(
              children:[
                Positioned(
                  top:80,
                  left:0,
                  child:Container(
                    height:100,width:300,
                    decoration:const BoxDecoration(
                      color:Colors.white,
                      borderRadius:BorderRadius.only(
                        topRight:Radius.circular(50),
                        bottomRight:Radius.circular(50),
                      ),
                    )
                  )
                ),
                const Positioned(
                  top:110,
                  left:20,
                  child: Text('Your')
                  ),

              ]
            ),
          ),
          SizedBox(height:height*0.05,),
          Container(
            height: 230,
            child: Stack(
              children: [
                Positioned(child: Material(
                  child: Container(
                    height: 180.0,
                    width: width*0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.0),
                      // new BoxShadow(
                      //   color: Colors.grey.withOpacity(0.3),
                      //   offset: new Offset(-10.0, 10.0),
                      //   blurRadius: 20.0spreadRadius: 4.0)
                    ),
                    
                  ),
                ),
                ),
                Positioned(
                  top:0,
                  left:30,
                  child:Card(
                    elevation:10.0,
                    shadowColor:Colors.grey.withOpacity(0.5),
                    shape:RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(15.0),
                    ),
                    child:Container(
                      height:200,
                      width:150,
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(10.0),
                        image:const DecorationImage(
                          fit:BoxFit.fill,
                          image:AssetImage(""),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top:60,
                  left:200,
                  child: Container(
                  height: 150,
                  width: 160,
                  child: Column(
                    children: [
                      Text('The Big Articles'),
                    ],
                  ),        
                ))
              ],
            ),
          ),
        Expanded(
          child: 
        ListView(
          children: [

          ], 
        ))
        ],
      ),
    );
  }
}