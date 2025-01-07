// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:yaml/yaml.dart';

final class Config {
  Config.fromYamlPath(String path)
  : this._fromYamlFile(File(path));

  Config._fromYamlFile(File file)
  : this._fromYamlString(file.readAsStringSync());

  Config._fromYamlMap(YamlMap map)
  : youtubeDl = map['youtube_dl'],
    repository = (map['repository'] as List<dynamic>)
      .map((e) => e as String)
      .toList();

  Config._fromYamlString(String string)
  : this._fromYamlMap(loadYaml(string));

  final String youtubeDl;
  final List<String> repository;

  Map<String, Object> toMap() => {
    'youtube_dl': youtubeDl,
    'repository': repository,
  };
}
