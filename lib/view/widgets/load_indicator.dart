import 'package:flutter/material.dart';

class LoadIndicator extends StatelessWidget {
  const LoadIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }
}
