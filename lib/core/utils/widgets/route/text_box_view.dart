// import 'dart:async';

// import 'package:flutter/material.dart';
// import '../../localizations.dart';
// import '../locale_directionality.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// class TextBoxView extends StatefulWidget {
//   const TextBoxView({
//     super.key,
//     required this.controller,
//     this.hintText,
//     this.hintTextDirection,
//     this.keyboardType = TextInputType.multiline,
//     this.maxLength,
//     this.textDirection,
//   });

//   final TextEditingController controller;
//   final String? hintText;
//   final TextDirection? hintTextDirection;
//   final TextInputType keyboardType;
//   final int? maxLength;
//   final TextDirection? textDirection;

//   @override
//   State<TextBoxView> createState() => _TextBoxViewState();
// }

// class _TextBoxViewState extends State<TextBoxView> {
//   bool isClosing = false;
//   bool isKeyboardVisible = false;
//   late StreamSubscription<bool> keyboardSubscription;

//   @override
//   void dispose() {
//     keyboardSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();

//     var keyboardVisibilityController = KeyboardVisibilityController();

//     keyboardSubscription = keyboardVisibilityController.onChange.listen((
//       bool visible,
//     ) {
//       if (isKeyboardVisible && !visible && !isClosing) {
//         // ignore: use_build_context_synchronously
//         Navigator.pop(context);
//       }
//       isKeyboardVisible = visible;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bottomInsets = MediaQuery.viewInsetsOf(context).bottom;
//     return PopScope(
//       // ignore: deprecated_member_use
//       onPopInvoked: (didPop) => isClosing = didPop,
//       child: AnimatedPadding(
//         duration: Durations.short4,
//         padding: EdgeInsets.only(bottom: bottomInsets),
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: LocaleDirectionality(
//               child: Material(
//                 color: const Color.fromARGB(0, 53, 52, 52),
//                 child: TextField(
//                   controller: widget.controller,
//                   autofocus: true,
//                   enableSuggestions: true,
//                   minLines: 1,
//                   maxLines: null,
//                   maxLength: widget.maxLength,
//                   buildCounter:
//                       (
//                         context, {
//                         required currentLength,
//                         required isFocused,
//                         required maxLength,
//                       }) => null,
//                   textDirection:
//                       widget.textDirection ??
//                       getTextDirectionality(widget.controller.text),
//                   keyboardType: widget.keyboardType,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.black,
//                     hintText: widget.hintText,
//                     hintTextDirection: widget.hintTextDirection,
//                     hintStyle: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
