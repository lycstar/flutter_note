import 'package:flutter/material.dart';
import 'package:flutter_note/network.dart';
import 'package:flutter_note/note.dart';
import 'package:flutter_note/util.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();

  final callback;

  final Note note;

  EditPage(this.callback, {this.note});
}

class _EditPageState extends State<EditPage>
    with AutomaticKeepAliveClientMixin {
  var _time = "";
  final _contentController = TextEditingController();

  @override
  void initState() {
    var now = new DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd  HH:mm');
    _time = formatter.format(now);
    if (widget.note != null) _contentController.text = widget.note.content;
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  _insertOrUpdateNote() {
    if (_contentController.text.isNotEmpty) {
      if (widget.note != null)
        _updateNote();
      else
        _insertNote();
    }
  }

  _insertNote() {
    Note note =
        Note(username: username, content: _contentController.text, time: _time);
    insertNote(note, token).then(
      (map) {
        if (verifyRequestResult(map)) {
          widget.callback();
        }
      },
    );
  }

  _updateNote() {
    Note note = Note(
      id: widget.note.id,
      username: username,
      content: _contentController.text,
      time: _time,
    );
    updateNote(note, token).then((map) {
      if (verifyRequestResult(map)) {
        widget.callback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xfff5c247),
            size: 20,
          ),
          onPressed: () {
            _insertOrUpdateNote();
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(
                Icons.check,
                size: 25,
                color: Color(0xfff5c247),
              ),
              onPressed: () {
                _insertOrUpdateNote();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "$_time | ${_contentController.text.length}字",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                  height: 1.2,
                  color: Colors.black45,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                onChanged: (str) {
                  /*实时响应字数*/
                  setState(() {
                    _contentController.text;
                  });
                },
                controller: _contentController,
                decoration: null,
                cursorColor: Colors.blueAccent,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                  height: 1.2,
                ),
                maxLines: 10000,
                textInputAction: TextInputAction.newline,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
