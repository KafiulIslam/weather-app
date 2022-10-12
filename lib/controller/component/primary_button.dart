import 'package:flutter/material.dart';

import '../constant/color.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonTitle;
  final bool isLoading;

  const PrimaryButton(
      {Key? key,
      required this.onTap,
      this.buttonTitle = 'Search',
        required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(2.5, 2.5), // changes position of shadow
            ),
          ],
        ),
        child: isLoading == true
            ? SizedBox(
           height: 25,
            width: 25,
            child: CircularProgressIndicator(color: assColor.withOpacity(0.5)))
            : Text(
                buttonTitle,
                style: const TextStyle(
                    color: assColor, fontSize: 25, fontWeight: FontWeight.w900),
              ),
      ),
    );
  }
}
