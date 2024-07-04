import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:office_staff_management/data/app_repository_impl.dart';
import 'package:office_staff_management/data/dto/office.dart';
import 'package:office_staff_management/data/dto/staff.dart';
import 'package:office_staff_management/domain/app_repository.dart';
import 'package:office_staff_management/presentation/landing_screen/bloc/office_bloc.dart';
import 'package:office_staff_management/presentation/utils/base_strings.dart';
import 'package:office_staff_management/presentation/utils/routes.dart';

void main() async {
  /// ensure that app is initialized
  WidgetsFlutterBinding.ensureInitialized();

  /// Registering repositories
  GetIt.I.registerSingleton<AppRepository>(AppRepositoryImpl());

  /// Hive initialize
  await Hive.initFlutter();

  /// opening boxes
  await Hive.openBox<Office>(BaseStrings.officeBox);
  await Hive.openBox<Staff>(BaseStrings.staffBox);

  /// running the main app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          final bloc = OfficeBloc(GetIt.I<AppRepository>());
          return bloc..add(GetAllOffices());
        }),
      ],
      child: MaterialApp(
        routes: RoutesPages.pages(),
        initialRoute: Routes.landingScreen,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
