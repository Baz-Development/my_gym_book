import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() irParaPaginaInicial;
  final Color borderColor;
  final Color backgroundColor;
  final bool isUserInteractive;

  const CustomButton({super.key, required this.title, required this.irParaPaginaInicial, required this.backgroundColor, required this.borderColor, required this.isUserInteractive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 50,
          width: 175,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: borderColor)))),
            onPressed: isUserInteractive ? () {
              irParaPaginaInicial();
            } : null,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        )
      ],
    );
  }
}