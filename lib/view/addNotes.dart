import 'package:flutter/material.dart';
import 'package:sqf_note_app/sqf_configration/sqldb.dart';
import 'package:sqf_note_app/view/home%20Page.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sql = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اضافة ملاحضة"),
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
                          // int respnce = await sql.insertData(
                          // 'INSERT INTO notes (title , note) VALUES ("${title.text}" , "${note.text}")');

                          int responce = await sql.insert("notes" , {
                            "title" : title.text,
                            "note" : note.text,
                          });
                          if(responce != null ){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomePage()) , (route)=>false );
                          }
                        },
                        child:const  Text("حفظ"),
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
