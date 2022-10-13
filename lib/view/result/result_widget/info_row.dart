import 'package:flutter/material.dart';

import '../../../controller/constant/typography.dart';

class InfoRow extends StatelessWidget {
  final String data1;
  final String data2;
  const InfoRow({Key? key,required this.data1, required this.data2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data1,style: sixteenWhiteStyle,),
          Text(data2,style: sixteenWhiteStyle,),
        ],),
    );
  }
}
