// This widget will draw header section of all page. Wich you will get with the project source code.

import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;
  final bool _showIcon;
  final String _icon;
  final bool _showClose;
  final Function() onTap;

  const HeaderWidget(this._height, this._showIcon, this._icon, this._showClose, {Key? key, required this.onTap}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState(_height, _showIcon, _icon, _showClose, onTap);
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final double _height;
  final bool _showIcon;
  final bool _showClose;
  final String _icon;
  final Function() _onTap;

  _HeaderWidgetState(this._height, this._showIcon, this._icon, this._showClose, this._onTap);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Stack(
      children: [
        ClipPath(
          clipper: ShapeClipper(
            [
              Offset(width / 5, _height),
              Offset(width / 10 * 5, _height - 60),
              Offset(width / 5 * 4, _height + 20),
              Offset(width, _height - 18)
            ]
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.4),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: ShapeClipper(
            [
              Offset(width / 3, _height + 20),
              Offset(width / 10 * 8, _height - 60),
              Offset(width / 5 * 4, _height - 60),
              Offset(width, _height - 20)
            ]
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.4),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: ShapeClipper(
            [
              Offset(width / 5, _height),
              Offset(width / 2, _height - 40),
              Offset(width / 5 * 4, _height - 80),
              Offset(width, _height - 20)
            ]
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp
              ),
            ),
          ),
        ),
        Visibility(
          visible: _showIcon,
          child: SizedBox(
            height: _height - 40,
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(
                  left: 5.0,
                  top: 10.0,
                  right: 5.0,
                  bottom: 10.0,
                ),
                child:
                Image.asset(
                  _icon
                )
              ),
            ),
          ),
        ),
        Visibility(
          visible: _showClose,
          child: SizedBox(
            height: _height - 40,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.only(
                left: 5.0,
                top: 10.0,
                right: 5.0,
                bottom: 10.0,
              ),
              child: IconButton(
                onPressed: () {
                  debugPrint("close clicked");
                  _onTap();
                },
                icon: const Icon( Icons.arrow_back_ios_new)
              )
            ),
          ),
        )
      ],
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height-20);

    path.quadraticBezierTo(_offsets[0].dx, _offsets[0].dy, _offsets[1].dx,_offsets[1].dy);
    path.quadraticBezierTo(_offsets[2].dx, _offsets[2].dy, _offsets[3].dx,_offsets[3].dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
