import 'package:bloc/bloc.dart';
import 'package:office_staff_management/domain/app_repository.dart';

import 'event.dart';
import 'state.dart';

class AddOfficeBloc extends Bloc<AddOfficeEvent, AddStaffState> {
  AddOfficeBloc() : super(AddStaffState.initial()) {
    on<ChooserEvent>((event, emit) {
      emit(state.copyWith(
          selectedIndex: event.newColorIndex, avtarIndex: event.newAvtarIndex));
    });
  }
}

class PutOfficeBloc extends Bloc<AddOfficeEvent, PutStaffState> {
  final AppRepository officeRepository;

  PutOfficeBloc(this.officeRepository) : super(PutStaffState.initial()) {
    on<PutOfficeEvent>((event, emit) async {
      officeRepository.putOffice(event.officeDto);
      emit(state.copyWith(officeDto: event.officeDto));
    });

    on<DeleteOfficeEvent>((event, emit) async {
      officeRepository.deleteOffice(event.officeDto);
      emit(state.copyWith(officeDto: event.officeDto));
    });
  }
}
