import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nextbase/bloc/map_cubit.dart';
import 'package:nextbase/bloc/map_states.dart';
import 'package:nextbase/data/metadata_repo.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (BuildContext context) => MapCubit(
        metadataRepo: RepositoryProvider.of<MetadataRepo>(context),
      ),
      child: _MapScreen(),
    );
  }
}

class _MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<MapCubit, MapState>(
        builder: (BuildContext context, MapState state) {
          if (state is MapLoaded) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: state.data.coordinates.last,
                zoom: 14,
              ),
              cameraTargetBounds: CameraTargetBounds(state.data.bounds),
              polylines: {
                Polyline(
                  polylineId: PolylineId("journey"),
                  points: state.data.coordinates,
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                controller.animateCamera(
                    CameraUpdate.newLatLngBounds(state.data.bounds, 50));
              },
            );
          } else if (state is MapError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
