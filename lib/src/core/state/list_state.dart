import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../interfaces/data_provider.dart';
import 'core_providers.dart';

part 'list_state.g.dart';

@riverpod
Future<GetListResult> listData(ListDataRef ref, String resource) {
  final dataProvider = ref.watch(dataProviderProvider);
  return dataProvider.getList(resource);
}

// Provider to pass the result down to children (Datagrid)
@riverpod
GetListResult listContextResult(ListContextResultRef ref) {
  throw UnimplementedError('No list context available');
}
