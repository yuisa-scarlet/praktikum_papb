/// Values come from `--dart-define-from-file=config/<env>.json`.
class AppConfig {
  AppConfig._();

  static const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://jsonplaceholder.typicode.com',
  );
  static const dbName = String.fromEnvironment(
    'DB_NAME',
    defaultValue: 'praktikum_papb_dev.db',
  );

  static bool get isDev => env == 'dev';
  static bool get isProd => env == 'prod';
}
