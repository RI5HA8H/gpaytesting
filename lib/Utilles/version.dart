

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';



class VersionWidget extends StatefulWidget {
  @override
  _VersionWidgetState createState() => _VersionWidgetState();
}

class _VersionWidgetState extends State<VersionWidget> {
  String _version = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('App Version: $_version',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black,));
  }

}