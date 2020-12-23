abstract class DevicesCharacteristicsBase {
  List<Map<dynamic,dynamic>> initialList;
  List<Map<dynamic,dynamic>> stateList;
  List<Map<dynamic,dynamic>> get current => stateList;

  void setStateText(List<Map<dynamic,dynamic>> list){
    stateList = list;
  }

  void reset(){
    stateList = initialList;
  }
}