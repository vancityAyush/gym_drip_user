import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/screen/feedlistdetail.dart';

class ViewAllTransformation extends StatelessWidget {

  final String data;
  ViewAllTransformation({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Text("",style: TextStyle(
            color: Colors.white,
            fontSize: 19
        ),),
      ),
      body: FutureBuilder(
        future: Provider.of<ApiManager>(context).fetchTransFormationApi(data),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FeedListDetail(image:snapshot.data['data'][index]['image'],name:snapshot.data['data'][index]['certificate_type'],description:snapshot.data['data'][index]['description'])));
                      },
                      child: Card(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:  Image.network("http://fitnessapp.frantic.in/"+snapshot.data['data'][index]['image'],height: 185,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,)),

                              SizedBox(height: 10,),

                              SizedBox(height: 5,),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(snapshot.data['data'][index]['description'],style: TextStyle(
                                    color: Color(0XFFC9C9C9),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13
                                ),),
                              ),

                              SizedBox(height: 7,),
                            ],
                          ),
                        ),
                      ),
                    )
                );
              },
            );
          }else{
            return Text("");
          }
        },
      ),
    );
  }
}