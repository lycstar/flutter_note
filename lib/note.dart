/// id : 1
/// username : "lycstar"
/// content : "轻轻的我走了，\r\n正如我轻轻的来；\r\n我轻轻的招手，\r\n作别西天的云彩。\r\n那河畔的金柳，\r\n是夕阳中的新娘；\r\n波光里的艳影，\r\n在我的心头荡漾。\r\n软泥上的青荇，\r\n油油的在水底招摇；\r\n在康河的柔波里，\r\n我甘心做一条水草！\r\n那榆荫下的一潭，\r\n不是清泉，\r\n是天上虹；\r\n揉碎在浮藻间，\r\n沉淀着彩虹似的梦。\r\n寻梦？\r\n撑一支长篙，\r\n向青草更青处漫溯；\r\n满载一船星辉，\r\n在星辉斑斓里放歌。\r\n但我不能放歌，\r\n悄悄是别离的笙箫；\r\n夏虫也为我沉默，\r\n沉默是今晚的康桥！\r\n悄悄的我走了，\r\n正如我悄悄的来；\r\n我挥一挥衣袖，\r\n不带走一片云彩。"

class Note {
  int id;
  String username;
  String content;
  String time;

  Note({this.id, this.username, this.content, this.time});

  static Note fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Note note = Note();
    note.id = map['id'] ?? 0;
    note.username = map['username'] ?? "";
    note.content = map['content'] ?? "";
    note.time = map['time'] ?? "";
    return note;
  }
}
