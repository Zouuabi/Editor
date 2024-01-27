import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditableDragballText extends StatefulWidget {
  const EditableDragballText(
      {super.key,
      required this.onTap,
      required this.fontSize,
      required this.fontFamily,
      required this.color,
      required this.isSelected});

  final VoidCallback onTap;
  final double fontSize;
  final String fontFamily;
  final Color color;
  final bool isSelected;

  @override
  State<EditableDragballText> createState() => EditableDragballTextState();
}

class EditableDragballTextState extends State<EditableDragballText> {
  final TextEditingController _controller = TextEditingController();
  String text = 'Double Tap to Edit Me !';

  double xPosition = 0;
  double yPosition = 150 + Random().nextDouble() * 200;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Positioned(
        top: yPosition,
        left: xPosition + width * 0.2,
        child: Draggable(
          onDragUpdate: (details) {
            setState(() {
              xPosition += details.delta.dx;
              yPosition += details.delta.dy;
            });
          },
          feedback: Container(),
          child: GestureDetector(
            onTap: widget.onTap,
            onDoubleTap: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Center(
                      child: Text(
                        'Edit text',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    content: TextField(
                      decoration: const InputDecoration(
                          hintText: 'Double Tap to Edit Me !'),
                      controller: _controller,
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );

              if (_controller.text.trim() != '') {
                setState(() {
                  text = _controller.text;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  border: widget.isSelected
                      ? Border.all(color: Colors.grey)
                      : null),
              child: Text(text,
                  style: GoogleFonts.getFont(
                    widget.fontFamily,
                    fontSize: widget.fontSize,
                    color: widget.color,
                  )),
            ),
          ),
        ));
  }
}
