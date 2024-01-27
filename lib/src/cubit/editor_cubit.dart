import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/text_model.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  EditorCubit() : super(const EditorState(status: Status.initial, data: []));

  // list of text that the Ui is consuming
  final List<TextModel> data = [];

  // with [selecetText] we keep truck of the last selected Text
  // if it equals to [null] then nothing is selectd
  int? selectedText;
  Color currentColor = const Color(0xffffffff);
  double currentFontSize = 32;
  String currentFontFamily = 'Slabo 27px';

  // A list of past states that we can roll back to
  final List<EditorState> _undos = [];

  // A list of states that we can redo.
  final List<EditorState> _redos = [];

  void undo() {
    // if the _undos is empty we can not go back
    if (_undos.isEmpty) return;

    // remove the last state
    final stte = _undos.removeLast();
    // add the removed state to the redos so we can roll back to it
    _redos.add(stte);
    // emit the last state in the undoes (the state we want to roll back to)

    final EditorState lastState = _undos.last;
    emit(EditorState(status: lastState.status, data: lastState.data));
  }

  void redo() {
    if (_redos.isEmpty) return;

    final EditorState stte = _redos.removeLast();
    _undos.add(state);
    emit(EditorState(status: stte.status, data: stte.data));
  }

  /// Adds a new text item to the data list.
  ///
  /// Then, it creates a new Text item with default parameters and adds it to the data list.
  /// The new Text item is initially selected.
  /// Finally, it emits a new state with the updated data list and a status indicating that a text item has been added.
  void addText() {
    // Create a new Text item with default parameters
    TextModel text = TextModel(
        fontFamily: currentFontFamily,
        fontSize: currentFontSize,
        color: currentColor);

    // Add the new Text item to the data list
    data.add(text);
    // Select the new Text item
    _toggleSelection(text.id);
    List<TextModel> updatedData = List.from(data);

    emit(EditorState(status: Status.textAdded, data: updatedData));
    _undos.add(state);
    _redos.clear();
  }

  /// Selects a text item from the data list.
  ///
  /// The function takes an `id` parameter which is the ID of the text item to select.
  /// Then, it selects the text item by calling the `_toggleSelection` function.
  /// Finally, it emits a new state with the updated data list and a status indicating that a text item has been selected.
  void selectText({required int id}) {
    // Select the text item with the given ID
    _toggleSelection(id);

    List<TextModel> updatedData = List.from(data);
    emit(EditorState(data: updatedData, status: Status.textSelected));
    _undos.add(state);
    _redos.clear();
  }

  /// Changes the font size of the selected text.
  ///
  /// The function takes a `fontSize` parameter which is the new font size to apply.
  /// If there is a selected text (i.e., `selectedText` is not null), it updates the font size of the selected text
  /// and emits a new state with the updated data list and a status indicating that the font size has been changed.
  void changeTextSize({required double fontSize}) {
    // update the current font sie
    currentFontSize = fontSize;

    // Check if there is a selected text
    if (selectedText != null) {
      // Update the font size of the selected text
      data[selectedText!].fontSize = fontSize;

      List<TextModel> updatedData = List.from(data);
      emit(EditorState(data: updatedData, status: Status.textFontSizeChanged));
      _undos.add(state);
      _redos.clear();
    }
  }

  void changeColor({required Color color}) {
    // Update the current color
    currentColor = color;
    // Check if there is a selected text
    if (selectedText != null) {
      // Update the color of the selected text
      data[selectedText!].color = color;

      // Create a new list from the existing data for immutability
      List<TextModel> updatedData = List.from(data);

      emit(EditorState(data: updatedData, status: Status.colorChanged));
      _undos.add(state);
      _redos.clear();
    }
  }

  void changeFontFamily({required String fontFamily}) {
    // Update the current color
    currentFontFamily = fontFamily;
    // Check if there is a selected text
    if (selectedText != null) {
      // Update the color of the selected text
      data[selectedText!].fontFamily = fontFamily;

      // Create a new list from the existing data for immutability
      List<TextModel> updatedData = List.from(data);

      emit(EditorState(data: updatedData, status: Status.fontFamilyChanged));
      _undos.add(state);
      _redos.clear();
    }
  }

  /// Toggles the selection of a text item in the data list.
  ///
  /// If a text item is already selected, it gets deselected.
  /// If the selected item is different from the previously selected one,
  /// it gets selected.
  void _toggleSelection(int id) {
    if (selectedText == id) {
      // If the selected text is already the current one, deselect it.
      data[id].isSelected = false;
      selectedText = null;
    } else {
      // If there was another text selected, deselect it.
      if (selectedText != null) {
        data[selectedText!].isSelected = false;
      }

      // Select the new text.
      data[id].isSelected = true;
      selectedText = id;
    }
  }
}
