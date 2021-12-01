import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String text;
  final bool checked;
  final Function removeTodo;


  const TodoItem({this.text = '', this.checked = false, required this.removeTodo });
  @override
  State<StatefulWidget> createState() {
    return _TodoItem(text, checked, removeTodo);
  }
}

class _TodoItem extends State<TodoItem> {
  bool checked = false;
  String text;
  Function removeTodo;


  _TodoItem(this.text, this.checked, this.removeTodo);


  TextStyle getTextStyle () => TextStyle(
    color: checked ? Colors.green[700] : Colors.black,
    fontFamily: "Rubik",
    fontSize: 18.0,
    decoration: checked ? TextDecoration.lineThrough : TextDecoration.none,
    decorationColor: Colors.grey[500],
  );


  @override
  Widget build(BuildContext context) {
    return Container (
      padding: const EdgeInsets.only(left: 15, right: 5),
      margin: const EdgeInsets.only(top:0, bottom:0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide.none, left: BorderSide.none, right: BorderSide.none, bottom: BorderSide(color: Colors.grey ,width:1, style: BorderStyle.solid)),
        color: checked ? Colors.green[100] : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: getTextStyle(),
          ),
          Container(
              margin: const EdgeInsets.only(left: 40),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: checked,
                    activeColor: Colors.green[700],
                    onChanged: (value) => {setState(() {
                      checked = (value == 'true' || value == true);
                    })},
                  ),
                  IconButton(
                    icon: const Icon(
                        Icons.delete
                    ),
                    tooltip: 'Remover tarefa',
                    onPressed: () => removeTodo(text),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}