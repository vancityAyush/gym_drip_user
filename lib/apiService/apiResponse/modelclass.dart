class ModelClassQuestion{

  String question;
  List<Answer> answer;

  ModelClassQuestion({this.question,this.answer});

}

class Answer{

  String questionA;
  String questionB;
  String questionC;
  String questionD;
  String id;

  Answer({this.questionA,this.questionB,this.questionC,this.questionD,this.id});

}