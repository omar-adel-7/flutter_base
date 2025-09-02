import 'package:flutter/material.dart';

class CustomLikeButton extends StatelessWidget {
  final bool? isLiked;
  final Widget likedWidget;
  final Widget unlikedWidget;
  final GestureTapCallback? onTap;

  const CustomLikeButton({
    super.key,
    this.isLiked,
    this.onTap,
    required this.likedWidget,
    required this.unlikedWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
        onTap: onTap,
      child: isLiked??false
          ? likedWidget
          : unlikedWidget,
    );
  }
}
