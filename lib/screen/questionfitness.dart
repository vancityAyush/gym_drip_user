// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/apiResponse/ResponseQuestion.dart';
import 'package:twsuser/apiService/apiResponse/modelclass.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';

class QuestionFitness extends StatefulWidget {

  @override
  _QuestionFitnessState createState() => _QuestionFitnessState();
}

class _QuestionFitnessState extends State<QuestionFitness> {

  List<int> position = [];
  List<String> ans = [];
  List<String> ansB = [];
  List<String> ansC = [];
  List<String> ansD = [];
  List<String> ansList = [];
  // List<String> questions = [];
  Set questions = Set();
  // List<ModelClassQuestion> response = [];
  // List<Answer> answerList = [];
  // List<String> newList = [];

  int selectedIndex,selectedIndex1,selectedIndex2,selectedIndex3,checkIndex;
  var selectQuestion = 0,selectedAnswer = "", selectone;
  bool _isLoad = false;
  bool checkSubmitButton = false;
  int newIndex;
  String answer = "";
  PageController controller = PageController(viewportFraction: 1, keepPage: true);
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  void _trySubmit() async{
      setState(() {
        _isLoad = true;});

      // await Provider.of<ApiManager>(context,listen: false).loginApi(_userNumber);

      setState(() {
        _isLoad = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text("Physical Question",style: TextStyle(
            color: Colors.white
        ),),
        leading: InkWell(
           onTap: (){
             Navigator.pop(context);},
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
        body: FutureBuilder(
          future: Provider.of<ApiManager>(context).questionApi(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              ResponseQuestion responseQuestion = snapshot.data;
              List<Data> response = responseQuestion.data;

              return Stack(
                children: [

                  PageView.builder(
                      controller: controller,
                           physics: NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: response.length,
                          itemBuilder: (context,index){
                            print("index"+'${response.length-1}'.toString());
                            newIndex = response.length-1;
                            selectQuestion = index+1;
                            return Container(
                              padding: EdgeInsets.all(20),
                              // color: Colors.black87,
                              child: Column(
                                children: <Widget>[

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Question "+selectQuestion.toString()+": "+response[index].question.question,style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0XFF2CB5C3),
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic
                                    ),),
                                  ),
                                  Column(
                                    children: [
                                      Column(
                                        children: [

                                          ListTile(
                                            onTap: (){
                                              setState(() {
                                                selectedIndex = index;
                                                selectedIndex2 = 5;
                                                selectedIndex3 = 5;
                                                selectedIndex1 = 5;
                                                checkIndex = index;
                                                answer = response[index].question.optionA;
                                                questions.add(response[index].question.id);
                                              });
                                              },
                                            leading: Container(
                                              margin: EdgeInsets.only(top: 3),
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                color: selectedIndex == index?Colors.black:Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(color: selectedIndex == index?Colors.black:Colors.blueGrey,width: 3),
                                                // border: Border.all(color: selectedIndex == index? Colors.black:Colors.blueGrey,width: 2),
                                                // color: selectedIndex == index? Colors.black:Colors.white
                                              ),
                                            ),
                                            title: Transform.translate(
                                              offset: Offset(-20, 0),
                                              child: Text(response[index].question.optionA,style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0XFF585A59),
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            ),
                                          ),

                                          ListTile(
                                            onTap: (){
                                              setState(() {
                                                selectedIndex = 5;
                                                selectedIndex2 = 5;
                                                selectedIndex3 = 5;
                                                selectedIndex1 = index;
                                                answer = response[index].question.optionB;
                                                questions.add(response[index].question.question);
                                                checkIndex = index;
                                              });
                                            },
                                            leading: Container(
                                              margin: EdgeInsets.only(top: 3),
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                color: selectedIndex1 == index?Colors.black:Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(color: selectedIndex1 == index?Colors.black:Colors.blueGrey,width: 3),
                                                /*borderRadius: BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(color:selectedAnswer == response[index].question.optionB?Colors.black:Colors.blueGrey,width: 3),*/
                                                // color: selectedIndex1 == index? Colors.black:Colors.white
                                              ),
                                            ),
                                            title: Transform.translate(
                                              offset: Offset(-20, 0),
                                              child: Text(response[index].question.optionB,style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0XFF585A59),
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            ),
                                          ),

                                          ListTile(
                                            onTap: (){
                                              setState(() {
                                                selectedIndex = 5;
                                                selectedIndex1 = 5;
                                                selectedIndex3 = 5;
                                                selectedIndex2 = index;
                                                checkIndex = index;
                                                answer = response[index].question.optionC;
                                                questions.add(response[index].question.question);
                                              });
                                            },
                                            leading: Container(
                                              margin: EdgeInsets.only(top: 3),
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                color: selectedIndex2 == index?Colors.black:Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(color: selectedIndex2 == index?Colors.black:Colors.blueGrey,width: 3),
                                                // color: selectedIndex2 == index? Colors.black:Colors.white
                                              ),
                                            ),
                                            title: Transform.translate(
                                              offset: Offset(-20, 0),
                                              child: Text(response[index].question.optionC,style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0XFF585A59),
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            ),
                                          ),

                                          ListTile(
                                            onTap: (){
                                              setState(() {
                                                checkIndex = index;
                                                selectedIndex = 5;
                                                selectedIndex1 = 5;
                                                selectedIndex2 = 5;
                                                selectedIndex3 = index;
                                                answer = response[index].question.optionD;
                                                questions.add(response[index].question.question);
                                              });
                                            },
                                            leading: Container(
                                              margin: EdgeInsets.only(top: 3),
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(color: selectedAnswer == response[index].question.optionD?Colors.black:Colors.blueGrey,width: 3),
                                                color: selectedIndex3 == index? Colors.black:Colors.white
                                              ),
                                            ),
                                            title: Transform.translate(
                                              offset: Offset(-20, 0),
                                              child: Text(response[index].question.optionD,style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0XFF585A59),
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            ),
                                          ),

                                        ],
                                      ),

                                      SizedBox(height: 10,),

                                      TextFormField(
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                              labelText: "Enter description",
                                              labelStyle: TextStyle(
                                                  color: Color(0XFFDBDDDC),
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600
                                              ),
                                              // hintText: "Name/Business Name",
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0XFFDBDDDC)),
                                                  borderRadius: BorderRadius.circular(25)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0XFFDBDDDC)),
                                                  borderRadius: BorderRadius.circular(25)
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0XFFDBDDDC)),
                                                  borderRadius: BorderRadius.circular(25)
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 35,vertical: 35)
                                          )
                                      )
                                    ],
                                  ),

                                  SizedBox(height: 20,),

                                ],
                              ),
                            );
                          }),

                  if(checkSubmitButton==true)
                    Positioned(
                      bottom: 10,
                      left: 28,
                      right: 28,
                      child: ElevatedButton(
                        onPressed: (){
                          Provider.of<ApiManager>(context,listen: false).questionSubmitApi(questions, ansList, ansList);
                          },
                        child: Text("Submit",
                          style: TextStyle(
                              fontSize: 16
                          ),),
                      ))
                  else
                    Positioned(
                      bottom: 10,
                      right: 15,
                      child: InkWell(
                        onTap: ()async{
                          if(answer==""){
                            Fluttertoast.showToast(msg: "Please select answer");
                          }else{
                            if(checkIndex == newIndex){
                              print("ab");
                              setState(() {
                                ansList.add(answer);
                                checkSubmitButton = true;
                              });
                            }else{
                              print("cd");
                              ansList.add(answer);
                              answer = "";
                              print("answerList"+ansList.toString());
                              controller.nextPage(duration: _kDuration, curve: _kCurve);
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.arrow_forward_ios,size: 30,),
                  ),
                      ))
                ],
              );
            }else{
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()),
                  ),
              );
            }
          },
        ),
    );
  }
}