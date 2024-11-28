

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';

import '../Static Data/text_styles.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? isBack;
  final Widget? actionIcon;
  const MainAppBar({super.key, required this.title,this.isBack, this.actionIcon});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar>  with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.bgColor,
      leadingWidth: 80,
      actions: widget.actionIcon != null ?
      [
        widget.actionIcon!,
        const SizedBox(width: 16,),
      ] :
      [

      ],
      toolbarHeight: 50,
      leading: widget.isBack ?? false ? InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.containerColor,
              shape: BoxShape.circle
          ),
          height: 40,width: 40,child: Center( child: SvgPicture.asset("assets/icons/arrow left.svg")),
        ),
      ) : null,
      title: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Text(
              widget.title,
              style: TextStyles.heading1,
              maxLines: 1,overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
