import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartdriver/model/CabOrderModel.dart';
import 'package:emartdriver/model/hospital_model.dart';
import 'package:emartdriver/services/FirebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CabHomeController extends GetxController {
  var ridesId = ''.obs; // when from app
  var bookingId = ''.obs; // when from web
  var isLoading = false.obs;

  // for web
  var showWebSecondPolyLine = false.obs;
  var showWebThirdPolyLine = false.obs;
  var showWebCustomerPickUpButton = false.obs;
  var showWebCustomerDestinationReachButton = false.obs;
  var showWebCustomerCompleteRideButton = false.obs;

  //
  CabOrderModel? newRidesData;
  HospitalBooking? newHospitalData;
  StreamSubscription<DocumentSnapshot>? rideSubscription;
  StreamSubscription<DocumentSnapshot>? bookingSubscription;

  @override
  void onInit() {
    super.onInit();
    checkForRideId();
    checkForBookingId();
    checkAfterAccept();
    checkAfterCustomerPick();
    checkAfterRechedDestination();
  }

// for app
  Future<void> checkForRideId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedRidesId = prefs.getString("inprogressId");
    if (savedRidesId != null && savedRidesId.isNotEmpty) {
      ridesId.value = savedRidesId;
      await getRidesInfo(ridesId.value);
      listenToRideChanges(ridesId.value);
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

  void listenToRideChanges(String ridesId) {
    // Unsubscribe from previous subscriptions if any
    rideSubscription?.cancel();
    print('rides changes called 1');
    // Listen to real-time updates from the Firestore collection
    rideSubscription = FirebaseFirestore.instance
        .collection('rides')
        .doc(ridesId)
        .snapshots()
        .listen(
      (snapshot) {
        print('rides changes called 2');

        if (snapshot.exists) {
          try {
            print('rides changes called 3');

            newRidesData = CabOrderModel.fromJson(snapshot.data()!);
            print('rides changes called 4 ${newRidesData!.vehicleType!.id}');

            update();
          } catch (exception) {
            print(' rides changes called 5: $exception');
          }
        }
      },
      onError: (error) {
        // Print errors that occur during the stream
        print('Stream error rides it: $error');
      },
    );
  }

// for booking web
  Future<void> checkForBookingId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedBookingId = prefs.getString("bookingId");
    if (savedBookingId != null && savedBookingId.isNotEmpty) {
      bookingId.value = savedBookingId;
      await getHospitalInfo(bookingId.value);
      listenToBookingChanges(bookingId.value);
    }
  }

  Future<void> getHospitalInfo(String bookingId) async {
    // Perform the asynchronous operation.
    print('hospital data info is called');
    try {
      isLoading.value = true;
      newHospitalData = await FireStoreUtils.fetchHospitalBooking(bookingId);
      // log(newHospitalData!.hospitalId);
      // debugPrint(newHospitalData!.bookingType);
    } catch (exception) {
      debugPrint(
          'error in fetching getHospitalInfo cabHomeController ${exception}');
    } finally {
      isLoading.value = false;
    }
  }

  void listenToBookingChanges(String bookingId) {
    // Unsubscribe from previous subscriptions if any
    bookingSubscription?.cancel();
    print('booking changes called 1');

    // Listen to real-time updates from the Firestore document
    bookingSubscription = FirebaseFirestore.instance
        .collection('hospital_booking')
        .doc(bookingId)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.exists) {
          print('booking changes called 2');

          try {
            // Create a HospitalBooking instance from the updated document data
            newHospitalData = HospitalBooking.fromMap(snapshot.data()!);
            print('booking changes called 3');
            // Print the assignedDriverId whenever the document is updated
            print('booking changes called 4: ${newHospitalData?.bookingType}');
          } catch (e) {
            // Print any errors encountered during processing
            print(' booking changes called 5: $e');
          }
        } else {
          print('booking changes called 6 error');
          print('Document does not exist');
        }
      },
      onError: (error) {
        // Print errors that occur during the stream
        print('Stream error: $error');
      },
    );
  }

  @override
  void onClose() {
    // Cancel subscriptions when the controller is disposed
    rideSubscription?.cancel();
    bookingSubscription?.cancel();
    super.onClose();
  }

  void updateRidesId(String id) {
    ridesId.value = id;
  }

  void updateBookingId(String id) {
    bookingId.value = id;
  }

// for web
  void updateShowWebThirdPolyLine(bool value) {
    showWebThirdPolyLine.value = value;
  }

  void updateShowWebCustomerPickUpButton(bool value) {
    showWebCustomerPickUpButton.value = value;
  }

  Future<void> checkAfterAccept() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedShowThirdPolyline = prefs.getBool("showThirdPolyline");
    bool? showCustomerPickUpButton = prefs.getBool('showCustomerPickUpButton');
    if (savedShowThirdPolyline != null) {
      showWebThirdPolyLine.value = savedShowThirdPolyline;
    }
    if (showCustomerPickUpButton != null) {
      showWebCustomerPickUpButton.value = showCustomerPickUpButton;
    }
  }

// above methods are for  web, after accept button pressed

  void updateShowWebSecondPolyLine(bool value) {
    showWebSecondPolyLine.value = value;
  }

  void updateShowWebCustomerDestinationReachButton(bool value) {
    showWebCustomerDestinationReachButton.value = value;
  }

  Future<void> checkAfterCustomerPick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedshowSecondPolyline = prefs.getBool("showSecondPolyline");
    bool? showCustomerDestinationReachButton =
        prefs.getBool('showWebCustomerDestinationReachButton');
    if (savedshowSecondPolyline != null) {
      showWebSecondPolyLine.value = savedshowSecondPolyline;
    } else {
      print('second poly line is empty');
    }
    if (showCustomerDestinationReachButton != null) {
      showWebCustomerDestinationReachButton.value =
          showCustomerDestinationReachButton;
    }
  }
  // above methods for web after, customer is picked

  void updateShowWebCustomerCompleteRideButton(bool value) {
    showWebCustomerCompleteRideButton.value = value;
  }

  Future<void> checkAfterRechedDestination() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? showCustomerCompleteRideButton =
        prefs.getBool('ShowWebCustomerCompleteRideButton');

    if (showCustomerCompleteRideButton != null) {
      showWebCustomerCompleteRideButton.value = showCustomerCompleteRideButton;
    }
  }
}
