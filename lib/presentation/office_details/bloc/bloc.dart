import 'package:bloc/bloc.dart';
import 'package:office_staff_management/data/dto/staff.dart';
import 'package:office_staff_management/domain/app_repository.dart';

import '../../add_office/bloc/state.dart';
import '../../utils/base_strings.dart';
import 'event.dart';
import 'state.dart';

class PutStaffBloc extends Bloc<OfficeDetailEvent, StaffState> {
  final AppRepository staffRepository;

  PutStaffBloc(this.staffRepository) : super(StaffInitial()) {
    on<GetStaffsEvent>((event, emit) async {
      emit(StaffLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        List<Staff> data = staffRepository.getStaffList();
        data.sort((a, b) => a.staffFirstName!.compareTo(b.staffFirstName!));
        emit(StaffSuccess(list: data));
      } catch (e) {
        emit(StaffFailure(message: "${BaseStrings.anErrorOccurred} $e"));
      }
    });

    on<PutStaffEvent>((event, emit) async {
      staffRepository.addStaff(event.staffDto);
      emit(OfficeDetailState(selectedIndex: event.staffDto));
    });

    on<DeleteStaffEvent>((event, emit) async {
      staffRepository.deleteStaff(event.staffDto);
      emit(OfficeDetailState(selectedIndex: event.staffDto));
    });

    on<SearchStaffEvent>((event, emit) async {
      List<Staff> data = staffRepository.getStaffList();
      data.sort((a, b) => a.staffFirstName!.compareTo(b.staffFirstName!));
      emit(StaffSuccess(
          list: data
              .where((test) =>
                  test.staffFirstName!.toLowerCase().contains(event.searchText) ||
                  test.staffLastName!.toLowerCase().contains(event.searchText))
              .toList()));
    });
  }
}
