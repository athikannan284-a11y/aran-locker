import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String phoneNumber;
  final String? name;
  final String? email;
  final String? profilePhoto;
  final DateTime createdAt;
  final DateTime lastLogin;
  final String subscriptionType;
  final double storageUsed;
  final String deviceId;
  final bool biometricEnabled;
  final bool pinEnabled;

  UserModel({
    required this.userId,
    required this.phoneNumber,
    this.name,
    this.email,
    this.profilePhoto,
    required this.createdAt,
    required this.lastLogin,
    this.subscriptionType = 'Free',
    this.storageUsed = 0.0,
    required this.deviceId,
    this.biometricEnabled = false,
    this.pinEnabled = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'profilePhoto': profilePhoto,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
      'subscriptionType': subscriptionType,
      'storageUsed': storageUsed,
      'deviceId': deviceId,
      'biometricEnabled': biometricEnabled,
      'pinEnabled': pinEnabled,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'],
      email: map['email'],
      profilePhoto: map['profilePhoto'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLogin: (map['lastLogin'] as Timestamp).toDate(),
      subscriptionType: map['subscriptionType'] ?? 'Free',
      storageUsed: (map['storageUsed'] ?? 0.0).toDouble(),
      deviceId: map['deviceId'] ?? '',
      biometricEnabled: map['biometricEnabled'] ?? false,
      pinEnabled: map['pinEnabled'] ?? false,
    );
  }
}
