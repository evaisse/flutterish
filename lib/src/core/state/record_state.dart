import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_state.g.dart';

/// Provides the current record data (e.g. inside a Datagrid row).
@riverpod
Map<String, dynamic> record(RecordRef ref) {
  throw UnimplementedError('No record context found');
}
