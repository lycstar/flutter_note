import 'package:flutter/material.dart';
import 'package:flutter_note/edit.dart';
import 'package:flutter_note/network.dart';
import 'package:flutter_note/note.dart';
import 'package:flutter_note/util.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _queryNotes();
  }

  _queryNotes() {
    queryNotes(username, token).then((map) {
      if (verifyRequestResult(map)) {
        setState(() {
          _notes.clear();
          for (int i = map['data'].length - 1; i >= 0; i--) {
            _notes.add(Note.fromMap(map['data'][i]));
          }
        });
      }
    });
  }

  _deleteNote(Note note) {
    deleteNote(note, token).then((map) {
      if (verifyRequestResult(map)) {
        showToast(map['msg']);
        _queryNotes();
      }
    });
  }

  Future<void> _refresh() async {
    _queryNotes();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text("云便签"),
        centerTitle: true,
        leading: Hero(
          tag: "account",
          child: IconButton(
            icon: Icon(Icons.face),
            onPressed: () {
              Navigator.of(context).pushNamed('/account');
            },
          ),
        ),
      ),
//      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffffc000),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return EditPage(_queryNotes);
              },
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: _notes.length == 0
          ? Container(
              child: Center(
                child: Text(
                  "空空如也，也是一种态度",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          : RefreshIndicator(
              child: Container(
                padding: EdgeInsets.all(4.0),
                color: Color(0xfff5f5f5),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: _notes.length,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (BuildContext context, int index) =>
                      noteItem(context, _notes[index]),
                  staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ),
              onRefresh: _refresh,
            ),
    );
  }

  Widget noteItem(BuildContext context, Note note) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return EditPage(_queryNotes, note: note);
        }));
      },
      onLongPress: () {
        showAlertDialog(note);
      },
      child: Container(
//      margin: EdgeInsets.only(left: 5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          elevation: 1,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  note.content.length >= 120
                      ? "${note.content.substring(0, 80)}..."
                      : note.content,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    note.time,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDialog(Note note) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text("提示"),
            content: Text(
              '是否删除   "${note.content.length >= 30 ? note.content.substring(0, 30) : note.content}..."   ?',
              overflow: TextOverflow.ellipsis,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("返回"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () {
                  _deleteNote(note);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
