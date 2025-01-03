// Copyright 2024. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

final class Queue {
  Queue.fromList(List<dynamic> list)
  : id = list[0] as int,
    uri = list[1] as String;

  final int id;
  final String uri;

  Map<String, dynamic> toMap() => {
    'id': id,
    'uri': uri,
  };
}
