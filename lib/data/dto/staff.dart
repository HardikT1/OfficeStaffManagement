import 'package:hive_flutter/hive_flutter.dart';

part 'staff.g.dart';

@HiveType(typeId: 1)
class Staff extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? officeId;

  @HiveField(2)
  final String? staffFirstName;

  @HiveField(3)
  final String? staffLastName;

  @HiveField(4)
  final int? staffAvatarIndex;

  Staff({
    required this.id,
    required this.officeId,
    required this.staffFirstName,
    required this.staffLastName,
    required this.staffAvatarIndex,
  });
}
