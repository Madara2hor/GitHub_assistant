import 'package:flutter/material.dart';
import 'package:github_assistant/Helpers/app_colors.dart';
import 'package:github_assistant/Models/repo_model.dart';
import 'package:github_assistant/Models/user_model.dart';
import 'package:github_assistant/Widgets/repo_widget.dart';

class InfoPage extends StatelessWidget {
  final dynamic infoData;
  final String username;
  const InfoPage({this.infoData, this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text(username,
            style: TextStyle(color: AppColors.textColor, fontSize: 18)),
      ),
      body: buildListFromDynamic(infoData),
    );
  }

  Widget buildListFromDynamic(dynamic data) {
    Widget list;
    try {
      List<UserModel> items = List<UserModel>();
      for (var item in data) {
        items.add(UserModel.fromJson(item));
      }
      items.sort(
          (a, b) => a.login.toLowerCase().compareTo(b.login.toLowerCase()));
      list = buildUsersInfoList(items);
    } catch (e) {
      try {
        List<RepoModel> items = List<RepoModel>();
        for (var item in data) {
          items.add(RepoModel.fromJson(item));
        }
        items.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        list = buildReposInfoList(items);
      } catch (e) {
        return Center(
            child: Text("Ошибка обработки данных",
                style: TextStyle(color: AppColors.textColor, fontSize: 24)));
      }
    }
    return list;
  }

  Widget buildUsersInfoList(List<UserModel> searchModel) {
    return searchModel != null && searchModel.length != 0
        ? ListView.builder(
            itemCount: searchModel.length,
            itemBuilder: (context, index) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: AppColors.mainColor,
                shadowColor: AppColors.textColor,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: 25,
                  child: Text(searchModel[index].login,
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 18)),
                ),
              );
            })
        : Center(
            child: Text("Нет данных",
                style: TextStyle(color: AppColors.textColor, fontSize: 24)));
  }

  Widget buildReposInfoList(List<RepoModel> searchModel) {
    return searchModel != null && searchModel.length != 0
        ? ListView.builder(
            itemCount: searchModel.length,
            itemBuilder: (context, index) {
              return RepoWidget(
                repoData: searchModel[index],
              );
            })
        : Center(
            child: Text("Нет данных",
                style: TextStyle(color: AppColors.textColor, fontSize: 24)));
  }
}

enum infoTypes { UserModel }
