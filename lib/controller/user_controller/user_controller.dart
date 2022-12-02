import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:punchin/views/login/login_screen.dart';
import 'package:punchin/widget/custom_bottom_bar.dart';



class UserController extends GetxController{

  var box= GetStorage();



  late String user ;
  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    super.onInit();
  }
  initData()async{
    //  pref = await SharedPreferences.getInstance();
    //getUser();
  }

  initialNavigate() async{
    await Future.delayed(Duration(seconds: 3));
    if(box.read('firsttimeopen')??true){
      //Get.toNamed('/onboarding');
      box.write("firsttimeopen", false);
      print("object" + box.read("authTokem").toString());
      Get.offAll(()=>LoginScreen());
    }else{

      navigatorUser();
    }
  }

  navigatorUser(){
    final String? Token=box.read("authToken");
    print(Token =="d7ff769f-b632-42cb-9928-a10c99d9f3d2");
    print(Token );
    print(Token!=null);
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