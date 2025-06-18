import 'package:fashora_app/core/network/hive_service.dart';
import 'package:fashora_app/features/auth/data/data_source/user_data_source.dart';
import 'package:fashora_app/features/auth/data/model/user_hive_model.dart';
import 'package:fashora_app/features/auth/domain/entity/user_entity.dart';

class UserLocalDatasource  implements IuserDataSource{
  final HiveService _hiveService;

  UserLocalDatasource({ required HiveService hiveService})
  : _hiveService = hiveService;


  @override
  Future<void> registerUser(UserEntity userData) async {
    try{
      final userHiveModel = UserHiveModel.fromEntity(userData);
      await _hiveService.register(userHiveModel);
    }catch (e) {
      throw Exception( "Registration Failed: $e");

    }
    
   
  }
  
  @override
  Future<String> loginUser(String email, String password) async {
    try{
      final user = await _hiveService.loginUser(email, password);
      if( user == null){
        throw Exception('Invalid email or password');
      }
      return user.userId ?? '';


    }catch (e){
      throw Exception('Login failed: $e');
    }
  
  
  }
  
 
}