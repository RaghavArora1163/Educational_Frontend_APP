import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:online/utils/app_colors/app_color.dart';

class CommonAppbar extends StatefulWidget {
  final String? title;
  final bool isDrawerShow;
  final bool isSearchShow;
  final bool isNotificationShow;
  final VoidCallback? onLeadingTap;
  final CustomClipper<Path>? clipper;
  final ScrollController? scrollController;
  final bool isScrolled;

  const CommonAppbar({
    super.key,
    this.title,
    this.isDrawerShow = true,
    this.isSearchShow = true,
    this.isNotificationShow = true,
    this.onLeadingTap,
    this.clipper,
    this.scrollController,
    this.isScrolled = true
  });

  @override
  State<CommonAppbar> createState() => _CommonAppbarState();
}

class _CommonAppbarState extends State<CommonAppbar> {
  bool _showFlatBar = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (widget.scrollController == null) return;

    final offset = widget.scrollController!.offset;
    if (offset > 20 && !_showFlatBar) {
      setState(() => _showFlatBar = true);
    } else if (offset <= 20 && _showFlatBar) {
      setState(() => _showFlatBar = false);
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isScrolled = _showFlatBar;

    return ClipPath(
      clipper: isScrolled ? null : (widget.clipper ?? CustomAppBarClipper()),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF191919), Color(0xFF8C0000)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: isScrolled
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        padding: EdgeInsets.only(
          top: isScrolled ? 50 : 60, 
          left: 16, 
          right: 16, 
          bottom: isScrolled ? 20 : 28
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.isDrawerShow)
              IconButton(
                icon: Icon(
                  Icons.menu, 
                  color: Colors.white,
                  size: isScrolled ? 24 : 26,
                ),
                onPressed: widget.onLeadingTap,
                padding: EdgeInsets.all(8),
              ),
            if (widget.title != null)
              Expanded(
                child: Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isScrolled ? 18 : 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Row(
              children: [
                if (widget.isSearchShow)
                  IconButton(
                    icon: Icon(
                      Icons.search, 
                      color: Colors.white,
                      size: isScrolled ? 24 : 26,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.all(8),
                  ),
                if (widget.isNotificationShow)
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none, 
                      color: Colors.white,
                      size: isScrolled ? 24 : 26,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.all(8),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
