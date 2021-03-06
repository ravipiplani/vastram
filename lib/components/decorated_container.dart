import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  final bool showGradient;
  final bool showImage;
  final bool borderTop;
  final bool borderRight;
  final bool borderBottom;
  final bool borderLeft;
  final DecorationImage backgroundImage;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;

  DecoratedContainer({this.child, this.showGradient = true, this.showImage = true, this.borderTop = false, this.borderRight = false, this.borderBottom = false, this.borderLeft = false, this.padding = const EdgeInsets.all(0), this.margin = const EdgeInsets.all(0), this.color = Colors.transparent, this.backgroundImage = const DecorationImage(
      image: AssetImage("assets/images/bg.png"),
      fit: BoxFit.cover,
      // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop)
    )});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: showGradient ? Colors.white : Colors.transparent,
        gradient: showGradient ? LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0, 1],
          colors: [
            const Color(0xFF21D0FD).withOpacity(0.2),
            const Color(0xFFEE4DB9).withOpacity(0.2)
          ],
        ) : null,
        image: showImage ? backgroundImage : null,
        border: Border(
          top: borderTop ? BorderSide(
            width: 1,
            color: Theme.of(context).primaryColor.withOpacity(0.3)
          ) : BorderSide(width: 0, style: BorderStyle.none),
          right: borderRight ? BorderSide(
            width: 1,
            color: Theme.of(context).primaryColor.withOpacity(0.3)
          ) : BorderSide(width: 0, style: BorderStyle.none),
          bottom: borderBottom ? BorderSide(
            width: 1,
            color: Theme.of(context).primaryColor.withOpacity(0.3)
          ) : BorderSide(width: 0, style: BorderStyle.none),
          left: borderLeft ? BorderSide(
            width: 1,
            color: Theme.of(context).primaryColor.withOpacity(0.3)
          ) : BorderSide(width: 0, style: BorderStyle.none)
        )
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}