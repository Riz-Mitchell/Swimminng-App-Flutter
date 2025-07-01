import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/models/user_model.dart';

final createUserProvider = StateProvider<CreateUser>((ref) => CreateUser());
