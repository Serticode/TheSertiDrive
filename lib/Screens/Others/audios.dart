import 'package:flutter/material.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Screens/Home/userFoldersList.dart';
import 'package:sertidrive/Shared/constants.dart';
import 'package:provider/provider.dart';

class Audios extends StatefulWidget {
  @override
  _AudiosState createState() => _AudiosState();
}

class _AudiosState extends State<Audios> {
  final _foldersObject = Folders();
  List audiosFolderContent = [];

  @override
  void didChangeDependencies() async {
    String email = Provider.of<MyUserModel>(context).email;

    var items = await _foldersObject.listAudiosFolderContent(email: email);

    if (items != null) {
      setState(() {
        items.forEach((element) {
          audiosFolderContent.add(element);
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sertidrive"),
      ),
      body: Column(
          children: <Widget>[
            curve(),
            Expanded(
              child: audioList(buildContext: context, folders: audiosFolderContent),
            ),
          ],
        ),
    );
  }

  Widget audioList({BuildContext buildContext, List folders}) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Theme.of(context).primaryColor,
        indent: 70.0,
        thickness: 2,
        height: 8.0,
      ),
      itemCount: folders == null ? 0 : folders.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Icon(
            Icons.audiotrack_sharp,
            size: 40.0,
          ),
          title: Text(
              folders
                  .elementAt(index)
                  .toString()
                  .split("/")
                  .last
                  .replaceAll(")", ""),
              style: homePageTextStyle),
          onTap: () {
            print("$index WAS TAPPED !!!");
          },
        );
      },
    );
  }
}
