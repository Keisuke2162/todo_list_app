
import 'package:check_list_app/task_model.dart';

// テストデータ1: フットサル
Task test1_1 = Task("シューズ", false);
Task test1_2 = Task("ボール", false);
Task test1_3 = Task("シャツ", false);
Task test1_4 = Task("パンツ", false);
Task test1_5 = Task("ソックス", false);
Task test1_6 = Task("ソックス", false);
Task test1_7 = Task("ソックス", false);
Task test1_8 = Task("ソックス", false);
Task test1_9 = Task("ソックス", false);
Task test1_10 = Task("ソックス", false);
Task test1_11 = Task("ソックス", false);
Task test1_12 = Task("ソックス", false);
Task test1_13 = Task("ソックス", false);
Task test1_14 = Task("ソックス", false);
Task test1_15 = Task("ソックス", false);
Task test1_16 = Task("ソックス", false);
Task test1_17 = Task("ソックス", false);
Task test1_18 = Task("ソックス", false);
Task test1_19 = Task("ソックス", false);
Task test1_20 = Task("ソックス", false);
List<Task> taskList1 = [test1_1, test1_2, test1_3, test1_4, test1_5,test1_6,test1_7,test1_8,test1_9,test1_10,test1_11,test1_12,test1_13,test1_14,test1_15,test1_16,test1_17,test1_18,test1_19,test1_20];
ParentTask testParentTask1 = ParentTask("フットサル", taskList1);


// テストデータ2: 旅行
Task test2_1 = Task("靴下", false);
Task test2_2 = Task("着替え", false);
Task test2_3 = Task("シャンプー", false);
Task test2_4 = Task("石鹸", false);
Task test2_5 = Task("財布", false);
List<Task> taskList2 = [test2_1, test2_2, test2_3, test2_4, test2_5];
ParentTask testParentTask2 = ParentTask("旅行", taskList2);

List<ParentTask> testData = [testParentTask1, testParentTask2];