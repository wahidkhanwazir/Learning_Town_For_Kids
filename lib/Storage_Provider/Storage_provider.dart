import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider extends ChangeNotifier{
  var lastSubCatagoryRead = GetStorage();
  var lastCatagoryRead = GetStorage();
  var lastnameRead = GetStorage();
  var lastImageRead = GetStorage();

  void setLast(int lastSubCatagory, String lastCatagory, String lastName, String lastImage){
    lastSubCatagoryRead.write('catagory', lastSubCatagory);
    lastCatagoryRead.write('subCatagory', lastCatagory);
    lastnameRead.write('name', lastName);
    lastImageRead.write('image', lastImage);
    notifyListeners();
  }

  String getLastCatagory(){
    if(lastCatagoryRead.read('subCatagory') != null) {
      return lastCatagoryRead.read('subCatagory');
    }
    else{
      return 'alphabets';
    }
  }
  String getLastName(){
    if(lastnameRead.read('name') != null) {
      return lastnameRead.read('name');
    }
    else{
      return 'shapes';
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
