class Ingredient {
  final String ingredientName;
  final String amount;

  Ingredient({required this.ingredientName, required this.amount});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredientName: json['ingredientName'],
      amount: json['amount'],
    );
  }
}
