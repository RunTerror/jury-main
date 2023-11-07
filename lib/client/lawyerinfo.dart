// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class info {
//   final String profile;

//   final String name;
//   final String location;
//   final String lawyerid;
//   final String mobilenumber;
//   final String email;
//   final String address;
//   final String type;

//   bool isExpanded;

//   info(this.profile, this.name, this.location, this.lawyerid, this.mobilenumber,
//       this.email, this.address, this.type,
//       {this.isExpanded = false});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'profile': profile,
//       'name': name,
//       'location': location,
//       'lawyerid': lawyerid,
//       'mobilenumber': mobilenumber,
//       'email': email,
//       'address': address,
//       'type': type,
//       'isExpanded': isExpanded,
//     };
//   }

//   factory info.fromMap(Map<String, dynamic> map) {
//     return info(
//       (map["profile"] ?? '') as String,
//       (map["name"] ?? '') as String,
//       (map["location"] ?? '') as String,
//       (map["lawyerid"] ?? '') as String,
//       (map["mobilenumber"] ?? '') as String,
//       (map["email"] ?? '') as String,
//       (map["address"] ?? '') as String,
//       (map["type"] ?? '') as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory info.fromJson(String source) =>
//       info.fromMap(json.decode(source) as Map<String, dynamic>);
// }

import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class Info {
  final String profile;
  final String name;
  final String location;
  final String lawyerId;
  final String mobileNumber;
  final String email;
  final String address;
  final String type;
  bool isExpanded;

  Info({
    required this.profile,
    required this.name,
    required this.location,
    required this.lawyerId,
    required this.mobileNumber,
    required this.email,
    required this.address,
    required this.type,
    this.isExpanded = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'profile': profile,
      'name': name,
      'location': location,
      'lawyerId': lawyerId,
      'mobileNumber': mobileNumber,
      'email': email,
      'address': address,
      'type': type,
    };
  }

  static addLawyersToFirestore(int count) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<String> names = [
      'John Doe',
      'Jane Smith',
      'Robert Johnson',
      'Alice Lee',
      'Michael Chen',
      'Sarah Kim',
      'David Wang',
      'Emily Davis',
      'Kevin Brown',
      'Olivia Park',
      'Thomas Anderson',
      'Sophia Garcia',
      'Joseph Taylor',
      'Isabella Lopez',
      'Daniel Martinez',
      'Mia Moore',
      'Andrew Thompson',
      'Emma Harris',
      'Matthew Clark',
      'Ava Lewis',
      'James Walker',
      'Abigail Wright',
      'Benjamin Hall',
      'Sofia Young',
      'Christopher Allen',
      'Chloe Hernandez',
      'William King',
      'Ella Scott',
      'Alexander Green',
      'Victoria Adams',
      'Ryan Hill',
      'Grace Baker',
      'Christian Carter',
      'Zoe Turner',
      'Jonathan Ward',
      'Penelope Collins',
      'Jason Morris',
      'Lily Rivera',
      'Jacob Powell',
      'Sophie Cooper',
      'Brandon Reed',
      'Layla Rogers',
      'Caleb Wood',
      'Nora Ramirez',
      'Samuel Brooks',
      'Avery Washington',
      'Luke Richardson',
      'Elizabeth Price',
      'Dylan Jenkins',
      'Mila Hughes',
    ];

    List<String> locations = [
      'New York',
      'Los Angeles',
      'Chicago',
      'Houston',
      'Phoenix',
      'Philadelphia',
      'San Antonio',
      'San Diego',
      'Dallas',
      'San Jose',
      'Austin',
      'Jacksonville',
      'San Francisco',
      'Indianapolis',
      'Columbus',
      'Seattle',
      'Denver',
      'Charlotte',
      'Washington',
      'Boston',
    ];

    List<String> types = [
      'Civil Litigation',
      'Criminal Defense',
      'Personal Injury',
      'Family Law',
      'Immigration',
      'Bankruptcy',
      'Real Estate',
      'Estate Planning',
      'Intellectual Property',
      'Corporate Law',
    ];

    Random random = Random();

    for (int i = 0; i < count; i++) {
      String name = names[random.nextInt(names.length)];
      String location = locations[random.nextInt(locations.length)];
      String type = types[random.nextInt(types.length)];

      String profilePhoto =
          'https://example.com/profile_photo/${random.nextInt(100)}.jpg';
      String lawyerId = 'L${random.nextInt(100000)}';
      String mobileNumber =
          '555-${random.nextInt(1000).toString().padLeft(3, '0')}-${random.nextInt(10000).toString().padLeft(4, '0')}';
      String email = '${name.replaceAll(' ', '.').toLowerCase()}@example.com';
      String address = '${random.nextInt(1000)} ${[
        'Main',
        'First',
        'Second',
        'Third',
        'Fourth'
      ][random.nextInt(5)]} St, $location, USA';

      var profile = Info(
        profile: profilePhoto,
        name: name,
        location: location,
        lawyerId: lawyerId,
        mobileNumber: mobileNumber,
        email: email,
        address: address,
        type: type,
      );
      print(profile.toMap());

      await firestore.collection('lawyers').add(profile.toMap());
      print('Added lawyer: $name');
    }
  }

  factory Info.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<dynamic, dynamic>? data = snapshot.data() as Map<dynamic, dynamic>?;
    if (data == null) {
      // Handle null data case
      throw Exception("Invalid document snapshot data");
    }
    return Info(
      profile: data['profile'] ?? '',
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      lawyerId: data['lawyerId'] ?? '',
      mobileNumber: data['mobileNumber']?.toString() ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, String>{
      'profile': profile,
      'name': name,
      'location': location,
      'lawyerId': lawyerId,
      'mobileNumber': mobileNumber,
      'email': email,
      'address': address,
      'type': type,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      profile: (map["profile"] ?? '') as String,
      name: (map["name"] ?? '') as String,
      location: (map["location"] ?? '') as String,
      lawyerId: (map["lawyerId"] ?? '') as String,
      mobileNumber: (map["mobileNumber"] ?? '') as String,
      email: (map["email"] ?? '') as String,
      address: (map["address"] ?? '') as String,
      type: (map["type"] ?? '') as String,
      isExpanded: (map["isExpanded"] ?? false) as bool,
    );
  }

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);
}
