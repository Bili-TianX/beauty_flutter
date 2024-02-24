import 'package:flutter/material.dart';

class ReloadButton extends FloatingActionButton {
  const ReloadButton(void Function() onReload, {super.key})
      : super(
          onPressed: onReload,
          child: const Icon(Icons.refresh),
        );
}
