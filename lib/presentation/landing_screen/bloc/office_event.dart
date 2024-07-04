part of 'office_bloc.dart';

@immutable
sealed class OfficeEvent extends Equatable {}

class GetAllOffices extends OfficeEvent {
  @override
  List<Object?> get props => [];
}

class GetAllStaff extends OfficeEvent {
  @override
  List<Object?> get props => [];
}
