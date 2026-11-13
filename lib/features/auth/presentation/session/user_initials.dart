import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:material_ui/material_ui.dart';

extension UserInitials on UserVO {
  /// The first letter of the first name and, if there is one, of the last
  /// name, for the avatar. `characters` keeps a Myanmar letter and its
  /// marks together.
  String get initials => [firstName, ?lastName]
      .where((part) => part.trim().isNotEmpty)
      .map((part) => part.trim().characters.first.toUpperCase())
      .join();
}
