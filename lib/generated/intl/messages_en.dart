// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(clickCount) => "Nombre de clicks : ${clickCount}";

  static String m1(name) => "Nome du joueur : ${name}";

  static String m2(bestPlayerName, bestScore) =>
      "Le joueur ${bestPlayerName} détient le record, qui est : ${bestScore}";

  static String m3(score) =>
      "Score : ${Intl.plural(score, one: '1 point', other: '${score} points')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "click_count": m0,
        "enterYourNickname":
            MessageLookupByLibrary.simpleMessage("Enter your nickname"),
        "game_start_button":
            MessageLookupByLibrary.simpleMessage("Start to count"),
        "hallOfFame": MessageLookupByLibrary.simpleMessage("Hall of Fame"),
        "nomeDuJoueurGamename": m1,
        "point_record": m2,
        "score_pamescore_points": m3
      };
}
