import 'package:emartdriver/model/CabOrderModel.dart';
import 'package:emartdriver/services/FirebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CabHomeController extends GetxController {
  var ridesId = ''.obs;
  var isLoading = false.obs;
  CabOrderModel? newRidesData;
  @override
  void onInit() {
    super.onInit();
    checkForRideId();
  }

  Future<void> checkForRideId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedRidesId = prefs.getString("inprogressId");
    if (savedRidesId != null && savedRidesId.isNotEmpty) {
      ridesId.value = savedRidesId;
    }
  }

  Future<void> getRidesInfo(String ridesId) async {
    // Perform the asynchronous operation.
    print('newRidesData is called');
    try {
      isLoading.value = true;
      newRidesData = await FireStoreUtils.getRideData(ridesId);
    } catch (exception) {
      debugPrint('error in fetching getRidesInfo ${exception}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateRidesId(String id) {
    ridesId.value = id;
  }
}
