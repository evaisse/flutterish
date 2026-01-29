import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../interfaces/data_provider.dart';
import '../interfaces/auth_provider.dart';
import '../interfaces/schema_provider.dart';
import '../schema/schema_models.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
DataProvider dataProvider(DataProviderRef ref) {
  throw UnimplementedError('dataProvider must be overridden');
}

@Riverpod(keepAlive: true)
AuthProvider authProvider(AuthProviderRef ref) {
  throw UnimplementedError('authProvider must be overridden');
}

@Riverpod(keepAlive: true)
SchemaProvider schemaProvider(SchemaProviderRef ref) {
  throw UnimplementedError('schemaProvider must be overridden');
}

@riverpod
Future<AdminConfig> appSchema(AppSchemaRef ref) async {
  final schemaLoader = ref.watch(schemaProviderProvider);
  final json = await schemaLoader.getSchema();
  return AdminConfig.fromJson(json);
}
