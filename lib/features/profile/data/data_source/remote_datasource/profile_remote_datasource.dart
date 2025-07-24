import 'package:dio/dio.dart';

import 'package:fashora_app/core/error/server_exception.dart';
import 'package:fashora_app/core/network/api_service.dart';
import 'package:fashora_app/features/profile/data/data_source/profile_datasource.dart';
import 'package:fashora_app/features/profile/data/model/profile_model.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';

class ProfileRemoteDataSourceImpl implements IProfileRemoteDataSource {
  final ApiService _apiService;

  ProfileRemoteDataSourceImpl(this._apiService);

  @override
  Future<ProfileEntity> getProfile() async {
    try {
      final response = await _apiService.get('/api/auth/me');
      // Update: Use 'data' key as per your backend response
      return ProfileModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Unexpected Dio error');
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<ProfileEntity> updateProfile(ProfileEntity profile, {String? newPassword}) async {
    try {
      final profileModel = ProfileModel.fromEntity(profile);

      // Add newPassword to request body if present
      final data = profileModel.toJson();
      if (newPassword != null && newPassword.isNotEmpty) {
        data['password'] = newPassword;
      }

      final response = await _apiService.put(
        '/api/auth/me',
        data: data,
      );

      // Update: Use 'data' key as per your backend response
      return ProfileModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ServerException(e.message ?? 'Unexpected Dio error');
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
