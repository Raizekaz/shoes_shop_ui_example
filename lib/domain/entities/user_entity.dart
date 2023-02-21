import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class User {
  late String id;

  User.fromFirebase(fb.User user) {
    id = user.uid;
  }
}

// class User extends Equatable {
//   const User({
//     this.id,
//     this.name,
//     this.email,
//     this.emailVerified,
//     this.address,
//     this.city,
//     this.country,
//     this.zipCode,
//   });

//   final String? id;
//   final String? name;
//   final String? email;
//   final bool? emailVerified;
//   final String? address;
//   final String? city;
//   final String? country;
//   final String? zipCode;

//   static const empty = User(id: '');
//   bool get isEmpty => this == User.empty;
//   bool get isNotEmpty => this != User.empty;

//   User copyWith({
//     String? id,
//     String? name,
//     String? email,
//     bool? emailVerified,
//     String? address,
//     String? city,
//     String? country,
//     String? zipCode,
//   }) {
//     return User(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       emailVerified: emailVerified ?? this.emailVerified,
//       address: address ?? this.address,
//       city: city ?? this.city,
//       country: country ?? this.country,
//       zipCode: zipCode ?? this.zipCode,
//     );
//   }

//   factory User.fromSnapshot(DocumentSnapshot snapshot) {
//     return User(
//       id: snapshot.id,
//       name: snapshot['name'],
//       email: snapshot['email'],
//       emailVerified: snapshot['emailVerified'],
//       address: snapshot['address'],
//       city: snapshot['city'],
//       country: snapshot['country'],
//       zipCode: snapshot['zipCode'],
//     );
//   }

//   Map<String, Object> toDocument() {
//     return {
//       'name': name ?? '',
//       'email': email ?? '',
//       'emailVerified': emailVerified ?? false,
//       'address': address ?? '',
//       'city': city ?? '',
//       'country': country ?? '',
//       'zipCode': zipCode ?? '',
//     };
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         email,
//         emailVerified,
//         address,
//         city,
//         country,
//         zipCode,
//       ];
// }
