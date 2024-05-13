

import 'package:flutter/material.dart';
import 'package:sqf_note_app/view/addNotes.dart';
import 'package:sqf_note_app/view/editNotes.dart';
import '../sqf_configration/sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sql = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future showData() async {
    // List<Map> responce = await sql.readData("select * from 'notes' ");
    List<Map> responce = await sql.read("notes");

    notes.addAll(responce);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    showData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.withOpacity(0.4),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.withOpacity(0.0),

        title: const Text("Note App" , style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("${notes[index]['title']}"),
                          subtitle: Text("${notes[index]['note']}"),
                          // trailing: ,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                // int response = await sql.deleteData(
                                //     "DELETE FROM notes WHERE id = ${notes[index]['id']}");
                                int responce = await sql.delete("notes", "id = ${notes[index]['id']}");

                                if (responce > 0) {
                                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
                                  if (responce > 0) {
                                    notes.removeWhere((element) =>
                                    element['id'] == notes[index]['id']);
                                    setState(() {});
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditNotes(
                                  id: notes[index]['id'],
                                  title: notes[index]['title'],
                                  note: notes[index]['note'],
                                )));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddNotes()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
