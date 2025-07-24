import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/server_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';
import 'package:fashora_app/features/profile/domain/repository/profile_repository.dart';
import 'package:fashora_app/features/profile/domain/usecase/update_profile_usecase.dart';

// Mock class
class MockProfileRepository extends Mock implements IProfileRepository {}

void main() {
  late UpdateProfileUsecase updateProfileUsecase;
  late MockProfileRepository mockProfileRepository;

  const testProfile = ProfileEntity(
    userId: 'u123',
    name: 'Aarya Shrestha',
    email: 'aarya@example.com',
    phoneNumber: '9800000000',
    profileImageUrl: 'https://example.com/profile.jpg',
    address: 'Kathmandu, Nepal',
  );

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    updateProfileUsecase = UpdateProfileUsecase(mockProfileRepository);
  });

  group('UpdateProfileUsecase', () {
    test('should return updated ProfileEntity on success', () async {
      // arrange
      when(() => mockProfileRepository.updateProfile(testProfile, newPassword: any(named: 'newPassword')))
          .thenAnswer((_) async => const Right(testProfile));

      // act
      final result = await updateProfileUsecase(testProfile, newPassword: 'newpass123');

      // assert
      expect(result, const Right(testProfile));
      verify(() => mockProfileRepository.updateProfile(testProfile, newPassword: 'newpass123')).called(1);
    });

    test('should return Failure when update fails', () async {
      // arrange
      final failure = ServerFailure(message: 'Update failed');
      when(() => mockProfileRepository.updateProfile(testProfile, newPassword: any(named: 'newPassword')))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await updateProfileUsecase(testProfile, newPassword: 'newpass123');

      // assert
      expect(result, Left(failure));
      verify(() => mockProfileRepository.updateProfile(testProfile, newPassword: 'newpass123')).called(1);
    });
  });
}
