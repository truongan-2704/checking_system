import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool isShowBack;
  final Color? titleColor;
  final bool isCenterTitle;
  final Color? background;
  final void Function()? onBackButtonPressed;
  final List<Widget>? actions;

  const MainAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.titleColor,
    this.isShowBack = true,
    this.isCenterTitle = false,
    this.onBackButtonPressed,
    this.actions,
    this.background,
  });

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isShowBack == true ? Colors.white : Colors.transparent,
      padding: EdgeInsets.symmetric(
          horizontal: widget.isShowBack == true
              ? 24
              : widget.actions == null
                  ? 0
                  : widget.actions!.length * 24),
      child: AppBar(
        backgroundColor: widget.background ?? Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        leadingWidth: widget.isShowBack ? 24 : 0,
        centerTitle: widget.isCenterTitle,
        title: Center(
          child: widget.titleWidget ??
              Text(
                widget.title ?? '',
              ),
        ),
        leading: widget.isShowBack
            ? GestureDetector(
                onTap: widget.onBackButtonPressed ?? onBack,
                child: const Icon(
                  Icons.menu,
                ),
              )
            : const SizedBox(),
        actions: widget.actions ?? [const SizedBox()],
      ),
    );
  }

  void onBack() {
    Navigator.pop(context);
  }
}
