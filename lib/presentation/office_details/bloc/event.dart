import 'package:equatable/equatable.dart';
import 'package:office_staff_management/data/dto/staff.dart';

abstract class OfficeDetailEvent extends Equatable {}

class InitEvent extends OfficeDetailEvent {
  @override
  List<Object?> get props => [];
}

class ColorChooseEvent extends OfficeDetailEvent {
  final int newIndex;

  ColorChooseEvent(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}

class GetStaffsEvent extends OfficeDetailEvent {
  GetStaffsEvent();

  @override
  List<Object> get props => [];
}

class PutStaffEvent extends OfficeDetailEvent {
  final Staff staffDto;

  PutStaffEvent(this.staffDto);

  @override
  List<Object> get props => [staffDto];
}

class DeleteStaffEvent extends OfficeDetailEvent {
  final Staff staffDto;

  DeleteStaffEvent(this.staffDto);

  @override
  List<Object> get props => [staffDto];
}

class UpdateStaffEvent extends OfficeDetailEvent {
  final Staff staffDto;

  UpdateStaffEvent(this.staffDto);

  @override
  List<Object> get props => [staffDto];
}

class SearchStaffEvent extends OfficeDetailEvent {
  final String searchText;

  SearchStaffEvent(this.searchText);

  @override
  List<Object> get props => [searchText];
}
