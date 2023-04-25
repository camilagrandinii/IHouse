import 'package:flutter/material.dart';
import 'package:travelappui/models/placesModel.dart';
import 'package:travelappui/utils/restAPI.dart';

class HomePageStateProvider extends ChangeNotifier
{

  bool showBottomDrawer = true;
  RESTAPI api = RESTAPI();

  void setShowBottomDrawer(bool value){
    this.showBottomDrawer = value;
    print("\n Bottom Scroll State : "+this.showBottomDrawer.toString());
    notifyListeners();
  }

  List<String> kTopListLink = [
    'Quarto X',
    'Quarto Y',
    'Quarto de Visitas',
    'Cozinha',    
    'Banheiro',
    'Sala de Estar',
  ];

  Future<List<PlaceModel>> getFeaturedPlaces() async {
    return await api.getFeaturedPlaces();    
  }

  Future<List<PlaceModel>> getAllPlaces() async {
    return await api.getAllPlaces();    
  }

  // ignore: non_constant_identifier_names
  Future<void> GetTopList() async {

      await Future.delayed(const Duration(milliseconds: 500), (){});

      kTopListLink.add("India");

      notifyListeners();
      
  }

}