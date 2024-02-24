import 'package:flutter/material.dart';

class GoBackButton extends IconButton {
  GoBackButton(BuildContext context, {super.key})
      : super(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        );
}
