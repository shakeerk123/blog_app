

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class BackgroundImageContainer extends StatelessWidget {
  const BackgroundImageContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            'https://images.unsplash.com/photo-1537204319452-fdbd29e2ccc7?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
