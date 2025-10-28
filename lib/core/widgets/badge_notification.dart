import 'package:flutter/material.dart';

Widget buildBadge(int count) {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.redAccent,
      shape: BoxShape.circle,
    ),
    child: Text(
      '$count',
      style: TextStyle(color: Colors.white, fontSize: 12),
    ),
  );
}
