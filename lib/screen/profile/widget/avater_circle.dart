import 'package:flutter/material.dart';

class AvatarCircle extends StatefulWidget {
  const AvatarCircle({
    Key? key,
    required this.withImage,
    required this.heightImage,
    required this.image,
  }) : super(key: key);

  final double withImage, heightImage;
  final String image;
  @override
  State<AvatarCircle> createState() => _AvatarCircleState();
}

class _AvatarCircleState extends State<AvatarCircle> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: widget.withImage,
        width: widget.heightImage,
        child: CircleAvatar(backgroundImage: AssetImage(widget.image)),
      ),
    );
  }
}
