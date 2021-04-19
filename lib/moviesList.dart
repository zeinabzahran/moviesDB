import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'moviesModel.dart';

class Movies extends StatefulWidget {
  final MoviesModel movies;
  Movies({Key key, this.movies}) : super(key: key);
  @override
  MoviesState createState() => MoviesState();
}

class MoviesState extends State<Movies>{
  TextEditingController searchText = TextEditingController();
  MoviesModel movies;
  List <Result> searchList=[];
  bool searchFlag=false;

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    movies=widget.movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*.07,
                    color: Colors.white,
                    child: Row(children: [
                          IconButton(icon:Icon(Icons.arrow_back),
                          onPressed: (){
                            if(searchFlag)
                              setState(() {
                                searchFlag=false;
                                searchList.clear();
                                searchText.text='';
                              });
                            else
                              SystemNavigator.pop();
                            },
                          ),
                      Container(
                        height:MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width * .75,
                        child: TextField(
                          controller: searchText,
                          onSubmitted: (searchText) async {                            //Search
                            searchList.clear();
                            searchFlag=true;
                            for(int i=0; i<movies.results.length;i++){
                              if(movies.results[i].title.toLowerCase().contains(searchText.toLowerCase())){
                                setState(() {
                                  searchList.add(movies.results[i]);
                                });
                              }
                            }
                            },
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search by name',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                          IconButton(icon:Icon(Icons.more_vert),
                          onPressed: (){                                      // Do sth
                          },),
                    ],),
                  ),
                  searchFlag&&searchList.isEmpty || searchFlag==false&&movies==null?
                  Container(height: MediaQuery.of(context).size.height*.88,
                    width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: MediaQuery.of(context).size.width*.05),
                  child: Text('No results'),
                  )
                      :Container(
                          height: MediaQuery.of(context).size.height*.88,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: searchFlag?searchList.length:movies.results.length,  // it is movies.totalResults/movies.totalPages
                          itemBuilder: _buildListView,
                        ),
                      ),
                ],
              ),
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height*.005, horizontal: MediaQuery.of(context).size.width*.05),
      child: InkWell(
        onTap: ()async{    ///////////Nav to next screen
        print("Nav to next screen");
          },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: MediaQuery.of(context).size.height*.15,
            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*.03,
                      horizontal:MediaQuery.of(context).size.width*.05),
                  width: MediaQuery.of(context).size.width*.15,
                  height: MediaQuery.of(context).size.height*.17,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                    child: Image.network(searchFlag?'https://image.tmdb.org/t/p/original/'+searchList[index].posterPath:
                    'https://image.tmdb.org/t/p/original/'+movies.results[index].posterPath,
                      fit: BoxFit.fill,
                  ),
                  ),
                ),
                Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child:
                             Container(
                               width: MediaQuery.of(context).size.width*.5,
                               height:MediaQuery.of(context).size.height*.2,
                               margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.height*.03,0,0),
                               child: Text(searchFlag?searchList[index].title:movies.results[index].title,style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 18
                               ),),
                             ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*.5,
                          margin: EdgeInsets.fromLTRB(0,0,0,MediaQuery.of(context).size.height*.035),
                                  child: Text('Movie',style: TextStyle(    // Static for now, It has no corresponding field
                                    color: Colors.white
                                  ),),),
                      ],
                    ),
                Padding(
                    padding:EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.height*.063,0,0),
                    child: Row(
                      children:[Icon(Icons.star,
                            color: Colors.yellow),
                        Text(searchFlag?searchList[index].voteAverage.toString():movies.results[index].voteAverage.toString(),style: TextStyle(
                          color: Colors.white,
                        ),)
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}