class ExpansionItem {
  ExpansionItem({
    required this.title,
    required this.expandedText,
    this.isExpanded = false,
  });
  String title;
  String expandedText;
  bool isExpanded;
}