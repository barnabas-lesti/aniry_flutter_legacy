class AppDataController<T> {
  late T Function() _onGetData;

  T getData() => _onGetData();

  void onGetData(T Function() callback) {
    _onGetData = callback;
  }
}
