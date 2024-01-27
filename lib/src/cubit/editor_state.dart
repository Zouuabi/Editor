part of 'editor_cubit.dart';

enum Status { initial, textAdded, textFontSizeChanged, textSelected }

class EditorState extends Equatable {
  final Status status;
  final List<TextModel> data;

  const EditorState({required this.status, required this.data});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EditorState && other.status == status && other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;

  @override
  List<Object?> get props => [data, status];
}
