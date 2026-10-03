class KidProfile {
  final String id;
  final String nickname;
  final int grade;
  final String avatarUrl;
  final String avatarEmoji;
  final int streakDays;
  final int stars;
  final int hearts;
  final int maxHearts;

  const KidProfile({
    required this.id,
    required this.nickname,
    required this.grade,
    required this.avatarUrl,
    required this.avatarEmoji,
    required this.streakDays,
    required this.stars,
    required this.hearts,
    this.maxHearts = 5,
  });

  KidProfile copyWith({
    String? id,
    String? nickname,
    int? grade,
    String? avatarUrl,
    String? avatarEmoji,
    int? streakDays,
    int? stars,
    int? hearts,
    int? maxHearts,
  }) {
    return KidProfile(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      grade: grade ?? this.grade,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarEmoji: avatarEmoji ?? this.avatarEmoji,
      streakDays: streakDays ?? this.streakDays,
      stars: stars ?? this.stars,
      hearts: hearts ?? this.hearts,
      maxHearts: maxHearts ?? this.maxHearts,
    );
  }
}
