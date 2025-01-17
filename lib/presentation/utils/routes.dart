import 'package:flutter/cupertino.dart';
import 'package:office_staff_management/presentation/add_office/view/add_office.dart';
import 'package:office_staff_management/presentation/landing_screen/landing_screen.dart';
import 'package:office_staff_management/presentation/office_details/office_details_screen.dart';

class RoutesPages {
  static Map<String, Widget Function(BuildContext context)> pages() => {
        Routes.landingScreen: (context) => const LandingScreen(),
        Routes.officeDetailsScreen: (context) => const OfficeDetailsScreen(),
        Routes.addOfficeScreen: (context) => const AddOfficeScreen(),
        Routes.editOfficeScreen: (context) => const AddOfficeScreen(isEdit: true)
      };
}

abstract class Routes {
  static const landingScreen = '/';
  static const officeDetailsScreen = 'office_details_screen';
  static const addOfficeScreen = 'add_office_screen';
  static const editOfficeScreen = 'edit_office_screen';
}
