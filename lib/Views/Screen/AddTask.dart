import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskit/helper/FbStoreHelper.dart';
import 'package:taskit/views/utility/CategoryList.dart';

import '../../Model/CategoryModal.dart';
import '../../Model/TaskitModal.dart';
import '../../controller/TaskitController.dart';
import '../../controller/ThemeController.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TaskitModal taskit = TaskitModal();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDark = Provider.of<ThemeController>(context).isDark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('ADD Task',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<TaskitController>(builder: (context, task, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Title',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        child: TextFormField(
                          controller: titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your task title';
                            }

                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {},
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDark
                                ? Colors.black.withOpacity(0.5)
                                : Color(0xE7EBEBF1),
                            hintText: 'Enter your task title',
                            hintStyle: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text('Category',
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Container(
                        height: size.height * 0.11,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: ((context, index) {
                              CategoryModal category = categories[index];
                              return GestureDetector(
                                onTap: () {
                                  task.changeCategory(category.name);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  width: size.width * 0.14,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        child: Image.asset(
                                          category.icon,
                                          color:
                                              Colors.primaries[index].shade900,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors
                                                .primaries[index].shade200,
                                            border:
                                                task.category == category.name
                                                    ? Border.all(
                                                        color: Colors.black,
                                                        width: 1)
                                                    : null),
                                      ),
                                      Text(
                                        category.name,
                                        style: TextStyle(
                                            fontSize:
                                                task.category == category.name
                                                    ? 10
                                                    : 10,
                                            fontWeight:
                                                task.category == category.name
                                                    ? FontWeight.bold
                                                    : FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })),
                      ),
                      Text('Select Start Date',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        width: size.width * 0.45,
                        decoration: BoxDecoration(
                            color: isDark
                                ? Colors.black.withOpacity(0.5)
                                : Color(0xE7EBEBF1),
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5),
                          child: Consumer<TaskitController>(
                              builder: (context, pro, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${pro.date}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      pro.showMyDate(context);
                                    },
                                    icon: const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                    )),
                              ],
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text('Select Due Date & Time',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.width * 0.45,
                            decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.black.withOpacity(0.5)
                                    : Color(0xE7EBEBF1),
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5),
                              child: Consumer<TaskitController>(
                                  builder: (context, pro, child) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "${pro.duadate}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          pro.showMydDate(context);
                                        },
                                        icon: const Icon(
                                          Icons.calendar_today_outlined,
                                          size: 16,
                                        )),
                                  ],
                                );
                              }),
                            ),
                          ),
                          Container(
                            width: size.width * 0.32,
                            decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.black.withOpacity(0.5)
                                    : Color(0xE7EBEBF1),
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5),
                              child: Consumer<TaskitController>(
                                  builder: (context, pro, child) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("${pro.duatime}"),
                                    IconButton(
                                        onPressed: () async {
                                          pro.showMyTime(context);
                                          '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
                                        },
                                        icon: const Icon(
                                          Icons.access_time_rounded,
                                          size: 20,
                                        )),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        'Task Description / Notes',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your task title';
                          }

                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {},
                        maxLines: 5,
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark
                              ? Colors.black.withOpacity(0.5)
                              : Color(0xE7EBEBF1),
                          hintText: 'Enter your task title',
                          hintStyle: GoogleFonts.openSans(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      taskit.title = titleController.text;
                      taskit.description = descriptionController.text;
                      taskit.category = task.category;
                      taskit.date = task.date;
                      taskit.duedate = task.duadate;
                      taskit.duetime = task.duatime;
                      taskit.status = false;
                      await FbStoreHelper.fbStoreHelper.addTasks(task: taskit);

                      task.category = '';
                      task.date = DateFormat.yMMMd().format(DateTime.now());

                      task.duadate = DateFormat.yMMMd().format(DateTime.now());

                      task.duatime =
                          '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';

                      // task.sendNotification(
                      //     'New Task Added', taskit.title ?? '');

                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark
                          ? Colors.white.withOpacity(0.5)
                          : Color(0xff0f1933),
                    ),
                    child: Text('ADD Task',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
