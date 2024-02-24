import 'package:flutter/material.dart';

// class ErrorView extends StatelessWidget {
//   const ErrorView(Object? error, {super.key}) : error = error as Error;

//   final Error error;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "${error.runtimeType}: $error",
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         Text(
//           "${error.stackTrace}",
//           textAlign: TextAlign.left,
//         ),
//       ],
//     );
//   }
// }

class ErrorView extends StatelessWidget {
  const ErrorView(this.error, {super.key});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Text(
        "${error.runtimeType}: $error",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ];

    if (error is Error) {
      children.add(Text(
        "${(error as Error).stackTrace}",
        textAlign: TextAlign.left,
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
