import 'package:crypto_currency/app/app.dart';
import 'package:crypto_currency/app/app_di.dart';
import 'package:crypto_currency/bootstrap.dart';

void main() {
  bootstrap(() async {
    final repos = await AppDi.init();
    return App(
      repositoryProviders: repos,
    );
  });
}
