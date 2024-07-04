import 'package:hive_flutter/hive_flutter.dart';

part 'office.g.dart';

@HiveType(typeId: 0)
class Office extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? officeName;
  @HiveField(2)
  int? noOfStaff;
  @HiveField(3)
  final String? officeNumber;
  @HiveField(4)
  final String? officeEmail;
  @HiveField(5)
  final int? officeCapacity;
  @HiveField(6)
  final String? officeAddress;

  @HiveField(7)
  int? officeCardColor;

  Office({
    required this.id,
    required this.officeName,
    required this.noOfStaff,
    required this.officeNumber,
    required this.officeEmail,
    required this.officeCapacity,
    required this.officeAddress,
    required this.officeCardColor,
  });
}
