import 'package:flutter/material.dart';
import 'package:sqf_note_app/sqf_configration/sqldb.dart';
import 'package:sqf_note_app/view/home%20Page.dart';

class EditNotes extends StatefulWidget {
  int id;
  String title;
  String note;
   EditNotes({super.key, required this.id, required this.title, required this.note});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sql = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    title.text = widget.title;
    note.text=widget.note;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل الملاحضة"),
      ),
      body: ListView(
        children: [
          Form(
              key: formstate,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(hintText: "العنوان"),
                    ),
                    TextFormField(
                      controller: note,
                      decoration: const InputDecoration(hintText: "المحتوى"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: MaterialButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () async {
                          // int responce = await sql.updateData( '''
                          //     UPDATE notes SET
                          //     title = "${title.text}" ,
                          //     note = "${note.text}"
                          //     WHERE id = ${widget.id}
                          //         ''');

                          int responce = await sql.update("notes",
                              {
                                "title" : title.text ,
                                "note" : note.text ,
                              },
                              "id =${widget.id}");
                          if(responce >0  ){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomePage()) , (route)=>false );
                          }
                        },
                        child:const  Text("تعديل"),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
