class FAQQuestion {
  final String question;
  final String answer;

  FAQQuestion({required this.question, required this.answer});

  factory FAQQuestion.fromJson(Map<String, dynamic> json) =>
      FAQQuestion(question: json['question'], answer: json['answer']);
}
