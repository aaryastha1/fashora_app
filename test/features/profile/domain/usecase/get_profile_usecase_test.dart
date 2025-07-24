import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/server_failure.dart';
import 'package:fashora_app/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fashora_app/core/error/failure.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';
import 'package:fashora_app/features/profile/domain/repository/profile_repository.dart';


// Mock class
class MockProfileRepository extends Mock implements IProfileRepository {}

void main() {
  late GetProfile getProfile;
  late MockProfileRepository mockProfileRepository;

  const testProfile = ProfileEntity(
    userId: 'user123',
    name: 'Aarya Shrestha',
    email: 'aarya@example.com',
    phoneNumber: '9800000000',
    profileImageUrl: 'https://example.com/image.jpg',
    address: 'Kathmandu, Nepal',
  );

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    getProfile = GetProfile(mockProfileRepository);
  });

  group('GetProfile UseCase', () {
    test('should return ProfileEntity on success', () async {
      // arrange
      when(() => mockProfileRepository.getProfile())
          .thenAnswer((_) async => const Right(testProfile));

      // act
      final result = await getProfile();

      // assert
      expect(result, const Right(testProfile));
      verify(() => mockProfileRepository.getProfile()).called(1);
      verifyNoMoreInteractions(mockProfileRepository);
    });

    test('should return Failure on error', () async {
      // arrange
      final failure = ServerFailure(message: 'Failed to fetch profile');
      when(() => mockProfileRepository.getProfile())
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await getProfile();

      // assert
      expect(result, Left(failure));
      verify(() => mockProfileRepository.getProfile()).called(1);
      verifyNoMoreInteractions(mockProfileRepository);
    });
  });
}
