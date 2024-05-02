import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider.dart';

import 'main.dart';

class SearchScreen extends StatefulWidget {
  final String? city;
  final String? tid;
  final String? tempc;
  final String? tempf;
  final String? Icon;
  final int? tags;
  const SearchScreen({
    super.key,
    required this.city,
    required this.tid,
    required this.tempc,
    required this.tempf,
    this.Icon,
    this.tags
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<weatherProvider>(context,listen: true);
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 110,
        title: Container(
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            child: TextField(
              onSubmitted: (value){
                searchController.text = value;
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage(title: searchController.text),), (route) => false);
              },
              controller: searchController,
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  left: 0,
                  bottom: 11,
                  top: 11,
                  right: 15,
                ),
                hintText: "Search Location",
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('data')
              // Container(
              //   height: height,
              //   child: ListView.builder(
              //     itemCount: searchList.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: InkWell(
              //           onTap: (){
              //             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage(title: widget.city!),), (route) => false);
              //
              //           },
              //           child: Container(
              //             height: 130,
              //             width: width,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(15),
              //                 color:(proVar.getTheme == false)?Colors.black12:Colors.white ,
              //                 boxShadow: [
              //                   BoxShadow(
              //                       blurRadius: 8,
              //                       blurStyle: BlurStyle.outer,
              //                       color:(proVar.getTheme == false)?Colors.black87:Colors.white70
              //                   )
              //                 ],
              //                 image: DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1JXa5mfkD6TlbgBy-14-NyPLpkYZRiSR76w&usqp=CAU',),fit: BoxFit.cover)
              //
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Column(
              //                   children: [
              //                     SizedBox(height: 25,),
              //                     Text(searchList[index].city!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26,color: Colors.white),),
              //                     Text(searchList[index].tid!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white54),),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     Image.network(
              //                         "https:" + searchList[index].Icon!),
              //                     (proVar.getTemp == false)? Text(
              //                       '${searchList[index].tempc}°C',
              //                       style: TextStyle(
              //                           fontSize: 35,
              //                           fontWeight: FontWeight.w600,
              //                           color: Colors.white
              //                       ),
              //                     ):Text('${searchList[index].tempc}°F',
              //                       style: TextStyle(
              //                           fontSize: 35,
              //                           fontWeight: FontWeight.w600,
              //                           color: Colors.white
              //                       ),),
              //                   ],
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
