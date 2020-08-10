import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_screen.dart';

import 'package:intl/intl.dart';

import 'new_post.dart';

class ListScreen extends StatefulWidget {
  static final routeName = '/';

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  int quantity = 0;

  void getWasteCount() async {
    quantity = 0;
    QuerySnapshot snapshot =
        await Firestore.instance.collection('posts').getDocuments();
    snapshot.documents.forEach(
      (element) {
        quantity += element.data['quantity'];
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getWasteCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wasteagram - $quantity"),
        backgroundColor: Color(0xFF225374),
      ),
      body: ListStream(),
      bottomNavigationBar: Semantics(
        hint: 'Upload a new post',
        child: GestureDetector(
          child: Container(
            height: 50,
            child: BottomAppBar(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              color: Color(0xFF225374),
            ),
          ),
          onTap: () => makeNewPost(),
        ),
      ),
    );
  }

  void makeNewPost() async {
    var result = await Navigator.pushNamed(context, NewPost.routeName);
    if (result.toString() == 'update') {
      getWasteCount();
    }
  }
}

class ListStream extends StatefulWidget {
  @override
  _ListStreamState createState() => _ListStreamState();
}

class _ListStreamState extends State<ListStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('posts')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (content, snapshot) {
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (content, index) {
                    var post = snapshot.data.documents[index];
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(DateFormat('MMMM dd, yyyy')
                              .format((post['date'].toDate()))),
                          trailing: Text(post['quantity'].toString()),
                          onTap: () => Navigator.pushNamed(
                              context, DetailScreen.routeName,
                              arguments: snapshot.data.documents[index]),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
