
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class IndexController extends GetxController{
  var loading = false.obs;
  dynamic data = {}.obs;

  @override
  void onInit(){
    super.onInit();
    getData();
  }

  Future getData() async{
    var uri = "http://127.0.0.1:313/api/fa/index";
    try{
      var response = await http.get(Uri.parse(uri));
      var result = jsonDecode(response.body);
      print(result);
      if(result['status'] == 200){
        data = result['data'];
        loading.value = true;
      }else{
        Get.rawSnackbar(
          titleText: const Text("پیغام خطا",
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,),
          messageText: const Text("خطا در دریافت اطلاعات",
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,),
          backgroundColor: Colors.redAccent,
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(vertical: 10),
        );
      }
    }catch(error){
      Get.rawSnackbar(
        titleText: const Text("پیغام خطا",
          style: TextStyle(color: Colors.white),
          textDirection: TextDirection.rtl,),
        messageText: const Text("خطای اتصال به اینترنت",
          style: TextStyle(color: Colors.white),
          textDirection: TextDirection.rtl,),
        backgroundColor: Colors.redAccent,
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      );
    }

  }
}