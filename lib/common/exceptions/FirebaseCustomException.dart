class FirebaseCustomException implements Exception {
  final String cause;
  const FirebaseCustomException(this.cause) : super();
}