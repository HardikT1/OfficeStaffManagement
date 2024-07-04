import 'package:hive_flutter/hive_flutter.dart';

part 'office.g.dart';

@HiveType(typeId: 0)
class Office extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? companyName;

  @HiveField(2)
  int? noOfEmployee;

  @HiveField(3)
  final String? companyNumber;

  @HiveField(4)
  final String? companyEmail;

  @HiveField(5)
  final int? companyCapacity;

  @HiveField(6)
  final String? companyAddress;

  @HiveField(7)
  final int? companyCardColor;

  Office({
    required this.id,
    required this.companyName,
    required this.noOfEmployee,
    required this.companyNumber,
    required this.companyEmail,
    required this.companyCapacity,
    required this.companyAddress,
    required this.companyCardColor,
  });
}
