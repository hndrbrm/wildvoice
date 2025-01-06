// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:wildvoice/config.dart';
import 'package:wildvoice/queues.dart';

Future<void> main(List<String> arguments) async {
  final config = Config.fromYamlPath('config.yaml');
  final queues = Queues.fromCsvPath(config.repository);
  for (final queue in queues) {
    final arguments = <String>[
      if (queue.uri.toString().toLowerCase().contains('youtube.com')) ...[
        '-f',
        'bestaudio[ext=m4a]',
      ] else ...[
        '--extract-audio',
        '--audio-format',
        'mp3',
        '--audio-quality',
        '0',
      ],
      '-o',
      '${queue.id}.%(ext)s',
      '${queue.uri}',
    ];

    print('---------- ${queue.id}');
    print('${config.youtubeDl} ${arguments.join(' ')}');
    final process = await Process.start(config.youtubeDl, arguments);
    const encoding = SystemEncoding();

    process.stdout
      .transform(encoding.decoder)
      .listen((data) => stdout.write(data));

    process.stderr
      .transform(encoding.decoder)
      .listen((data) => stderr.write(data));

    final exitCode = await process.exitCode;
    print('Process exited with code: $exitCode');
  }
}
