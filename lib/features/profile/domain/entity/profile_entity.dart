import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final String? address;

  const ProfileEntity({
    this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    this.address,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        phoneNumber,
        profileImageUrl,
        address,
      ];

  factory ProfileEntity.empty() {
    return const ProfileEntity(
      userId: null,
      name: '',
      email: '',
      phoneNumber: '',
      profileImageUrl: null,
      address: null,
    );
  }
}
