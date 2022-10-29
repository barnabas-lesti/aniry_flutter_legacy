class AppItemFormController<T> {
  late T? Function() _onGetItem;

  T? getItem() => _onGetItem();

  void onGetItem(T? Function() callback) {
    _onGetItem = callback;
  }
}
