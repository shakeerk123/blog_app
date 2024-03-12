import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImple implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImple(this.supabaseClient);
  @override
  Future<UserModel> loginInWithEmailPassword({
    required String email,
    required String password,
  }) async{
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email,);

      if (response.user == null) {
        throw ServerException("User is null");
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
    throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {"name": name});

      if (response.user == null) {
        throw ServerException("User is null");
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
    throw ServerException(e.toString());
    }
  }
}
