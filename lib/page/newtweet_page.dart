import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewTweetPage extends StatefulWidget {
  const NewTweetPage({super.key});

  @override
  State<NewTweetPage> createState() => _NewTweetPageState();
}

class _NewTweetPageState extends State<NewTweetPage> {
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nouveau Tweet"),),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: "Qu'est-ce qui se passe...",
                    labelText: "Nouveau Tweet"
                ),
              ),
              fileImage != null ? Image.file(fileImage!,height: 100,) : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () async{
                    FilePickerResult? fp = await FilePicker.platform.pickFiles(type: FileType.media);
                    setState(() {
                      fileImage = fp?.files[0].path != null ? File(fp!.files[0].path!) : null;
                    });
                  }, icon: const Icon(Icons.image)),
                  ElevatedButton.icon(onPressed: (){},
                    icon: Hero(tag: "edit",child: const Icon(Icons.edit)),
                    label: Text("Post"),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}
