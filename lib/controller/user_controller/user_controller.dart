import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:punchin/views/login/login_screen.dart';
import 'package:punchin/widget/custom_bottom_bar.dart';



class UserController extends GetxController{

  var box= GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }


  initialNavigate() async{
    await Future.delayed(Duration(seconds: 3));
    if(box.read('firsttimeopen')??true){
      box.write("firsttimeopen", false);
      Get.offAll(()=>LoginScreen());
    }else{

      navigatorUser();
    }
  }

  navigatorUser(){
    final String? Token=box.read("authToken");
    if(Token!=null ){

      Get.offAll(()=>CustomNavigation());
    }
    else{
    Get.offAll(()=>LoginScreen());
    }
  }

  void doneIntro(){
    box.write("firsttimeopen", false);
    //  pref.setBool('firstopen', false);
    navigatorUser();
  }



}