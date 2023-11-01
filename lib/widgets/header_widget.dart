
import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;

  HeaderWidget(this._height);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState(_height);
}

class _HeaderWidgetState extends State<HeaderWidget> {
  double _height;

  _HeaderWidgetState(this._height);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            clipper: ShapeClipper([
              Offset(width / 5, _height),
              Offset(width / 10 * 5, _height - 60),
              Offset(width / 5 * 4, _height + 20),
              Offset(width, _height - 18)
            ]),
          ),
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.4),
                    Theme.of(context).accentColor.withOpacity(0.4),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            clipper: ShapeClipper(
              [
                Offset(width / 3, _height + 20),
                Offset(width / 10 * 8, _height - 60),
                Offset(width / 5 * 4, _height - 60),
                Offset(width, _height - 20)
              ],
            ),
          ),
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const  Color(0xffC2892D),
                      Color.fromARGB(255, 235, 224, 210).withOpacity(.5),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            clipper: ShapeClipper([
              Offset(width / 5, _height),
              Offset(width / 2, _height - 40),
              Offset(width / 5 * 4, _height - 80),
              Offset(width, _height - 20)
            ]),
          ),
        ],
      ),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 20);

    path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    // path.quadraticBezierTo(
    //     _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    // path.quadraticBezierTo(
    //     _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
