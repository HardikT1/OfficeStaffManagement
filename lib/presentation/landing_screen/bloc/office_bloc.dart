import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:office_staff_management/data/dto/office.dart';
import 'package:office_staff_management/data/dto/staff.dart';
import 'package:office_staff_management/domain/app_repository.dart';

part 'office_event.dart';
part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  final AppRepository appRepository;

  OfficeBloc(this.appRepository) : super(OfficeInitial()) {
    on<GetAllOffices>((event, emit) async {
      emit(OfficeLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        List<Office> data = appRepository.getOffices();
        List<Staff> staffData = appRepository.getStaffList();
        for (var office in data) {
          office.noOfEmployee = staffData.where((test) {
            return test.officeId == office.id;
          }).length;
        }
        data.sort((a, b) => a.companyName!.compareTo(b.companyName!));
        emit(OfficeSuccess(list: data));
      } catch (e) {
        emit(OfficeFailure(message: "An error occurred: $e"));
        debugPrint("failure");
      }
    });
  }
}
