import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'modelclass.dart';
WeatherModel? wm;


class WeatherItem extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String imageUrl;

  const WeatherItem({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$title",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white54,fontSize: 16)),
        Container(
          padding: const EdgeInsets.all(5),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "${value}$unit",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
