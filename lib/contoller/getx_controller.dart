import 'package:get/get.dart';

class ContollerApp extends GetxController{
    RxBool isLogin=true.obs;
    RxBool isNotLogin=true.obs;
    RxBool isLoading=false.obs;
    
    changeLoadingTrue()
    {
      isLoading=true.obs;
      update();
    }
    changeLoadingfalse()
    {
      isLoading=true.obs;
      update();
    }

    falselogin()
    {
      if(isLogin==true.obs)
      {
        isLogin=false.obs;
      }
      else{
        isLogin=true.obs;
      }
      update();
    }
    truelogin()
    {
      isLogin=true.obs;
      update();
    }

  

}