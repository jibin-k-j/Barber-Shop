import 'package:barber_app/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DummyApi dummyApi = MainDummyApi();
  await MainSetup.setup(
    dummyApi: dummyApi,
  );
  await FirebaseAuth.instance.wait();

  startApp();
}

void startApp() async {
  DummyApi dummyApi = MainDummyApi();

  await MainSetup.setup(
    dummyApi: dummyApi,
  );

  // await FirebaseAuth.instance.signOut();

  int appThemeIndex = dummyApi.appConfig.defaultThemeIndex;
  // if (FirebaseAuth.instance.currentUser != null) {
  //   appThemeIndex = await AdminSettingApi.getAppThemeIndex(
  //     defaultThemeIndex: 1,
  //   );
  // }
  await AdminSettingApi.loadAppSetting();
  Widget mainView = await LoginSessionHandler.getMainView();
  // mainView = AdmThemeView();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    // theme: theme.appThemeData,
    theme: ThemeData().getCustomTheme(
      customColorSet: colorPalettes[appThemeIndex],
    ),
    defaultTransition: Transition.fade,
    home: mainView,
  ));
}
