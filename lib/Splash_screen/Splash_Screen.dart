// import 'package:flutter/material.dart';
// import 'package:weather_app/main.dart';
//
//
// class GetStartedPage extends StatelessWidget {
//   const GetStartedPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: 900,
//         width: 490,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         decoration: const BoxDecoration(
//         gradient: LinearGradient(
//             colors: [Colors.blueAccent,Colors.orangeAccent]),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: 100,),
//           Container(
//           height: 400,
//           width: 490,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [Colors.blueAccent,Colors.orangeAccent]),
//             image: DecorationImage(
//                 image: AssetImage('assets/images/s2.png'),
//                 fit: BoxFit.fill
//             ),
//           ),),
//             SizedBox(height: 60,),
//             Text('Reports on a heatwave warning in Tamil Nadu, a severe heatwave in West Bengal and Odisha, and a heatwave likely in many states voting today',
//               style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600, ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 32,),
//             MaterialButton(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(31)),
//               height: 58,
//               color: Colors.blue,
//               onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyHomePage(title: ''))),
//               child: const Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 18),) ,
//             ),
//             const SizedBox(height: 32,)
//           ],
//         ),
//       ),
//     );
//   }
// }
