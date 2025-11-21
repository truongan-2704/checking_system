import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.height,
    required this.widgetInCard,
    required this.onPressed,
  }) : super(key: key);
  final double height;
  final Widget widgetInCard;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xffffffff),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: widgetInCard,
      ),
    );
  }
}
