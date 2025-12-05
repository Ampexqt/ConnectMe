/// Interest Model
/// Represents a selectable interest with emoji and label
class Interest {
  final String id;
  final String emoji;
  final String label;

  Interest({required this.id, required this.emoji, required this.label});

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
      id: json['id'] as String,
      emoji: json['emoji'] as String,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'emoji': emoji, 'label': label};
  }
}
