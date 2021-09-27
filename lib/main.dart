import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'network/network_request.dart';
import 'model/post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: ListViewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListViewPage extends StatefulWidget {
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  List<Post> postData = [];

  @override
  void initState() {
    super.initState();
    NetworkRequest.fetchPosts().then((dataFromServer) {
      setState(() {
        postData = dataFromServer;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Request'),
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            padding: EdgeInsets.all(10),
              itemCount: postData.length,
              itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${postData[index].id}.${postData[index].title}', style: TextStyle(
                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        height: 5,
                      ),
                      Text('${postData[index].body}', style: TextStyle(
                          fontSize: 14, color: Colors.blue
                      ),)
                    ],
                  ),
                ),
              );
              }
          ))
        ],
      ),
    );
  }
}
