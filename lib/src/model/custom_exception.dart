class CustomException implements Exception {
  final String menssagem;

  CustomException(this.menssagem);

  @override
  String toString() {
    return menssagem;
  }
}
