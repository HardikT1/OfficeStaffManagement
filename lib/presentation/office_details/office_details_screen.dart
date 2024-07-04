import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:office_staff_management/data/dto/staff.dart';
import 'package:office_staff_management/presentation/landing_screen/component/custom_office_card.dart';
import 'package:office_staff_management/presentation/office_details/bloc/bloc.dart';
import 'package:office_staff_management/presentation/utils/base_assets.dart';
import 'package:uuid/uuid.dart';

import '../../data/dto/office.dart';
import '../add_office/bloc/state.dart';
import '../add_office/view/add_office.dart';
import '../landing_screen/bloc/office_bloc.dart';
import '../landing_screen/office_failure_widget.dart';
import '../utils/base_colors.dart';
import '../utils/base_strings.dart';
import '../utils/common_floating_action_button.dart';
import '../utils/custom_avatar_dialog.dart';
import '../utils/custom_button.dart';
import '../utils/loading_widget.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';

class OfficeDetailsScreen extends StatefulWidget {
  final Office? officeDto;

  const OfficeDetailsScreen({super.key, this.officeDto});

  @override
  State<OfficeDetailsScreen> createState() => _OfficeDetailsScreenState();
}

class _OfficeDetailsScreenState extends State<OfficeDetailsScreen> {
  dynamic result;

  @override
  Widget build(BuildContext context) {
    SearchController searchController = SearchController();
    return Scaffold(
        backgroundColor: BaseColors.backgroundColor,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: BaseColors.backgroundColor,
          centerTitle: true,
          title: const Text(BaseStrings.officeText,
              style: TextStyle(
                  fontFamily: BaseStrings.interFontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: BaseColors.textColor)),
        ),
        body: Column(
          children: [
            BlocBuilder<PutStaffBloc, StaffState>(
              builder: (bContext, state) {
                if (state is StaffLoading) {
                  return const LoadingWidget();
                } else if (state is StaffFailure) {
                  return OfficeFailureWidget(message: state.message);
                }
                return state is StaffSuccess
                    ? Expanded(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: BlocBuilder<OfficeBloc, OfficeState>(
                              builder: (context, officeState) {
                                dynamic office;
                                if (result == null) {
                                  office = widget.officeDto
                                    ?..noOfStaff = state.list
                                        .where((test) =>
                                            test.officeId == widget.officeDto?.id)
                                        .length;
                                } else {
                                  office = result
                                    ?..noOfStaff = state.list
                                        .where((test) =>
                                            test.officeId == widget.officeDto?.id)
                                        .length;
                                }
                                return CustomOfficeCard(
                                  officeDto: office,
                                  editIconTap: () async {
                                    result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AddOfficeScreen(
                                                  isEdit: true,
                                                  officeDto: result ?? office,
                                                )));
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 24.0, left: 16, right: 16),
                            child: SearchBar(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              elevation: const WidgetStatePropertyAll(0),
                              backgroundColor: WidgetStateProperty.all(Colors.white),
                              controller: searchController,
                              padding: WidgetStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 16.0)),
                              onTap: () {},
                              hintText: BaseStrings.searchText,
                              hintStyle: const WidgetStatePropertyAll(TextStyle(
                                  fontFamily: BaseStrings.interFontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: BaseColors.textColor)),
                              onChanged: (value) {
                                context
                                    .read<PutStaffBloc>()
                                    .add(SearchStaffEvent(value.toLowerCase()));
                              },
                              trailing: <Widget>[
                                IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(BaseAssets.searchIcon),
                                  selectedIcon: const Icon(Icons.brightness_2_outlined),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 24.0, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  BaseStrings.staffMembersInOfficeText,
                                  style: TextStyle(
                                      fontFamily: BaseStrings.interFontFamily,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: BaseColors.textColor),
                                ),
                                Text(
                                    state.list
                                        .where((test) =>
                                            test.officeId == widget.officeDto?.id)
                                        .length
                                        .toString(),
                                    style: const TextStyle(
                                        fontFamily: BaseStrings.interFontFamily,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: BaseColors.textColor)),
                              ],
                            ),
                          ),
                          state.list
                                  .where((test) => test.officeId == widget.officeDto?.id)
                                  .isNotEmpty
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0, top: 13),
                                    child: ListView.builder(
                                      itemCount: state.list
                                          .where((test) =>
                                              test.officeId == widget.officeDto?.id)
                                          .length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(bottom: 16.0),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: SvgPicture.asset(BaseAssets.avatarList[
                                              state.list
                                                      .where((test) =>
                                                          test.officeId ==
                                                          widget.officeDto?.id)
                                                      .toList()[index]
                                                      .staffAvatarIndex ??
                                                  0]),
                                          title: Text(
                                            "${state.list.where((test) => test.officeId == widget.officeDto?.id).toList()[index].staffFirstName} ${state.list.where((test) => test.officeId == widget.officeDto?.id).toList()[index].staffLastName}",
                                            style: const TextStyle(
                                                fontFamily: BaseStrings.interFontFamily,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: BaseColors.textColor),
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              showDeleteStaffDialog(context, () {
                                                context.read<PutStaffBloc>().add(
                                                    DeleteStaffEvent(Staff(
                                                        id: state.list
                                                            .where((test) =>
                                                                test.officeId ==
                                                                widget.officeDto?.id)
                                                            .toList()[index]
                                                            .id,
                                                        officeId: widget.officeDto?.id,
                                                        staffFirstName: "",
                                                        staffLastName: "",
                                                        staffAvatarIndex: index)));
                                                context
                                                    .read<PutStaffBloc>()
                                                    .add(GetStaffsEvent());
                                                context
                                                    .read<PutStaffBloc>()
                                                    .add(GetStaffsEvent());
                                                Navigator.pop(context);
                                              }, () {
                                                Navigator.pop(context);
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (BuildContext con) {
                                                    return CustomDialog(
                                                      onTap:
                                                          (indexed, firstName, lastName) {
                                                        con.read<PutStaffBloc>().add(
                                                            PutStaffEvent(Staff(
                                                                id: state.list
                                                                    .where((test) =>
                                                                        test.officeId ==
                                                                        widget.officeDto
                                                                            ?.id)
                                                                    .toList()[index]
                                                                    .id,
                                                                officeId:
                                                                    widget.officeDto?.id,
                                                                staffFirstName: firstName,
                                                                staffLastName: lastName,
                                                                staffAvatarIndex:
                                                                    indexed)));
                                                        context
                                                            .read<PutStaffBloc>()
                                                            .add(GetStaffsEvent());
                                                        context
                                                            .read<OfficeBloc>()
                                                            .add(GetAllOffices());
                                                        Navigator.pop(context);
                                                      },
                                                      isEdit: true,
                                                      staffDto: state.list
                                                          .where((test) =>
                                                              test.officeId ==
                                                              widget.officeDto?.id)
                                                          .toList()[index],
                                                    );
                                                  },
                                                );
                                              });
                                            },
                                            icon: SvgPicture.asset(BaseAssets.moreIcon),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const OfficeFailureWidget(
                                  message: BaseStrings.noStaffAvailable),
                        ]),
                      )
                    : Container();
              },
            ),
          ],
        ),
        floatingActionButton: floatingActionButton(context, () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext con) {
              return CustomDialog(
                onTap: (index, firstName, lastName) {
                  con.read<PutStaffBloc>().add(PutStaffEvent(Staff(
                      id: const Uuid().v4(),
                      officeId: widget.officeDto?.id,
                      staffFirstName: firstName,
                      staffLastName: lastName,
                      staffAvatarIndex: index)));
                  context.read<PutStaffBloc>().add(GetStaffsEvent());
                  context.read<PutStaffBloc>().add(GetStaffsEvent());
                  Navigator.pop(context);
                },
                isEdit: false,
              );
            },
          );
        }));
  }

  void showDeleteStaffDialog(
      BuildContext context, Function() onTap, Function() onEditTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BaseColors.whiteColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomButton(
                  btnNameText: BaseStrings.editStaffMember.toUpperCase(),
                  onTap: onEditTap,
                ),
              ),
              CustomButton(
                btnNameText: BaseStrings.deleteStaffMember.toUpperCase(),
                backgroundColor: Colors.transparent,
                textColor: BaseColors.skyBlueColor,
                onTap: onTap,
              ),
            ],
          ),
        );
      },
    );
  }
}
