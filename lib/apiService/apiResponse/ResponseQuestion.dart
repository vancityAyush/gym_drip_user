class ResponseQuestion {
  int errorCode;
  String reponseString;
  List<Data> data;

  ResponseQuestion({this.errorCode, this.reponseString, this.data});

  ResponseQuestion.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    reponseString = json['reponse_string'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['reponse_string'] = this.reponseString;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Question question;
  Answer answer;

  Data({this.question, this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
    answer =
    json['answer'] != null ? new Answer.fromJson(json['answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.question != null) {
      data['question'] = this.question.toJson();
    }
    if (this.answer != null) {
      data['answer'] = this.answer.toJson();
    }
    return data;
  }
}

class Question {
  String id;
  String question;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Question(
      {this.id,
        this.question,
        this.optionA,
        this.optionB,
        this.optionC,
        this.optionD,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    optionA = json['option_a'];
    optionB = json['option_b'];
    optionC = json['option_c'];
    optionD = json['option_d'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['option_a'] = this.optionA;
    data['option_b'] = this.optionB;
    data['option_c'] = this.optionC;
    data['option_d'] = this.optionD;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Answer {
  String selectedOption;
  String description;

  Answer({this.selectedOption, this.description});

  Answer.fromJson(Map<String, dynamic> json) {
    selectedOption = json['selected_option'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selected_option'] = this.selectedOption;
    data['description'] = this.description;
    return data;
  }
}
