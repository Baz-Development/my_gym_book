import 'package:flutter/material.dart';

class CustomPaginator extends StatelessWidget {
  int page;

  CustomPaginator({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.all(4),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: index == page ? const Color(0XFFFD5523) : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        )
      ],
    );
  }
}