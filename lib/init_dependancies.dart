import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repos_impli.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/home/data/datasources/blog_local_datasource.dart';
import 'package:blog_app/features/home/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/home/data/repositories/blog_repositories.dart';
import 'package:blog_app/features/home/domain/repositories/blog_repo.dart';
import 'package:blog_app/features/home/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/home/domain/usecases/uplaod_blog.dart';
import 'package:blog_app/features/home/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/domain/usecases/user_sign_in.dart';

part "init_dependencies_main.dart";
