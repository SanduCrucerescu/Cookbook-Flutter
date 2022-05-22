import 'dart:convert';

class WeeklyRecipe {
  final int day, week, daytime, recipeId;
  final String email;

  WeeklyRecipe({
    required this.day,
    required this.week,
    required this.daytime,
    required this.recipeId,
    required this.email,
  });

  @override
  String toString() => 'WeeklyRecipe(recipeId: $recipeId, email: $email)';

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'week': week,
      'daytime': daytime,
      'recipeId': recipeId,
      'email': email,
    };
  }

  factory WeeklyRecipe.fromMap(Map<String, dynamic> map) {
    return WeeklyRecipe(
      day: map['day']?.toInt() ?? 0,
      week: map['week']?.toInt() ?? 0,
      daytime: map['daytime']?.toInt() ?? 0,
      recipeId: map['recipeId']?.toInt() ?? 0,
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WeeklyRecipe.fromJson(String source) =>
      WeeklyRecipe.fromMap(json.decode(source));
}
