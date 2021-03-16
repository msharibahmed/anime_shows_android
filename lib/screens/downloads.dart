//libraries
import 'package:flutter/material.dart';
//packages
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadScreen extends StatefulWidget {
  static const routeName = 'download-screen';

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  var _loading = true;
  List<DownloadTask> _downloadTask = [];
  @override
  void initState() {
    super.initState();
    FlutterDownloader.loadTasks().then((downloadList) {
      _downloadTask = downloadList;
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:const Text('cancel'),
        onPressed: () {
          FlutterDownloader.cancelAll();
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Downloads'),
      ),
      body: _loading
          ?const Center(child:const CircularProgressIndicator())
          : ListView.builder(
              itemCount: _downloadTask.length,
              itemBuilder: (context, index) => ListTile(
                    leading: Text((index + 1).toString() + '.'),
                    title: Text(_downloadTask[index].filename),
                    subtitle: Text('Progress:' +
                        _downloadTask[index].progress.toString() +
                        '%'),
                    trailing: ElevatedButton(
                        onPressed: () async {
                          await FlutterDownloader.cancel(
                              taskId: _downloadTask[index].taskId);
                        },
                        child:const Text('cancel')),
                  )),
    );
  }
}
