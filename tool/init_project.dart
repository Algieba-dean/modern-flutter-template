import 'dart:io';

const String _templatePackageName = 'enterprise_flutter_template';
const String _templateDisplayName = 'Enterprise Flutter Template';
const String _templateOrg = 'com.example.enterprise';
const String _templateAndroidApplicationId =
    'com.example.enterprise.enterprise_flutter_template';
const String _templateAppleBundleId =
    'com.example.enterprise.enterpriseFlutterTemplate';
const String _templateGitHubOwner = 'your-org';
const String _templateGitHubRepo = 'enterprise-flutter-template';

const Set<String> _ignoredDirectories = <String>{
  '.dart_tool',
  '.git',
  '.idea',
  '.symlinks',
  'build',
  'DerivedData',
  'Pods',
};

const Set<String> _ignoredFiles = <String>{
  'pubspec.lock',
  'tool/init_project.dart',
  'android/local.properties',
};

Future<void> main() async {
  stdout.writeln('Initialize this Flutter repository from the template.');

  final String packageName = _ask(
    'Dart package name',
    _templatePackageName,
    validator: _isValidDartPackageName,
  );
  final String displayName = _ask('App display name', 'My Enterprise App');
  final String org = _ask(
    'Reverse-DNS organization id',
    'com.example',
    validator: _isValidReverseDomain,
  );
  final String androidApplicationId = _ask(
    'Android applicationId',
    '$org.$packageName',
    validator: _isValidReverseDomain,
  );
  final String appleBundleId = _ask(
    'iOS/macOS bundle id',
    _toAppleBundleId(androidApplicationId),
    validator: _isValidReverseDomain,
  );
  final String githubOwner = _ask('GitHub owner or organization', 'your-org');
  final String githubRepo = _ask(
    'GitHub repository name',
    packageName.replaceAll('_', '-'),
  );

  final Map<String, String> replacements = <String, String>{
    _templatePackageName: packageName,
    _templateDisplayName: displayName,
    _templateOrg: org,
    _templateAndroidApplicationId: androidApplicationId,
    _templateAppleBundleId: appleBundleId,
    _templateGitHubOwner: githubOwner,
    _templateGitHubRepo: githubRepo,
  };

  await _replaceInRepository(replacements);
  await _moveAndroidMainActivity(androidApplicationId);

  stdout.writeln();
  stdout.writeln('Initialization complete.');
  stdout.writeln('Next steps:');
  stdout.writeln('1. flutter pub get');
  stdout.writeln('2. dart format .');
  stdout.writeln('3. flutter analyze');
  stdout.writeln('4. flutter test');
  stdout.writeln('5. git add . && git commit -m "chore: initialize project"');
}

String _ask(
  String label,
  String defaultValue, {
  bool Function(String value)? validator,
}) {
  while (true) {
    stdout.write('$label [$defaultValue]: ');
    final String value = stdin.readLineSync()?.trim() ?? '';
    final String resolvedValue = value.isEmpty ? defaultValue : value;

    if (validator == null || validator(resolvedValue)) {
      return resolvedValue;
    }

    stdout.writeln('Invalid value: $resolvedValue');
  }
}

Future<void> _replaceInRepository(Map<String, String> replacements) async {
  final Directory root = Directory.current;
  await for (final FileSystemEntity entity in root.list(recursive: true)) {
    if (entity is! File) {
      continue;
    }

    final String relativePath = entity.path.replaceFirst('${root.path}/', '');
    if (_shouldSkip(relativePath)) {
      continue;
    }

    final List<int> bytes = await entity.readAsBytes();
    final String? content = _tryDecodeUtf8(bytes);
    if (content == null) {
      continue;
    }

    String updatedContent = content;
    for (final MapEntry<String, String> entry in replacements.entries) {
      updatedContent = updatedContent.replaceAll(entry.key, entry.value);
    }

    if (updatedContent != content) {
      await entity.writeAsString(updatedContent);
      stdout.writeln('Updated $relativePath');
    }
  }
}

Future<void> _moveAndroidMainActivity(String applicationId) async {
  final Directory source = Directory(
    'android/app/src/main/kotlin/com/example/enterprise/enterprise_flutter_template',
  );
  if (!source.existsSync()) {
    return;
  }

  final Directory destination = Directory(
    'android/app/src/main/kotlin/${applicationId.replaceAll('.', '/')}',
  );
  if (!destination.existsSync()) {
    await destination.create(recursive: true);
  }

  for (final FileSystemEntity entity in source.listSync()) {
    if (entity is File) {
      await entity.rename(
        '${destination.path}/${entity.uri.pathSegments.last}',
      );
    }
  }

  await _deleteEmptyParents(source, Directory('android/app/src/main/kotlin'));
  stdout.writeln('Moved Android MainActivity to ${destination.path}');
}

Future<void> _deleteEmptyParents(Directory directory, Directory stopAt) async {
  Directory current = directory;
  while (current.path != stopAt.path) {
    if (!current.existsSync() || current.listSync().isNotEmpty) {
      break;
    }

    final Directory parent = current.parent;
    await current.delete();
    current = parent;
  }
}

bool _shouldSkip(String relativePath) {
  if (_ignoredFiles.contains(relativePath)) {
    return true;
  }

  return relativePath
      .split(Platform.pathSeparator)
      .any(_ignoredDirectories.contains);
}

String? _tryDecodeUtf8(List<int> bytes) {
  try {
    return systemEncoding.decode(bytes);
  } on FormatException {
    return null;
  }
}

bool _isValidDartPackageName(String value) =>
    RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(value) &&
    !value.contains('__') &&
    !value.endsWith('_');

bool _isValidReverseDomain(String value) =>
    RegExp(r'^[a-zA-Z][a-zA-Z0-9]*(\.[a-zA-Z][a-zA-Z0-9_]*)+$').hasMatch(value);

String _toAppleBundleId(String androidApplicationId) {
  final List<String> parts = androidApplicationId.split('.');
  if (parts.isEmpty) {
    return androidApplicationId;
  }

  final String appPart = parts.removeLast();
  final String camelAppPart = appPart
      .split('_')
      .where((String part) => part.isNotEmpty)
      .map((String part) => part[0].toUpperCase() + part.substring(1))
      .join();

  return <String>[...parts, camelAppPart].join('.');
}
