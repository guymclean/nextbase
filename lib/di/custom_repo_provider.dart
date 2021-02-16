import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextbase/data/metadata_api.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/util/web_service.dart';

class CustomRepoProvider extends StatelessWidget {
  final Widget child;

  CustomRepoProvider({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WebService>(
          create: (context) => WebServiceImpl(),
        ),
        RepositoryProvider<MetadataApi>(
          create: (context) => MetadataApiImpl(
            webService: RepositoryProvider.of<WebService>(context),
          ),
        ),
        RepositoryProvider<MetadataRepo>(
          create: (context) => MetadataRepoImpl(
            metadataApi: RepositoryProvider.of<MetadataApi>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
