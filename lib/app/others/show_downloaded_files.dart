import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadFileOpen extends StatefulWidget {
  @override
  State<DownloadFileOpen> createState() => _DownloadFileOpenState();
}

class _DownloadFileOpenState extends State<DownloadFileOpen> {
  final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return ControlBackButton(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => createFolder(context),
              icon: Icon(Icons.create_new_folder_outlined),
            ),
            IconButton(
              onPressed: () => selectStorage(context),
              icon: Icon(Icons.sd_storage_rounded),
            )
          ],
          title: Text('transferUSB'.tr),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await controller.goToParentDirectory();
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: FileManager(
            controller: controller,
            builder: (context, snapshot) {
              final List<FileSystemEntity> entities = snapshot;

              return ListView.builder(
                itemCount: entities.length,
                itemBuilder: (context, index) {
                  final FileSystemEntity entity = entities[index];
                  return Card(
                    child: ListTile(
                      leading: FileManager.isFile(entity) ? Icon(Icons.feed_outlined) : Icon(Icons.folder),
                      title: Text(FileManager.basename(entity)),
                      subtitle: subtitle(entity),
                      onTap: () async {
                        if (FileManager.isDirectory(entity)) {
                          controller.openDirectory(entity);
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            final int size = snapshot.data!.size;

            return Text(
              '${FileManager.formatBytes(size)}',
            );
          }
          return Text(
            '${snapshot.data!.modified}'.substring(0, 10),
          );
        } else {
          return Text('');
        }
      },
    );
  }

  selectStorage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: FutureBuilder<List<Directory>>(
          future: FileManager.getStorageList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<FileSystemEntity> storageList = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: storageList
                      .map(
                        (e) => ListTile(
                          title: Text(
                            '${FileManager.basename(e)}',
                          ),
                          onTap: () {
                            controller.openDirectory(e);
                            Navigator.pop(context);
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            }
            return Dialog(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  sort(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Name'),
                onTap: () {
                  controller.sortBy(SortBy.name);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Size'),
                onTap: () {
                  controller.sortBy(SortBy.size);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Date'),
                onTap: () {
                  controller.sortBy(SortBy.date);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('type'),
                onTap: () {
                  controller.sortBy(SortBy.type);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  createFolder(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController folderName = TextEditingController();
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: TextField(
                    controller: folderName,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Create Folder
                      await FileManager.createFolder(
                        controller.getCurrentPath,
                        folderName.text,
                      );
                      // Open Created Folder
                      controller.setCurrentPath = controller.getCurrentPath + '/' + folderName.text;
                    } catch (e) {}

                    Navigator.pop(context);
                  },
                  child: Text('Create Folder'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
