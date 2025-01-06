// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:collection';
import 'dart:io';

import 'package:csv/csv.dart';
import 'queue.dart';

final class Queues with ListMixin<Queue> {
  Queues.fromCsvPath(String path)
  : this._fromCsvFile(File(path));
  
  Queues._fromCsvFile(File file)
  : this._fromCsvLines(file.readAsLinesSync());

  Queues._fromCsvLines(List<String> lines)
  : this._fromList(
    lines
      .map((e) => _converter.convert(e).first)
      .toList()
      .sublist(1)
  );

  Queues._fromList(List<List> list)
  : _internal = list.map((e) => Queue.fromList(e)).toList();

  final List<Queue> _internal;
  
  static const _converter = CsvToListConverter();

  @override
  int get length => _internal.length;

  @override
  set length(int newLength) => _internal.length = newLength;

  @override
  Queue operator [](int index) => _internal[index];

  @override
  void operator []=(int index, Queue value) => _internal[index] = value;
}
