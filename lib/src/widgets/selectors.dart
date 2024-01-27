import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> fontFamilies = [
  'Roboto',
  'Open Sans',
  'Lato',
  'Raleway',
  'Oswald',
  'Slabo 27px',
  'Roboto Condensed',
  'Montserrat',
  'Merriweather'
];

class FontFamilySelector extends StatelessWidget {
  const FontFamilySelector({
    super.key,
    required this.onFontFamilySelected,
  });
  final void Function(String fontFamily) onFontFamilySelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onFontFamilySelected,
      itemBuilder: (context) => [
        ...(fontFamilies
            .map((e) => PopupMenuItem<String>(
                  value: e,
                  child: Text(e),
                ))
            .toList())
      ],
      child: Row(children: [
        Text('A',
            style: GoogleFonts.theNautigal()
                .copyWith(color: Colors.white, fontSize: 20)),
        const Icon(Icons.keyboard_arrow_up_outlined)
      ]),
    );
  }
}

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key, required this.onColorSelected});

  final void Function(Color color) onColorSelected;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color currentColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Color>(
      tooltip: 'Select Color',
      offset: const Offset(0, -400),
      shadowColor: Colors.white,
      color: const Color(0xff171717),
      elevation: 5,
      initialValue: currentColor,
      itemBuilder: (context) => [
        PopupMenuItem<Color>(
            child: ColorPicker(
          showColorName: true,
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.wheel: true,
            ColorPickerType.accent: false,
            ColorPickerType.both: false,
            ColorPickerType.custom: true,
            ColorPickerType.primary: false,
          },
          onColorChanged: (value) {
            setState(() {
              currentColor = value;
            });
            widget.onColorSelected(value);
          },
          color: Colors.teal,
        )),
      ],
      child: Row(children: [
        Container(
          width: 20,
          height: 20,
          decoration:
              BoxDecoration(color: currentColor, shape: BoxShape.circle),
        ),
        const Icon(Icons.keyboard_arrow_up_outlined)
      ]),
    );
  }
}

class FontSizeSelector extends StatefulWidget {
  const FontSizeSelector({
    super.key,
    required this.onSizeSelected,
  });

  final void Function(double size) onSizeSelected;

  @override
  State<FontSizeSelector> createState() => _FontSizeSelectorState();
}

class _FontSizeSelectorState extends State<FontSizeSelector> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
        tooltip: 'Text Size',
        offset: const Offset(0, -250),
        shadowColor: Colors.white,
        color: const Color(0xff171717),
        elevation: 5,
        onSelected: widget.onSizeSelected,
        itemBuilder: (BuildContext context) => [
              PopupMenuItem<double>(
                value: double.tryParse(_controller.text) ?? 32.0,
                child: SizedBox(
                  width: 130,
                  child: TextField(
                    onChanged: (value) {
                      widget.onSizeSelected(double.tryParse(value) ?? 32.0);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '        32Px',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                    ),
                    controller: _controller,
                  ),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<double>(
                value: 23.0,
                child: Center(
                    child:
                        Text('Small', style: TextStyle(color: Colors.white))),
              ),
              const PopupMenuItem<double>(
                value: 32.0,
                child: Center(
                  child: Text(
                    'Medium',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const PopupMenuItem<double>(
                value: 63.0,
                child: Center(
                    child:
                        Text('Large', style: TextStyle(color: Colors.white))),
              ),
            ],
        child: const Row(
          children: [
            Icon(Icons.text_fields_outlined),
            Icon(Icons.keyboard_arrow_up_outlined)
          ],
        ));
  }
}
