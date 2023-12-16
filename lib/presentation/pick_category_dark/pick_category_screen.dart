import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/app_export.dart';
import '../../data/apiClient/studentApiCall.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/select_category.dart' as category;
import '../app_navigation_screen/app_navigation_screen.dart';

class PickCategoryScreen extends StatefulWidget {
  const PickCategoryScreen({Key? key}) : super(key: key);

  @override
  State<PickCategoryScreen> createState() => _PickCategoryScreenState();
}

class _PickCategoryScreenState extends State<PickCategoryScreen> {
  final List<String> items = [
    'Science',
    'Social Studies',
    'Computers',
    'Arts',
    'Language',
    'Math',
    'Sports',
    'Other',
  ];

  Map selectMap = {};
  @override
  Widget build(BuildContext context) {
    int counter = 0;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorConstant.darkModeBkg,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: ColorConstant.darkModeBkg,
      //   centerTitle: true,
      //   elevation: 4,
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(2),
      //     child: Container(
      //       color: Colors.white,
      //     ),
      //   ),
      //   title: Text(
      //     "Next, select your categories",
      //     textAlign: TextAlign.center,
      //     style: GoogleFonts.getFont(
      //       'Rubik',
      //       color: ColorConstant.white,
      //       fontSize: getFontSize(20),
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          Container(
            color: ColorConstant.darkModeBkg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(40),
                ),
                Text(
                  "Next, select your categories",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Rubik',
                    color: ColorConstant.white,
                    fontSize: getFontSize(21),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: getSize(20),
                ),
                Divider(
                  thickness: 0.1,
                  color: Colors.white,
                ),
                SizedBox(
                  height: getSize(15),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List>(
                future: StudentApiCall.getStuddentDataForSelectCatefory(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  if (StudentApiCall.studentDataFromCategory == null) {
                    return SizedBox();
                  }
                  // print(
                  //     'enrollments ${StudentClasses.studentDataFromCategory!.first}');
                  return Builder(builder: (context) {
                    List<category.SelectCategory>? studentDataFromCategory = [];
                    for (var element
                        in StudentApiCall.studentDataFromCategory!) {
                      if (element.term.startAt == 'null' ||
                          element.term.endAt == 'null') {
                      } else {
                        studentDataFromCategory.add(element);
                      }
                    }
                    //print('------->>>>> ${studentDataFromCategory.length}');
                    counter = studentDataFromCategory.length;
                    return ListView.builder(
                      itemCount: StudentApiCall.studentDataFromCategory!.length,
                      itemBuilder: (context, index) {
                        var selectCategory =
                            StudentApiCall.studentDataFromCategory![index];
                        var selected = selectMap[selectCategory.name];
                        if (selectCategory.term.startAt == 'null' ||
                            selectCategory.term.endAt == 'null') {
                          return SizedBox();
                        }
                        return categories((value) {
                          selectMap[selectCategory.name] = value;
                          setState(() {});
                        }, selectCategory.name, selected);
                      },
                    );
                  });
                }),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                print('length is $counter');
                if (selectMap.length != counter) {
                  Fluttertoast.showToast(msg: 'Please select all categories');
                  return;
                }
                GetStorage().write(districtSchoolKey, selectMap);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppNavigationScreen(),
                    ),
                    (route) => false);
              },
              child: Text(
                "Continue",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.poppinsBold.copyWith(
                  fontSize: getFontSize(20),
                  color: ColorConstant.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.white,
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    ));
  }

  Widget categories(
      void Function(String?)? onChanged, String name, String? selectedItem) {
    // var size=MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.centerLeft,
              height: getVerticalSize(42),
              child: Text(
                name,
                style: GoogleFonts.getFont(
                  'DM Sans',
                  color: ColorConstant.white,
                  fontSize: getFontSize(19),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: getVerticalSize(44),
              width: getHorizontalSize(130),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      Text(
                        'Select',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedItem,
                  onChanged: onChanged,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  iconSize: 20,
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: 50,
                  buttonWidth: 150,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 20),
                  buttonDecoration: BoxDecoration(
                    color: Color(0xFF282828),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 200,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF282828),
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(-20, 0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
