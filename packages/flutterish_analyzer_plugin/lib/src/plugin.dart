import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as proto;
import 'package:analyzer/file_system/file_system.dart';

class FlutterishAnalyzerPlugin extends ServerPlugin {
  FlutterishAnalyzerPlugin(ResourceProvider resourceProvider) : super(resourceProvider);

  @override
  List<String> get fileGlobsToAnalyze => const ['*.dart'];

  @override
  String get name => 'flutterish_analyzer_plugin';

  @override
  String get version => '0.0.1';

  @override
  bool isForContext(proto.ContextRoot contextRoot) {
    return true;
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    // Basic implementation for analysis
  }
}
