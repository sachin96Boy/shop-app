import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BadgeCount extends StatelessWidget {
  final Widget? child;
  final String value;
  final Color color;

  const BadgeCount(
      {super.key,
      required this.child,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -4, end: -5),
      showBadge: true,
      ignorePointer: false,
      onTap: () {},
      badgeContent: Text(value, style: const TextStyle(fontSize: 10.0)),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: color,
        elevation: 0,
      ),
      child: child,
    );
  }
}
