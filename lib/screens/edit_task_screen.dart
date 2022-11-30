import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/data/task.dart';
import 'package:note_app/widgets/task_type_item.dart';
import 'package:note_app/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTask extends StatefulWidget {
  EditTask({Key? key, required this.task}) : super(key: key);
  Task task;
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;
  final box = Hive.box<Task>('taskBox');
  DateTime? _time;
  int _selectedTaskTypeItem = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    negahban1.addListener(() {
      setState(() {});
      negahban2.addListener(() {
        setState(() {});
      });
    });
    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selectedTaskTypeItem = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: TextField(
                  controller: controllerTaskTitle,
                  focusNode: negahban1,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    labelText: 'عنوان تسک',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: negahban1.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xffC5C5C5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide:
                          BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xff18DAA3),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: TextField(
                  controller: controllerTaskSubTitle,
                  maxLines: 2,
                  focusNode: negahban2,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    labelText: 'توضیحات',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: negahban2.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xffC5C5C5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide:
                          BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xff18DAA3),
                      ),
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CustomHourPicker(
                  title: 'زمان تسک رو انتخاب کن',
                  positiveButtonText: 'انتخاب زمان',
                  negativeButtonText: 'حذف',
                  elevation: 1,
                  titleStyle: TextStyle(
                    color: Color(0xff18DAA3),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  positiveButtonStyle: TextStyle(
                    color: Color(0xff18DAA3),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  negativeButtonStyle: TextStyle(
                    color: Color.fromARGB(255, 226, 106, 8),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                  onNegativePressed: (context) {},
                ),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskTypeList().length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTaskTypeItem = index;
                          });
                        },
                        child: getTaskTypeItemList(
                          index: index,
                          selectedItemList: _selectedTaskTypeItem,
                          taskType: getTaskTypeList()[index],
                        ),
                      );
                    }),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  String taskTitle = controllerTaskTitle!.text;
                  String taskSubTitle = controllerTaskSubTitle!.text;
                  editTask(taskTitle, taskSubTitle);
                  Navigator.pop(context);
                },
                child: Text(
                  'ویرایش تسک',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff18DAA3),
                  minimumSize: Size(200, 45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  editTask(String title, String subTitle) {
    widget.task.title = title;
    widget.task.subTitle = subTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeItem];
    widget.task.save();
  }
}
