import 'package:note_app/data/model/task_type.dart';
import 'package:note_app/data/model/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
        image: 'images/hard_working.png',
        title: 'کار عمیق',
        taskTypeEnum: TaskTypeEnum.working),
    TaskType(
        image: 'images/social_friends.png',
        title: 'میتینگ دوستانه',
        taskTypeEnum: TaskTypeEnum.meeting),
    TaskType(
        image: 'images/meditate.png',
        title: 'تمرکز',
        taskTypeEnum: TaskTypeEnum.focus),
    TaskType(
        image: 'images/work_meeting.png',
        title: 'میتینگ کاری',
        taskTypeEnum: TaskTypeEnum.workMeeting),
    TaskType(
        image: 'images/banking.png',
        title: 'کار بانکی',
        taskTypeEnum: TaskTypeEnum.bank),
  ];
  return list;
}
