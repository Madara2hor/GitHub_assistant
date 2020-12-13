import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_assistant/Helpers/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:github_assistant/Models/user_model.dart';
import 'package:http/http.dart' as http;

import 'info_page.dart';

class UserPage extends StatelessWidget {
  final UserModel user;
  const UserPage({@required this.user});
  static Map<String, String> menuItems = {};

  @override
  Widget build(BuildContext context) {
    initMenuItems();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          title: Text("Поиск",
              style: TextStyle(color: AppColors.textColor, fontSize: 18)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(16),
                child: CachedNetworkImage(
                  imageUrl: user.avatar_url != null && user.avatar_url != ""
                      ? user.avatar_url
                      : 'https://cdn.pixabay.com/photo/2016/04/15/18/05/computer-1331579_960_720.png',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageBuilder: (context, imageProvider) => Container(
                    child: CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 70.0,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                user.login,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: AppColors.textColor),
              ),
            ),
            Flexible(
              flex: 2,
              child: buildUsersDataList(),
            )
          ],
        ));
  }

  Widget buildUsersDataList() {
    return user != null
        ? ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await http
                      .get(menuItems.values.toList()[index])
                      .then((response) {
                    var responseMap = jsonDecode(response.body);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoPage(
                                  infoData: responseMap,
                                  username: user.login,
                                )));
                  }).catchError((error) {
                    print("Error: $error");
                  });
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: AppColors.mainColor,
                  shadowColor: AppColors.textColor,
                  child: Container(
                      margin: const EdgeInsets.only(left: 8, top: 4),
                      height: 25,
                      child: Text(menuItems.keys.toList()[index],
                          style: TextStyle(
                              color: AppColors.textColor, fontSize: 18))),
                ),
              );
            })
        : Center(child: Text("Ошибка получения данных"));
  }

  initMenuItems() {
    menuItems['Подписчики'] = user.followers_url;
    menuItems['Подписок'] = user.url + "/following";
    menuItems['Репозитории'] = user.repos_url;
  }
}
