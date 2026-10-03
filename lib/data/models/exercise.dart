class Exercise {
  final String id;
  final String title;
  final String mascotMessage;
  final String socraticHint;
  final int groupsCount; // e.g. 4 baskets
  final int itemsPerGroup; // e.g. 3 apples each
  final String groupName; // e.g. "giỏ"
  final String itemName; // e.g. "táo"
  final int correctAnswer; // e.g. 12
  final List<int> options; // e.g. [12, 7, 15, 6, 4, 3]
  final String explanation;

  const Exercise({
    required this.id,
    required this.title,
    required this.mascotMessage,
    required this.socraticHint,
    required this.groupsCount,
    required this.itemsPerGroup,
    required this.groupName,
    required this.itemName,
    required this.correctAnswer,
    required this.options,
    required this.explanation,
  });
}
