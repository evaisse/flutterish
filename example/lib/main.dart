import 'package:flutter/material.dart';
import 'package:flutterish/flutterish.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterishAdmin(
      title: 'Demo Admin',
      dataProvider: MockDataProvider(),
      authProvider: MockAuthProvider(),
      schemaProvider: MockSchemaProvider(),
    );
  }
}

class MockDataProvider implements DataProvider {
  final _data = <String, List<Map<String, dynamic>>>{
    'posts': [
      {'id': '1', 'title': 'Hello World', 'author': 'John Doe'},
      {'id': '2', 'title': 'Flutter is awesome', 'author': 'Jane Smith'},
      {'id': '3', 'title': 'Server Driven UI', 'author': 'Bob'},
    ],
    'users': [
      {'id': '1', 'name': 'John Doe', 'email': 'john@example.com'},
      {'id': '2', 'name': 'Jane Smith', 'email': 'jane@example.com'},
    ]
  };

  @override
  Future<Map<String, dynamic>> create(String resource, Map<String, dynamic> data) async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String resource, String id) async {
    throw UnimplementedError();
  }

  @override
  Future<GetListResult> getList(String resource, {int page = 1, int perPage = 10, Map<String, dynamic>? filter, Map<String, dynamic>? sort}) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate latency
    final list = _data[resource] ?? [];
    return GetListResult(data: list, total: list.length);
  }

  @override
  Future<Map<String, dynamic>> getOne(String resource, String id) async {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> update(String resource, String id, Map<String, dynamic> data) async {
    throw UnimplementedError();
  }
}

class MockAuthProvider implements AuthProvider {
  @override
  Future<void> checkAuth() async {}

  @override
  Future<void> checkError(error) async {}

  @override
  Future<dynamic> getPermissions() async => {};

  @override
  Future<void> login(Map<String, dynamic> params) async {}

  @override
  Future<void> logout() async {}
}

class MockSchemaProvider implements SchemaProvider {
  @override
  Future<Map<String, dynamic>> getSchema() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return {
      "title": "Flutterish Demo",
      "layout": "Layout",
      "resources": [
        {
          "name": "posts",
          "list": {
            "type": "List",
            "props": {"title": "All Posts"},
            "children": [
              {
                "type": "Datagrid",
                "children": [
                  {"type": "TextField", "props": {"source": "id"}},
                  {"type": "TextField", "props": {"source": "title"}},
                  {"type": "TextField", "props": {"source": "author"}},
                ]
              }
            ]
          }
        },
        {
          "name": "users",
          "list": {
            "type": "List",
            "props": {"title": "Users Directory"},
            "children": [
              {
                "type": "Datagrid",
                "children": [
                  {"type": "TextField", "props": {"source": "id"}},
                  {"type": "TextField", "props": {"source": "name", "label": "Full Name"}},
                  {"type": "TextField", "props": {"source": "email"}},
                ]
              }
            ]
          }
        }
      ]
    };
  }
}
