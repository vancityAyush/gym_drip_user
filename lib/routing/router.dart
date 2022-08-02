import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './route_paths.dart' as routes;

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    /*case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case routes.IntroRoute:
      return MaterialPageRoute(builder: (context) => IntroSlide());
    case routes.OtpRoute:
      return MaterialPageRoute(builder: (context) => OtpScreen());
      case routes.checkProfessionRoute:
      return MaterialPageRoute(builder: (context) => CheckProfession());
    case routes.RegisterRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case routes.RegsterBusinessProfessional:
      return MaterialPageRoute(builder: (context) => RegisterRegisterBusiness());
    case routes.RegsterJobseeker:
      return MaterialPageRoute(builder: (context) => RegisterJobSeeker());
    case routes.SearchFilter:
      return MaterialPageRoute(builder: (context) => SearchFilter());
    case routes.FIlTERLOCATION:
      return MaterialPageRoute(builder: (context) => FilterLocation());
    case routes.ReferBusiness:
      return MaterialPageRoute(builder: (context) => ReferBusiness());
    case routes.Home:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case routes.BusinessHome:
      return MaterialPageRoute(builder: (context) => HomeScreenBusiness());
    case routes.JobSeekerHome:
      return MaterialPageRoute(builder: (context) => HomeJobSeekerScreen());
    case routes.feedbackForm:
      return MaterialPageRoute(builder: (context) => FeedbackForm());
    case routes.quickService:
      return MaterialPageRoute(builder: (context) => QuickService());
    case routes.quickServiceJob:
      return MaterialPageRoute(builder: (context) => QuickServiceJob());
    case routes.quickServiceBusiness:
      return MaterialPageRoute(builder: (context) => QuickServiceBusiness());
    case routes.WithDrawRequest:
      return MaterialPageRoute(builder: (context) => WithDrawalAmount());*/
    /*case routes.internetCall:
      return MaterialPageRoute(builder: (context) => Conference());*/
    default:
      return MaterialPageRoute(builder: (context) => Scaffold(
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ));
  }
}