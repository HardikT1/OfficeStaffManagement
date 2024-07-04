import 'package:equatable/equatable.dart';
import 'package:office_staff_management/data/dto/office.dart';

abstract class AddOfficeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitEvent extends AddOfficeEvent {}

class ChooserEvent extends AddOfficeEvent {
  final int newColorIndex;
  final int newAvtarIndex;

  ChooserEvent(this.newColorIndex, this.newAvtarIndex);

  @override
  List<Object> get props => [newColorIndex, newAvtarIndex];
}

class PutOfficeEvent extends AddOfficeEvent {
  final Office officeDto;

  PutOfficeEvent(this.officeDto);

  @override
  List<Object> get props => [officeDto];
}

class DeleteOfficeEvent extends AddOfficeEvent {
  final Office officeDto;

  DeleteOfficeEvent(this.officeDto);

  @override
  List<Object> get props => [officeDto];
}

class UpdateOfficeEvent extends AddOfficeEvent {
  final Office officeDto;

  UpdateOfficeEvent(this.officeDto);

  @override
  List<Object> get props => [officeDto];
}
