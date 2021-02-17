import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextbase/bloc/metadata_cubit.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/di/custom_repo_provider.dart';
import 'package:nextbase/presentation/chart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomRepoProvider(
      child: BlocProvider<MetadataCubit>(
        create: (BuildContext context) => MetadataCubit(
          metadataRepo: RepositoryProvider.of<MetadataRepo>(context),
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ChartScreen(),
        ),
      ),
    );
  }
}
