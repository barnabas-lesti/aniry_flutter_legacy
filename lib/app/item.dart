class AppItem {
  final String id;
  final String text;
  bool checked;

  AppItem({
    required this.id,
    required this.text,
    this.checked = false,
  });
}
