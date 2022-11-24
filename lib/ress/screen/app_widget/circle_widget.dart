import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
          height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.35,
          width: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.35,
          decoration: BoxDecoration(
            color: const Color(0xFFEC407A),
            borderRadius: BorderRadius.circular(
              (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.35,
            ),
          ),
        ),
        Positioned(
          top: mediaQueryData.size.width * 0.05,
          right: 0,
          child: Container(
            height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.25,
            width: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.25,
            decoration: BoxDecoration(
              color: const Color(0xFFF06292),
              borderRadius: BorderRadius.circular(
                (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
