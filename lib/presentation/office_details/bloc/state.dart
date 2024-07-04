import 'package:office_staff_management/data/dto/staff.dart';

import '../../add_office/bloc/state.dart';

class OfficeDetailState extends StaffState {
  final Staff selectedIndex;

  OfficeDetailState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];

  OfficeDetailState copyWith({required final Staff selectedIndex}) {
    return OfficeDetailState(selectedIndex: selectedIndex);
  }
}

final class StaffInitial extends StaffState {
  StaffInitial();

  @override
  List<Object> get props => [];
}

final class StaffSuccess extends StaffState {
  final List<Staff> list;

  StaffSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

final class StaffLoading extends StaffState {
  StaffLoading();

  @override
  List<Object> get props => [];
}

final class StaffFailure extends StaffState {
  final String message;

  StaffFailure({required this.message});

  @override
  List<Object> get props => [message];
}
