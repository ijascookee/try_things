import 'package:yaml/yaml.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class AssetBuilderGenerator extends GeneratorForAnnotation<AssetsAnnotation> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    // Read pubspec.yaml
    final assetId = AssetId(buildStep.inputId.package, 'pubspec.yaml');
    final content = await buildStep.readAsString(assetId);
    final doc = loadYaml(content);

    // Extract asset directories
    List<String> assetDirs = [];
    if (doc.containsKey('flutter') && doc['flutter'].containsKey('assets')) {
      for (var asset in doc['flutter']['assets']) {
        if (asset is String && asset.endsWith('/')) {
          assetDirs.add(asset.substring(0, asset.length - 1));
        }
      }
    }

    StringBuffer buffer = StringBuffer();

    for (var dir in assetDirs) {
      final parts = dir.split('/');
      final dirName = parts.last; // Get the last directory name

      String className = 'App${toSingularCamelCase(dirName)}';

      buffer.writeln('class $className {');
      // You can further process files in each directory here if needed.
      buffer.writeln('}');
      buffer.writeln();
    }

    return buffer.toString();
  }

  String toSingularCamelCase(String dirName) {
    if (dirName.endsWith('s')) {
      dirName = dirName.substring(0, dirName.length - 1);
    }
    return dirName[0].toUpperCase() + dirName.substring(1);
  }
}

class AssetsAnnotation {
  const AssetsAnnotation();
}
