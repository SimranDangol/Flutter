class TomatoModal {
  String? question;
  int? solution;

  TomatoModal({this.question, this.solution});

  // To store the data 
  TomatoModal.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    solution = json['solution'];
  }

  // To read the data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['solution'] = this.solution;
    return data;
  }
}