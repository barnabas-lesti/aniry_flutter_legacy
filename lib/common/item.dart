abstract class CommonItem {
  final String id;
  final String text;
  bool checked;

  CommonItem({
    required this.id,
    required this.text,
    this.checked = false,
  });
}
