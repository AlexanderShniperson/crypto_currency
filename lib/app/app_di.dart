import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_client/rest_client.dart';

abstract class AppDi {
  static Future<List<RepositoryProvider<dynamic>>> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final restClient = RestClient();
    return [
      RepositoryProvider<RestClient>.value(value: restClient),
    ];
  }
}
