import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() async {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apps',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Application> appsLists = List<Application>();

  @override
  void initState() {
    fetchApps();
    super.initState();
  }

  void fetchApps() async {
    appsLists = await DeviceApps.getInstalledApplications(includeAppIcons: true, includeSystemApps: true, onlyAppsWithLaunchIntent: true);
    setState(() {
      appsLists=appsLists;
    });
  }

  Widget _buildAppItems(BuildContext context, int index) {
    ApplicationWithIcon app = appsLists[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      subtitle: Text(appsLists.length.toString()),
      leading: CircleAvatar(backgroundColor: Colors.transparent, child: Image.memory(app.icon),),
      title: Text(app.appName),
      onTap: () => DeviceApps.openApp(app.packageName),
    );
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: appsLists.length,
            itemBuilder: _buildAppItems,
          )
        ),
      ),
    );
  }
}