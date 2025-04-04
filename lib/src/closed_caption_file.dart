// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart' show immutable, objectRuntimeType;

import 'sub_rip.dart';

export 'sub_rip.dart' show SubRipCaptionFile;

/// A representation of a single caption.
///
/// A typical closed captioning file will include several [Caption]s, each
/// linked to a start and end time.
@immutable
class Caption {
  /// A no caption object. This is a caption with [start] and [end] durations of zero,
  /// and an empty [text] string.
  static const Caption none = Caption(
    number: 0,
    start: Duration.zero,
    end: Duration.zero,
    text: '',
  );

  /// The number that this caption was assigned.
  final int number;

  /// When in the given video should this [Caption] begin displaying.
  final Duration start;

  /// When in the given video should this [Caption] be dismissed.
  final Duration end;

  /// The actual text that should appear on screen to be read between [start]
  /// and [end].
  final String text;

  /// Creates a new [Caption] object.
  ///
  /// This is not recommended for direct use unless you are writing a parser for
  /// a new closed captioning file type.
  const Caption({
    required this.number,
    required this.start,
    required this.end,
    required this.text,
  });

  @override
  int get hashCode => Object.hash(
        number,
        start,
        end,
        text,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Caption &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          start == other.start &&
          end == other.end &&
          text == other.text;

  @override
  String toString() {
    return '${objectRuntimeType(this, 'Caption')}('
        'number: $number, '
        'start: $start, '
        'end: $end, '
        'text: $text)';
  }
}

/// A structured representation of a parsed closed caption file.
///
/// A closed caption file includes a list of captions, each with a start and end
/// time for when the given closed caption should be displayed.
///
/// The [captions] are a list of all captions in a file, in the order that they
/// appeared in the file.
///
/// See:
/// * [SubRipCaptionFile].
/// * [WebVTTCaptionFile].
abstract class ClosedCaptionFile {
  /// The full list of captions from a given file.
  ///
  /// The [captions] will be in the order that they appear in the given file.
  List<Caption> get captions;
}
