import 'dart:io';

Future<void> main(List<String> arguments) async {
  final minimum = _readMinimum(arguments);
  final coverageFile = File('coverage/lcov.info');

  if (!coverageFile.existsSync()) {
    stderr.writeln('Coverage file not found: coverage/lcov.info');
    stderr.writeln('Run `make test-coverage` before checking coverage.');
    exitCode = 1;
    return;
  }

  final lines = await coverageFile.readAsLines();
  var foundLines = 0;
  var hitLines = 0;

  for (final line in lines) {
    if (line.startsWith('LF:')) {
      foundLines += int.parse(line.substring(3));
    } else if (line.startsWith('LH:')) {
      hitLines += int.parse(line.substring(3));
    }
  }

  if (foundLines == 0) {
    stderr.writeln('Coverage file did not contain any executable lines.');
    exitCode = 1;
    return;
  }

  final coverage = hitLines * 100 / foundLines;
  stdout.writeln(
    'Line coverage: ${coverage.toStringAsFixed(2)}% '
    '($hitLines/$foundLines), minimum: ${minimum.toStringAsFixed(2)}%',
  );

  if (coverage < minimum) {
    stderr.writeln('Coverage is below the required threshold.');
    exitCode = 1;
  }
}

double _readMinimum(List<String> arguments) {
  if (arguments.isEmpty) {
    return 80;
  }

  if (arguments.length != 1) {
    stderr.writeln('Usage: dart run tool/check_coverage.dart [minimum]');
    exit(64);
  }

  final minimum = double.tryParse(arguments.single);
  if (minimum == null || minimum < 0 || minimum > 100) {
    stderr.writeln('Coverage minimum must be a number between 0 and 100.');
    exit(64);
  }

  return minimum;
}
