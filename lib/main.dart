import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'API Test Case!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchTextController = TextEditingController();
  String searchList = "https://images.dog.ceo/breeds/dalmatian/cooper1.jpg";

  void _search() {
    // String str = searchTextController.text;
    RequestService.query().then((response) {
      setState(() {
        searchList = response["message"];
      });
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      child: OutlinedButton(
                        onPressed: _search,
                        child: Text("Generate!"),
                      ),
                    ),
                  ]),
              SizedBox(
                height: 10,
              ),
              Image.network(searchList),
              // Expanded(
              //   // child: SingleChildScrollView(
              //   //   child: ListView.builder(
              //   //     primary: false,
              //   //     itemBuilder: (BuildContext context, int index) =>
              //   //         new WikiSearchItemWidget(searchList[index]),
              //   //     itemCount: searchList.length,
              //   //     shrinkWrap: true,
              //   //   ),
              //   // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class WikiSearchItemWidget extends StatelessWidget {
//   final WikiSearchEntity _entity;

//   WikiSearchItemWidget(this._entity);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         _entity.title,
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//       subtitle: SingleChildScrollView(
//         child: Html(data: _entity.snippet),
//       ),
//       onTap: () {},
//     );
//   }
// }

class RequestService {
  static Future query() async {
    var response =
        await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    // Check if response is success
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var map = json.decode(response.body);
      print(map);
      return map;
    } else {
      print("Query failed: ${response.body} (${response.statusCode})");
      return null;
    }
  }
}

// class DogResponse {
//   String message;
//   String status;

//   factory DogResponse.fromJson(Map<String, dynamic> json) =>
//       DogResponse(
//           message: json["batchcomplete"],
//           status: DogResponse.fromJson(json["query"]));
// }

// class WikiQueryResponse {
//   List<WikiSearchEntity> search;

//   WikiQueryResponse({required this.search});

//   factory WikiQueryResponse.fromJson(Map<String, dynamic> json) {
//     List<dynamic> resultList = json['search'];
//     List<WikiSearchEntity> search = resultList
//         .map((dynamic value) => WikiSearchEntity.fromJson(value))
//         .toList(growable: false);
//     return WikiQueryResponse(search: search);
//   }
// }

// class WikiSearchEntity {
//   int ns;
//   String title;
//   int pageId;
//   int size;
//   int wordCount;
//   String snippet;
//   String timestamp;
//   WikiSearchEntity(
//       {required this.ns,
//       required this.title,
//       required this.pageId,
//       required this.size,
//       required this.wordCount,
//       required this.snippet,
//       required this.timestamp});

//   factory WikiSearchEntity.fromJson(Map<String, dynamic> json) =>
//       WikiSearchEntity(
//           ns: json["ns"],
//           title: json["title"],
//           pageId: json["pageid"],
//           size: json["size"],
//           wordCount: json["wordcount"],
//           snippet: json["snippet"],
//           timestamp: json["timestamp"]);
// }
