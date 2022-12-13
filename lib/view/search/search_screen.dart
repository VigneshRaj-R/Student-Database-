import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data/view/show/show_screen.dart';
import 'package:student_data/provider/student_list.dart';
import 'package:student_data/widgets/delete_verification.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.close))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<StudentListProvider>(
        builder: (context, studentData, Widget? child) {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            final data = studentData.studentList[index];
            if (query == data.name.toLowerCase() ||
                query == data.name.toUpperCase()) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      MemoryImage(const Base64Decoder().convert(data.image)),
                  radius: 35,
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      (MaterialPageRoute(builder: (ctx) {
                        return ShowScreen(data: data, index: index);
                      })),
                      (route) => false);
                },
                title: Text(data.name.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    )),
                trailing: IconButton(
                  onPressed: () {
                    DeleteVerification(context: context, index: index)
                        .deleteFunction();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
          itemCount:studentData.studentList.length,
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Consumer<StudentListProvider>(
          builder: (context, studentData, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = studentData.studentList[index];
            if (data.name.toLowerCase().contains(query)) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          MemoryImage(const Base64Decoder().convert(data.image)),
                      radius: 35,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        (MaterialPageRoute(builder: (ctx) {
                          return ShowScreen(data: data, index: index);
                        })),
                      );
                    },
                    title: Text(
                      data.name.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        DeleteVerification(context: context, index: index)
                            .deleteFunction();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
          itemCount : studentData.studentList.length,
        );
      }),
    );
  }
}
