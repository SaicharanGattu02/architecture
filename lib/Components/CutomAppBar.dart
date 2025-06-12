import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/color_constants.dart';

class CustomAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const CustomAppBar1({Key? key, required this.title, required this.actions})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true,
      backgroundColor: primarycolor,
      leading: IconButton.outlined(
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
          shape: MaterialStateProperty.all(CircleBorder()),
        ),
        visualDensity: VisualDensity.compact,
        onPressed: () {
          context.pop(true);
        },
        icon: Icon(Icons.arrow_back, size: 24, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
