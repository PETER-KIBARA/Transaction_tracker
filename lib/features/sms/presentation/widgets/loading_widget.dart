import 'package:flutter/material.dart';

/// Loading widget for async operations
class LoadingWidget extends StatelessWidget {
  final double? height;

  const LoadingWidget({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
