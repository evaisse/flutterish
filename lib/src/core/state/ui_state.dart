import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ui_state.g.dart';

@riverpod
class SelectedResourceIndex extends _$SelectedResourceIndex {
  @override
  int build() => 0;

  void set(int index) => state = index;
}
