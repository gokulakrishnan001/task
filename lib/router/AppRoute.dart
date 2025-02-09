import 'package:flutter/material.dart';
import 'package:flutter_map/HomeScreen.dart';
import 'package:flutter_map/VechileScreen/EditingPage.dart';
import 'package:flutter_map/VechileScreen/LandingPage.dart';
import 'package:flutter_map/VechileScreen/RegisterPage.dart';
import 'package:flutter_map/client/ClientLand.dart';
import 'package:flutter_map/client/ClientRegistration.dart';
import 'package:flutter_map/client/OtpScreen.dart';
import 'package:flutter_map/router/AppRouteConstant.dart';
import 'package:go_router/go_router.dart';

class AppRouteConfig{
    static GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: AppRouteConstant.IndexPage,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: Login());
          },
        ),
        GoRoute(
          name: AppRouteConstant.VechileRegister,
          path: '/signIn',
          pageBuilder: (context, state) {
            return const MaterialPage(child: Registerpage());
          },
        ),
         GoRoute(
          name: AppRouteConstant.VechileLand,
          path: '/land/:name',
          pageBuilder: (context, state) {
            return  MaterialPage(child: MyWidget(name: state.pathParameters['name']!,));
          },
        ),
        GoRoute(
          name: AppRouteConstant.VechileEdit,
          path: '/edit/:name',
          pageBuilder: (context, state) {
            return  MaterialPage(child: Editingpage(name: state.pathParameters['name']!,));
          },
        ),
        GoRoute(
          name: AppRouteConstant.ClientRegi,
          path: '/client',
          pageBuilder: (context, state) {
            return  MaterialPage(child: SignIn());
          },
        ),
         GoRoute(
          name: AppRouteConstant.ClientOtp,
          path: '/clientOtp/:phone',
          pageBuilder: (context, state) {
            return  MaterialPage(child: ForgotPassword(mail: state.pathParameters['phone']!,));
          },
        ),
         GoRoute(
          name: AppRouteConstant.ClientLanding,
          path: '/clientLand',
          pageBuilder: (context, state) {
            return  MaterialPage(child: ClientLand());
          },
        ),
      ]);

}