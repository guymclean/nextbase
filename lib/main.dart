import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/di/custom_repo_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomRepoProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TestStateful(),
      ),
    );
  }
}

class TestStateful extends StatefulWidget {
  @override
  _TestStatefulState createState() => _TestStatefulState();
}

class _TestStatefulState extends State<TestStateful> {
  @override
  void initState() {
    _doStuff();
    super.initState();
  }

  _doStuff() async {
    var x =
        await RepositoryProvider.of<MetadataRepo>(context).getJourneyMetadata();
    print("got it");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
