import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resource_state.g.dart';

/// Provides the name of the resource currently being viewed/edited.
@riverpod
String currentResource(CurrentResourceRef ref) {
  throw UnimplementedError('No resource context found');
}
