import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:office_staff_management/data/dto/office.dart';
import 'package:office_staff_management/domain/app_repository.dart';
import 'package:office_staff_management/presentation/add_office/bloc/state.dart';
import 'package:office_staff_management/presentation/utils/custom_button.dart';
import 'package:uuid/uuid.dart';

import '../../landing_screen/bloc/office_bloc.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_strings.dart';
import '../../utils/custom_alert_dialog.dart';
import '../../utils/custom_text_field.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';

class AddOfficeScreen extends StatefulWidget {
  final bool isEdit;
  final Office? officeDto;

  const AddOfficeScreen({super.key, this.isEdit = false, this.officeDto});

  @override
  State<AddOfficeScreen> createState() => _AddOfficeScreenState();
}

class _AddOfficeScreenState extends State<AddOfficeScreen> {
  final TextEditingController officeNameController = TextEditingController();

  final TextEditingController officePhysicalAddressController = TextEditingController();

  final TextEditingController officeEmailController = TextEditingController();

  final TextEditingController officePhoneController = TextEditingController();

  final TextEditingController officeCapacityController = TextEditingController();

  int? selectedIndex = -1;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((widget.officeDto?.officeName?.isNotEmpty ?? false) && widget.isEdit) {
        officeNameController.text = widget.officeDto!.officeName!;
        officePhysicalAddressController.text = widget.officeDto!.officeAddress!;
        officeEmailController.text = widget.officeDto!.officeEmail!;
        officePhoneController.text = widget.officeDto!.officeNumber!;
        officeCapacityController.text = widget.officeDto!.officeCapacity!.toString();
        selectedIndex = widget.officeDto?.officeCardColor;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final officeBloc = OfficeBloc(GetIt.I<AppRepository>());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddOfficeBloc(),
        ),
        BlocProvider(
          create: (context) => PutOfficeBloc(GetIt.I<AppRepository>()),
        ),
      ],
      child: BlocBuilder<AddOfficeBloc, AddStaffState>(
        builder: (ctx, chooseColorState) {
          if (selectedIndex != widget.officeDto?.officeCardColor && widget.isEdit) {
            chooseColorState.selectedColorIndex = widget.officeDto?.officeCardColor ?? 0;
          }
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: Text(
                widget.isEdit ? BaseStrings.editOfficeText : BaseStrings.newOfficeText,
                style: const TextStyle(
                    color: BaseColors.blackColor,
                    fontSize: 18,
                    fontFamily: BaseStrings.interFontFamily,
                    fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
              backgroundColor: BaseColors.backgroundColor,
            ),
            backgroundColor: BaseColors.backgroundColor,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        hint: BaseStrings.officeNameText,
                        textEditingController: officeNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return BaseStrings.pleaseEnterOfficeName;
                          }
                          String pattern = r'^[a-zA-Z0-9\s]+$';
                          RegExp regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return BaseStrings.pleaseEnterValidOfficeName;
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        hint: BaseStrings.physicalAddressText,
                        textEditingController: officePhysicalAddressController,
                      ),
                      CustomTextFormField(
                        hint: BaseStrings.emailAddressText,
                        textEditingController: officeEmailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return BaseStrings.pleaseEnterEmail;
                          }
                          // Regular expression for email validation
                          String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          RegExp regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return BaseStrings.pleaseEnterValidEmail;
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        hint: BaseStrings.phoneNumberText,
                        textEditingController: officePhoneController,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Text("+1",
                              style: TextStyle(
                                color: BaseColors.blackColor,
                                fontSize: 16,
                                fontFamily: BaseStrings.interFontFamily,
                              )),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return BaseStrings.pleaseEnterPhoneNumber;
                          }
                          // Regular expression for email validation
                          String pattern = "^[1-9][0-9]*\$";
                          RegExp regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return BaseStrings.pleaseEnterValidPhoneNumber;
                          } else if (value.length != 10) {
                            return BaseStrings.pleaseEnterValidPhoneNumber;
                          }
                          return null;
                        },
                        maxLength: 10,
                      ),
                      CustomTextFormField(
                        hint: BaseStrings.maximumCapacityText,
                        textEditingController: officeCapacityController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return BaseStrings.pleaseEnterCapacity;
                          }
                          String pattern = "^[0-9]+\$";
                          RegExp regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return BaseStrings.pleaseEnterValidCapacity;
                          }
                          return null;
                        },
                        maxLength: 6,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          BaseStrings.officeColourText,
                          style: TextStyle(
                              color: BaseColors.blackColor,
                              fontSize: 24,
                              fontFamily: BaseStrings.interFontFamily,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 6,
                            child: generateColorPalette(ctx, chooseColorState,
                                chooseColorState.selectedColorIndex, widget.isEdit)),
                      ),
                      BlocBuilder<PutOfficeBloc, PutStaffState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: CustomButton(
                              btnNameText: widget.isEdit
                                  ? BaseStrings.updateOfficeText
                                  : BaseStrings.addOfficeText.toUpperCase(),
                              onTap: () {
                                if (officeNameController.text.isEmpty) {
                                  showInSnackBar(
                                      BaseStrings.pleaseEnterValidOfficeName, context);
                                } else if (officePhysicalAddressController.text.isEmpty) {
                                  showInSnackBar(BaseStrings.enterValidAddress, context);
                                } else if (officeEmailController.text.isEmpty) {
                                  showInSnackBar(
                                      BaseStrings.enterValidEmailAddress, context);
                                } else if (officePhoneController.text.isEmpty) {
                                  officePhoneController.text.startsWith("0") ||
                                          officePhoneController.text.length < 10
                                      ? showInSnackBar(
                                          BaseStrings.pleaseEnterValidPhoneNumber,
                                          context)
                                      : '';
                                } else if (officeCapacityController.text.isEmpty) {
                                  showInSnackBar(
                                      BaseStrings.pleaseEnterValidCapacity, context);
                                } else if (!formKey.currentState!.validate()) {
                                  showInSnackBar(BaseStrings.enterValidData, context);
                                } else {
                                  context.read<PutOfficeBloc>().add(
                                        PutOfficeEvent(
                                          Office(
                                            id: widget.isEdit
                                                ? widget.officeDto?.id ?? ""
                                                : const Uuid().v4(),
                                            officeName: officeNameController.text,
                                            noOfStaff: widget.isEdit ? 10 : 0,
                                            officeNumber: officePhoneController.text,
                                            officeEmail: officeEmailController.text,
                                            officeCapacity:
                                                int.parse(officeCapacityController.text),
                                            officeAddress:
                                                officePhysicalAddressController.text,
                                            officeCardColor:
                                                chooseColorState.selectedColorIndex,
                                          ),
                                        ),
                                      );
                                  officeBloc.add(GetAllOffices());
                                  context.read<OfficeBloc>().add(GetAllOffices());
                                  Navigator.of(context).pop(
                                    Office(
                                      id: widget.isEdit
                                          ? widget.officeDto?.id ?? ""
                                          : const Uuid().v4(),
                                      officeName: officeNameController.text,
                                      noOfStaff: widget.isEdit ? 10 : 0,
                                      officeNumber: officePhoneController.text,
                                      officeEmail: officeEmailController.text,
                                      officeCapacity:
                                          int.parse(officeCapacityController.text),
                                      officeAddress: officePhysicalAddressController.text,
                                      officeCardColor:
                                          chooseColorState.selectedColorIndex,
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                      Visibility(
                        visible: widget.isEdit,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: CustomButton(
                            btnNameText: BaseStrings.deleteOfficeText.toUpperCase(),
                            onTap: () {
                              showCustomDialog(
                                context,
                                isOffice: true,
                                isTitle: true,
                                Padding(
                                  padding: const EdgeInsets.only(top: 32.0),
                                  child: CustomButton(
                                    btnNameText:
                                        BaseStrings.deleteOfficeText.toUpperCase(),
                                    onTap: () {
                                      Navigator.pop(context);
                                      ctx
                                          .read<PutOfficeBloc>()
                                          .add(DeleteOfficeEvent(widget.officeDto!));
                                      officeBloc.add(GetAllOffices());
                                      context.read<OfficeBloc>().add(GetAllOffices());
                                      if (widget.isEdit) Navigator.pop(context);
                                      if (Navigator.canPop(context)) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    textColor: BaseColors.whiteTextColor,
                                    backgroundColor: BaseColors.redColor,
                                  ),
                                ),
                                CustomButton(
                                  btnNameText: BaseStrings.keepOfficeText.toUpperCase(),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  textColor: BaseColors.skyBlueColor,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            },
                            textColor: BaseColors.skyBlueColor,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showInSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget generateColorPalette(
      BuildContext ctx, AddStaffState state, int selectedIndex, bool isEdit) {
    return Center(
      child: BlocBuilder<AddOfficeBloc, AddStaffState>(
        builder: (BuildContext contexts, state) {
          return Wrap(
            spacing: 10.0,
            runSpacing: 30.0,
            alignment: WrapAlignment.center,
            children: List.generate(
              colorPalette.length,
              (index) => GestureDetector(
                onTap: () {
                  contexts.read<AddOfficeBloc>().add(ChooserEvent(index, 0));
                },
                child: Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: state.selectedColorIndex == index
                          ? BaseColors.selectedBorderColor
                          : Colors.transparent,
                      width: 4,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: colorPalette[index],
                    radius: 20,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
