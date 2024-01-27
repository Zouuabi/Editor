import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:editor/src/cubit/editor_cubit.dart';
import 'package:editor/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditorCubit(),
        child: Scaffold(
          backgroundColor: const Color(0xff171717),
          body: BlocBuilder<EditorCubit, EditorState>(
            builder: ((context, state) {
              return Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.undo)),
                        const SizedBox(width: 20),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.redo)),
                      ],
                    ),
                  ),
                  ...(state.data.map(
                    (e) {
                      return EditableDragballText(
                        fontFamily: e.fontFamily,
                        fontSize: e.fontSize,
                        isSelected: e.isSelected,
                        color: e.color,
                        onTap: () {
                          BlocProvider.of<EditorCubit>(context)
                              .selectText(id: e.id);
                        },
                      );
                    },
                  ).toList()),
                  Positioned(
                    bottom: 25,
                    left: 0,
                    right: 0,
                    child: Controllers(
                      onFontFamilySelected: (fontFamily) {
                        BlocProvider.of<EditorCubit>(context)
                            .changeFontFamily(fontFamily: fontFamily);
                      },
                      onColorSelected: (color) {
                        BlocProvider.of<EditorCubit>(context)
                            .changeColor(color: color);
                      },
                      onAddTextPressed: () {
                        BlocProvider.of<EditorCubit>(context).addText();
                      },
                      onSizeSelected: (size) {
                        BlocProvider.of<EditorCubit>(context)
                            .changeTextSize(fontSize: size);
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}

class Controllers extends StatelessWidget {
  const Controllers(
      {super.key,
      required this.onSizeSelected,
      required this.onAddTextPressed,
      required this.onColorSelected,
      required this.onFontFamilySelected});
  final void Function(double size) onSizeSelected;
  final void Function(Color color) onColorSelected;
  final void Function(String fontFamily) onFontFamilySelected;
  final VoidCallback onAddTextPressed;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AddButton(
          onPressed: onAddTextPressed,
        ),
        const SizedBox(width: 20),
        Container(
            width: screen.width * 0.6,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FontFamilySelector(
                    onFontFamilySelected: onFontFamilySelected,
                  ),
                  ColorSelector(onColorSelected: onColorSelected),
                  FontSizeSelector(onSizeSelected: onSizeSelected),
                ])),
      ],
    );
  }
}
