import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider extends ChangeNotifier{
  var lastSubCatagoryRead = GetStorage();
  var lastCatagoryRead = GetStorage();
  var lastImageRead = GetStorage();

  void setLast(int lastSubCatagory, String lastCatagory, String lastImage){
    lastSubCatagoryRead.write('catagory', lastSubCatagory);
    lastCatagoryRead.write('subCatagory', lastCatagory);
    lastImageRead.write('image', lastImage);
    notifyListeners();
  }

  String getLastCatagory(){
    if(lastCatagoryRead.read('subCatagory') != null) {
      return lastCatagoryRead.read('subCatagory');
    }
    else{
      return 'Alphabets';
    }
  }
  int getLastSubCatagory(){
    if(lastSubCatagoryRead.read('catagory') != null) {
      return lastSubCatagoryRead.read('catagory');
    } else{
      return 0;
    }
  }
  String getLastImage(){
    if(lastImageRead.read('image') != null) {
      return lastImageRead.read('image');
    }
    else{
      return 'assets/images/abc 1.png';
    }
  }
}
