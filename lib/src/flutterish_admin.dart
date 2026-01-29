import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/interfaces/data_provider.dart';
import 'core/interfaces/auth_provider.dart';
import 'core/interfaces/schema_provider.dart';
import 'core/state/core_providers.dart';
import 'core/engine/default_components.dart';
import 'ui/layout/admin_scaffold.dart';

/// The main entry point for a Flutterish Admin application.
///
/// It initializes the providers and loads the configuration.
class FlutterishAdmin extends StatelessWidget {
  final DataProvider dataProvider;
  final AuthProvider authProvider;
  final SchemaProvider schemaProvider;
  final String title;

  FlutterishAdmin({
    super.key,
    required this.dataProvider,
    required this.authProvider,
    required this.schemaProvider,
    this.title = 'Admin',
  }) {
    registerDefaultComponents();
  }

  @override
  Widget build(BuildContext context) {
    // We wrap everything in a ProviderScope to inject our dependencies.
    // Note: If the user already wraps the app in a ProviderScope, this creates a nested scope,
    // which is valid but we should be aware. For a library, this is usually safest.
    return ProviderScope(
      overrides: [
        dataProviderProvider.overrideWithValue(dataProvider),
        authProviderProvider.overrideWithValue(authProvider),
        schemaProviderProvider.overrideWithValue(schemaProvider),
      ],
      child: const _AdminApp(),
    );
  }
}

class _AdminApp extends ConsumerWidget {
  const _AdminApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schemaAsync = ref.watch(appSchemaProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: schemaAsync.when(
        data: (schema) => AdminScaffold(config: schema),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, stack) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text('Failed to load admin configuration', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(err.toString(), style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
