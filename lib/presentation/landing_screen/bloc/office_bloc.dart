import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:office_staff_management/data/dto/office.dart';
import 'package:office_staff_management/data/dto/staff.dart';
import 'package:office_staff_management/domain/app_repository.dart';
import 'package:office_staff_management/presentation/utils/base_strings.dart';

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
          office.noOfStaff = staffData.where((test) {
            return test.officeId == office.id;
          }).length;
        }
        data.sort((a, b) => a.officeName!.compareTo(b.officeName!));
        emit(OfficeSuccess(list: data));
      } catch (e) {
        emit(OfficeFailure(message: "${BaseStrings.anErrorOccurred} $e"));
      }
    });
  }
}
