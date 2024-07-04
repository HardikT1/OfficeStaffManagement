import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_staff_management/data/dto/staff.dart';
import 'package:office_staff_management/presentation/utils/custom_button.dart';
import 'package:office_staff_management/presentation/utils/custom_text_field.dart';

import '../add_office/bloc/bloc.dart';
import '../add_office/bloc/event.dart';
import '../add_office/bloc/state.dart';
import 'base_assets.dart';
import 'base_colors.dart';
import 'base_strings.dart';

class CustomDialog extends StatefulWidget {
  final Function(int, String, String) onTap;
  final bool isEdit;
  final Staff? staffDto;

  const CustomDialog(
      {super.key, required this.isEdit, required this.onTap, this.staffDto});

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
  final PageController _pageController = PageController(initialPage: 0);
  TextEditingController staffFirstName = TextEditingController();
  TextEditingController staffLastName = TextEditingController();
  int _currentPage = 0;
  int currentAvtarIndex = -1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((widget.staffDto?.officeId?.isNotEmpty ?? false) && widget.isEdit) {
        staffFirstName.text = widget.staffDto!.staffFirstName!;
        staffLastName.text = widget.staffDto!.staffLastName!;
        currentAvtarIndex = widget.staffDto?.staffAvatarIndex ?? 0;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: BaseColors.whiteTextColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                      visible: _currentPage >= 1,
                      child: GestureDetector(
                          onTap: () {
                            if (_currentPage == 1) {
                              _pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut);
                            }
                          },
                          child: SvgPicture.asset(BaseAssets.backArrowIcon))),
                  const Text(
                    softWrap: true,
                    BaseStrings.newStaffMemberText,
                    style: TextStyle(
                        color: BaseColors.blackColor,
                        fontSize: 18,
                        fontFamily: BaseStrings.interFontFamily,
                        fontWeight: FontWeight.bold),
                    maxLines: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(BaseAssets.closeIconSvg)),
                ],
              ),
            ),
            SizedBox(
              height: 280,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  staffAddingWidget(),
                  generateAvatarPalette(widget.onTap, currentAvtarIndex),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget generateAvatarPalette(
      Function(int, String, String) onTap, int? staffAvatarIndex) {
    return BlocProvider(
      create: (officeContext) => AddOfficeBloc(),
      child: BlocBuilder<AddOfficeBloc, AddStaffState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    softWrap: true,
                    textAlign: TextAlign.start,
                    BaseStrings.avtarText,
                    style: TextStyle(
                        color: BaseColors.blackColor,
                        fontSize: 16,
                        fontFamily: BaseStrings.interFontFamily,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 16.0,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    BaseAssets.avatarList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (currentAvtarIndex != index) {
                            context
                                .read<AddOfficeBloc>()
                                .add(ChooserEvent(state.selectedColorIndex, index));
                            currentAvtarIndex = index;
                          }
                        });
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: currentAvtarIndex == index
                                ? BaseColors.selectedBorderColor
                                : Colors.transparent,
                            width: 4,
                          ),
                        ),
                        child: SvgPicture.asset(BaseAssets.avatarList[index]),
                      ),
                    ),
                  ),
                ),
              ),
              DotsIndicator(
                dotsCount: [
                  generateAvatarPalette(widget.onTap, 0),
                  Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(''),
                    ),
                  ),
                ].length,
                position: _currentPage,
                decorator: const DotsDecorator(
                  color: Colors.grey,
                  activeColor: Colors.blue,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CustomButton(
                    btnNameText:
                        _currentPage == 0 ? "NEXT" : "Add staff member".toUpperCase(),
                    onTap: () {
                      setState(() {
                        if (_currentPage != 1) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                          _currentPage += 1;
                        } else {
                          if (staffFirstName.text.trim().isNotEmpty &&
                              staffLastName.text.trim().isNotEmpty &&
                              currentAvtarIndex != -1) {
                            widget.onTap(currentAvtarIndex, staffFirstName.text,
                                staffLastName.text);
                          } else {
                            showInSnackBar("Enter Valid Values", context);
                          }
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void showInSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget staffAddingWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextFormField(
          textEditingController: staffFirstName,
          hint: BaseStrings.firstNameText,
        ),
        CustomTextFormField(
          textEditingController: staffLastName,
          hint: BaseStrings.lastNameText,
        ),
        DotsIndicator(
          dotsCount: [
            generateAvatarPalette(widget.onTap, 0),
            Container(
              color: Colors.green,
              child: const Center(
                child: Text(''),
              ),
            ),
          ].length,
          position: _currentPage,
          decorator: const DotsDecorator(
            color: Colors.grey, // Inactive color
            activeColor: Colors.blue, // Active color
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomButton(
              btnNameText: _currentPage == 0 ? "NEXT" : "Add staff member".toUpperCase(),
              onTap: () {
                setState(() {
                  if (_currentPage != 1) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                    _currentPage += 1;
                  } else {}
                });
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
