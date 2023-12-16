import 'package:agendavue/presentation/signin_dark_screen/signin_dark_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../data/apiClient/soap_api/studentvueclient_base.dart';
import '../../../data/apiClient/soap_api/zip_code_result.dart';

class DistrictDarkController extends GetxController {
  //Rx<DistrictDarkModel> districtDarkModelObj = DistrictDarkModel().obs;
  TextEditingController editingController = TextEditingController();
  late Future<List<District>> districts;
  String searchText = "";

  @override
  void onInit() {
    super.onInit();
    districts = fetchDistricts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onTapLiveCourse() {
    // Get.toNamed(AppRoutes.signinDarkScreen);
    Get.to(SigninDarkScreen());
  }

  updateText(String text) {
    searchText = text;
    fetchDistricts();
    update();
    districts = fetchDistricts();
  }

  onDistrictTap(districtInfo) {
    print(districtInfo.name);
  }

  List<ZipCodeResult>? listOfZipCodeResult;
  bool isLoading = false;
  // 20902 dafault zip code
  Future<List<ZipCodeResult>> getDistrictDataFromZipCode(
      String districtZipCode) async {
    isLoading = true;
    update();
    listOfZipCodeResult = await StudentVueClient.loadDistrictsFromZip(
        districtZipCode, callback: (pctLoaded) {
      print('${pctLoaded * 100}% loaded');
    }, mock: true);
    isLoading = false;

    update();
    print('------>>>>>>0000 $listOfZipCodeResult');
    return StudentVueClient.loadDistrictsFromZip(districtZipCode,
        callback: (pctLoaded) {
      print('${pctLoaded * 100}% loaded');
    }, mock: false);
  }
  //zip code sy list of districts nikly

  Future<List<District>> fetchDistricts() async {
    var response = await http.get(Uri.parse(
        'https://canvas.instructure.com:443/api/v1/accounts/search?name=$searchText'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final districtData = List<dynamic>.from(
        data.map<dynamic>(
          (dynamic item) => item,
        ),
      );

      return districtData
          .map((district) => District.fromJson(district))
          .toList();
    } else {
      print('Error dawg');
      throw Exception('Failed to load districts');
    }
  }
}

class District {
  final int id;
  final String name;
  final String domain;

  District({
    required this.id,
    required this.name,
    required this.domain,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
      domain: json['domain'],
    );
  }
}
