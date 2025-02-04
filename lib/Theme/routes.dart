import 'package:get/get.dart';
import '../App/home.dart';
import '../App/Auth/Login.dart';
import '../App/Auth/Register.dart';
import '../App/Auth/Reset.dart';

import '../App/Panel/edit_profile.dart';
import '../App/Panel/profile.dart';

import '../App/Shop/Shop.dart';
import '../App/Wishlist/Wishlist.dart';
import '../App/User/User.dart';

import '../App/Products/product_view.dart';

// import '../App/Courses/Courses.dart';

// import '../App/Sample.dart';

dynamic routes=[
  //منوهای صفحه اصلی
  GetPage(name: '/home', page: ()=>const Home(), transition: Transition.fadeIn),
  GetPage(name: '/shop', page: ()=>const Shop()),
  GetPage(name: '/wishlist', page: ()=>const Wishlist()),
  GetPage(name: '/user', page: ()=>const User()),
  // GetPage(name: '/courses', page: ()=>const Courses()),

GetPage(name: '/product/:id', page: () => ProductView()),

  // پروفایل
  GetPage(name: '/edit-profile', page: ()=>const EditProfile()),
  GetPage(name: '/profile', page: ()=>const Profile()),

  // احراز هویت
  GetPage(name: '/register', page: ()=>const Register()),
  GetPage(name: '/reset-password', page: ()=>const Reset()),
  GetPage(name: '/login', page: ()=>const Login()),
  GetPage(name: '/logout', page: ()=>const Login()),



  // GetPage(name: '/teachers', page: ()=>const Home()),
  // GetPage(name: '/teacher', page: ()=>const Home()),
  // GetPage(name: '/blogs', page: ()=>const Home()),
  // GetPage(name: '/blog', page: ()=>const Home()),
  // GetPage(name: '/course', page: ()=>const Home())
];