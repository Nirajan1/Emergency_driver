// import 'package:cloud_firestore/cloud_firestore.dart';

// class HospitalBooking {
//   final String bookingType;
//   final DateTime createdAt;
//   final String hospitalId;
//   final GeoPoint location;
//   final String status;
//   final String phone;
//   final String? assignedDriverId;

//   HospitalBooking({
//     required this.bookingType,
//     required this.createdAt,
//     required this.hospitalId,
//     required this.location,
//     required this.status,
//     required this.phone,
//     this.assignedDriverId,
//   });

//   // Method to create an instance from DocumentSnapshot
//   factory HospitalBooking.fromDocument(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>?;

//     return HospitalBooking(
//       bookingType: data?['booking_type'] ?? '',
//       createdAt:
//           (data?['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       hospitalId: data?['hospital_id'] ?? '',
//       // location: data?['location'] != null
//       //     ? GeoPoint(
//       //         data?['location']['latitude'] ?? 0.0,
//       //         data?['location']['longitude'] ?? 0.0,
//       //       )
//       //     : GeoPoint(0.0, 0.0),
//       location: data?['location'] is GeoPoint
//           ? data!['location'] as GeoPoint
//           : GeoPoint(
//               data != null && data['location']['latitude'] is String
//                   ? double.parse(data['location']['latitude'])
//                   : data?['location']['latitude'] ?? 0.0,
//               data != null && data['location']['longitude'] is String
//                   ? double.parse(data['location']['longitude'])
//                   : data?['location']['longitude'] ?? 0.0,
//             ),
//       status: data?['status'] ?? '',
//       phone: data?['phone'] ?? '',
//       assignedDriverId: data?['assigned_driver_id'],
//     );
//   }

//   // Convert the instance to a map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'booking_type': bookingType,
//       'created_at': createdAt,
//       'hospital_id': hospitalId,
//       'location': {
//         'latitude': location.latitude,
//         'longitude': location.longitude,
//       },
//       'status': status,
//       'phone': phone,
//       if (assignedDriverId != null) 'assigned_driver_id': assignedDriverId,
//     };
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalBooking {
  final String bookingType;
  final DateTime createdAt;
  final String hospitalId;
  final String hospitalLatitude;
  final String hospitalLongitude;
  final GeoPoint location;
  final String status;
  final String phone;
  final String? assignedDriverId;
  final String? payment;

  HospitalBooking({
    required this.bookingType,
    required this.createdAt,
    required this.hospitalId,
    required this.hospitalLatitude,
    required this.hospitalLongitude,
    required this.location,
    required this.status,
    required this.phone,
    this.assignedDriverId,
    this.payment,
  });

  // Method to create an instance from DocumentSnapshot
  factory HospitalBooking.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return HospitalBooking(
        bookingType: data?['booking_type'] ?? '',
        createdAt:
            (data?['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
        hospitalId: data?['hospital_id'] ?? '',
        hospitalLatitude: data?['hospital_latitude'] ?? '',
        hospitalLongitude: data?['hospital_longitude'] ?? '',
        location: (data?['location'] is GeoPoint)
            ? data!['location'] as GeoPoint
            : GeoPoint(
                data?['location']['latitude'] is double
                    ? data!['location']['latitude']
                    : double.tryParse(
                            data!['location']['latitude'].toString()) ??
                        0.0,
                data['location']['longitude'] is double
                    ? data['location']['longitude']
                    : double.tryParse(
                            data['location']['longitude'].toString()) ??
                        0.0,
              ),
        status: data['status'] ?? '',
        phone: data['phone'] ?? '',
        assignedDriverId: data['assigned_driver_id'],
        payment: data['payment']);
  }

  // Method to create an instance from a Map
  factory HospitalBooking.fromMap(Map<String, dynamic> data) {
    return HospitalBooking(
        bookingType: data['booking_type'] ?? '',
        createdAt:
            (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
        hospitalId: data['hospital_id'] ?? '',
        hospitalLatitude: data['hospital_latitude'] ?? '',
        hospitalLongitude: data['hospital_longitude'] ?? '',
        location: (data['location'] is GeoPoint)
            ? data['location'] as GeoPoint
            : GeoPoint(
                data['location']['latitude'] is String
                    ? double.parse(data['location']['latitude'])
                    : (data['location']['latitude'] as num).toDouble(),
                data['location']['longitude'] is String
                    ? double.parse(data['location']['longitude'])
                    : (data['location']['longitude'] as num).toDouble(),
              ),
        status: data['status'] ?? '',
        phone: data['phone'] ?? '',
        assignedDriverId: data['assigned_driver_id'],
        payment: data['payment']);
  }

  // Convert the instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'booking_type': bookingType,
      'created_at': Timestamp.fromDate(createdAt),
      'hospital_id': hospitalId,
      'hospital_latitude': hospitalLatitude, // New field
      'hospital_longitude': hospitalLongitude,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
      'status': status,
      'phone': phone,
      if (assignedDriverId != null) 'assigned_driver_id': assignedDriverId,
      if (payment != null) 'payment': payment,
    };
  }
}
