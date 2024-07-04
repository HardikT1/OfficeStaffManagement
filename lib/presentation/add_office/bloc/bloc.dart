import 'package:bloc/bloc.dart';
import 'package:office_staff_management/domain/app_repository.dart';

import 'event.dart';
import 'state.dart';

class AddOfficeBloc extends Bloc<AddOfficeEvent, AddOfficeState> {
  AddOfficeBloc() : super(AddOfficeState.initial()) {
    on<ColorChooseEvent>((event, emit) {
      emit(
          state.copyWith(selectedIndex: event.newIndex, avtarIndex: event.newAvtarIndex));
    });
  }
}

class PutOfficeBloc extends Bloc<AddOfficeEvent, PutOfficeState> {
  final AppRepository officeRepository;

  PutOfficeBloc(this.officeRepository) : super(PutOfficeState.initial()) {
    on<PutOfficeEvent>((event, emit) {
      officeRepository.putOffice(event.officeDto);
      emit(state.copyWith(selectedIndex: event.officeDto));
    });

    on<DeleteOfficeEvent>((event, emit) async {
      await officeRepository.deleteOffice(event.officeDto);
      emit(state.copyWith(selectedIndex: event.officeDto));
    });
  }
}
