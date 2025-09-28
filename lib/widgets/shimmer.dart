import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerItem() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      margin: const EdgeInsets.all(8),
      height: 100,
      color: Colors.white,
    ),
  );
}
