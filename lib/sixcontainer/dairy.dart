import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/hive/hive.dart';
import 'package:healthcare/sixcontainer/util/dialogbox.dart';
import 'package:hive_flutter/adapters.dart';

class DiaryPge extends StatefulWidget {
  const DiaryPge({super.key});

  @override
  State<DiaryPge> createState() => _DiaryPgeState();
}

class _DiaryPgeState extends State<DiaryPge> {
  final _myBox = Hive.box("mybox");
  DiaryDataBase db = DiaryDataBase();
  @override
  void initState() {
    if (_myBox.get("DIARY") == null) {
      db.diaryList = [];
      // const Text("Data is Not Found");
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  @override
  void checkBoxValue(bool? value, int index) {
    setState(() {
      db.diaryList[index][1] = !db.diaryList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.diaryList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void CreateNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void clearTextForm() {
    setState(() {
      _controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.diaryList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: const Color(0xff7a73e7),
        title: const Text("DIARY"),
        centerTitle: true,
      ),
      body: Center(
        child: db.diaryList.isEmpty
            ? Text(
                ' No Diary is Not Found ',
                style: GoogleFonts.poppins(),
              )
            : Container(
                color: const Color(0xff7a73e7).withOpacity(0.09),
                child: ListView.builder(
                  itemCount: db.diaryList.length,
                  itemBuilder: (context, index) {
                    return DiaryContainer(
                      size: size,
                      taskName: db.diaryList[index][0],
                      taskCompleted: db.diaryList[index][1],
                      onChanged: (value) => checkBoxValue(value, index),
                      deleteFunction: (p0) => deleteTask(index),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreateNewTask();
          clearTextForm();
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff7a73e7),
      ),
    );
  }
}

class DiaryContainer extends StatelessWidget {
  DiaryContainer(
      {super.key,
      required this.size,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction});

  final Size size;
  final String taskName;
  bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: size.width,
        child: Slidable(
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent.shade200,
            )
          ]),
          child: Container(
            padding: const EdgeInsets.all(24),

            // ignore: sort_child_properties_last
            child: Row(
              children: [
                Checkbox(
                  activeColor: const Color(0xff7a73e7),
                  value: taskCompleted,
                  onChanged: onChanged,
                ),
                Text(
                  taskName,
                  style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
