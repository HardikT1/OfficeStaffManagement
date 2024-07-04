import 'package:office_staff_management/data/dto/office.dart';
import 'package:office_staff_management/data/dto/staff.dart';

abstract class AppRepository {
  List<Office> getOffices();

  void putOffice(Office office);

  void deleteOffice(Office office);

  List<Staff> getStaffList();

  void addStaff(Staff staff);

  void deleteStaff(Staff staff);
}
