import 'package:hive_flutter/hive_flutter.dart';
import 'package:office_staff_management/data/dto/office.dart';
import 'package:office_staff_management/data/dto/staff.dart';
import 'package:office_staff_management/domain/app_repository.dart';
import 'package:office_staff_management/presentation/utils/base_strings.dart';

class AppRepositoryImpl extends AppRepository {
  final _officeBox = Hive.box<Office>(BaseStrings.officeBox);

  @override
  List<Office> getOffices() {
    final cachedList = _officeBox.values.toList();
    if (cachedList.isNotEmpty == true) return cachedList;
    return List<Office>.empty();
  }

  @override
  void putOffice(Office office) {
    _officeBox.put(office.id, office);
  }

  @override
  Future<void> deleteOffice(Office office) {
    return office.delete();
  }

  final _staffBox = Hive.box<Staff>(BaseStrings.staffBox);

  @override
  List<Staff> getStaffList() {
    final cachedList = _staffBox.values.toList();
    if (cachedList.isNotEmpty == true) {
      return cachedList;
    }
    return List<Staff>.empty();
  }

  @override
  void addStaff(Staff staff) {
    _staffBox.put(staff.id, staff);
  }

  @override
  Future<void> deleteStaff(Staff staff) {
    return staff.delete();
  }
}
