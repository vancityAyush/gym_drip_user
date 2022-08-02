import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twsuser/apiService/apiResponse/ResponseBlogs.dart';
import 'package:twsuser/apiService/apiResponse/ResponseQuestion.dart';
import 'package:twsuser/apiService/apiResponse/ResponseReferalStatus.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';
import 'package:twsuser/main.dart';
import 'package:twsuser/routing/bouncypageroute.dart';
import 'package:twsuser/screen/homescreen.dart';
import 'package:twsuser/screen/mycheckin.dart';
import 'package:twsuser/screen/orderplaced.dart';
import 'package:twsuser/twsuser/otp.dart';
import 'package:twsuser/twsuser/setupprofile.dart';

import 'AppConstant.dart';
import 'apiRepository.dart';
import 'apiResponse/ResponseFetchChatMessage.dart';
import 'apiResponse/ResponseReviewProfile.dart';
import 'apiResponse/responsesubscription.dart';

class ApiManager extends ChangeNotifier {
  APIRepository _apiRepository = APIRepository();

  ////////////// login Api //////////////////////
  Future getGender() async {
    return await SharedPrefManager.getPrefrenceString(AppConstant.GENDER);
  }

  Future loginApi(String phone) async {
    await SharedPrefManager.savePrefString(AppConstant.NUMBER, phone);

    var response = await _apiRepository.loginApi(phone);
    if (response['error_code'] == 1) {
      navigatorKey.currentState.push(BouncyPageRoute(
          widget: OtpScreen(phone: phone, otp: response['otp'].toString())));
      await SharedPrefManager.savePrefString(
          AppConstant.PHONE, response['data']['phone']);
      await SharedPrefManager.savePrefString(
          AppConstant.EMAIL, response['data']['email']);
      await SharedPrefManager.savePrefString(
          AppConstant.NAME, response['data']['name']);
      Fluttertoast.showToast(
          msg: response['otp'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      navigatorKey.currentState.push(BouncyPageRoute(
          widget: OtpScreen(phone: phone, otp: response['otp'].toString())));

      Fluttertoast.showToast(
          msg: response['otp'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  ///////////// otp Api ////////////////////////

  Future verifyOtp(String phone, String otp) async {
    var response = await _apiRepository.verifyOtpApi(phone, otp);
    if (response['error_code'] == 1) {
      if (response['response_string'] == "NEW_USER") {
        navigatorKey.currentState
            .push(BouncyPageRoute(widget: (RegisterSetUpProfile())));
      } else {
        await SharedPrefManager.savePrefString(
            AppConstant.KEY, response['data']['client_key'].toString());
        navigatorKey.currentState.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
        SharedPrefManager.savePreferenceBoolean(true);
      }
    } else {}
  }

  ///////////// register Api ///////////////////////

  Future registerApi(
      {String phone,
      String email,
      String name,
      String location,
      String workOutExperience,
      String gender,
      String dob,
      String weight,
      String height,
      String goal}) async {
    var response = await _apiRepository.registerApi(
        phone: phone,
        email: email,
        name: name,
        location: location,
        workOutExperience: workOutExperience,
        gender: gender,
        dob: dob,
        weight: weight,
        height: height,
        goal: goal);
    if (response['error_code'] == 1) {
      print(response['data']['client_key'].toString());
      await SharedPrefManager.savePrefString(
          AppConstant.KEY, response['data']['client_key'].toString());
      navigatorKey.currentState.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      SharedPrefManager.savePreferenceBoolean(true);
    } else {}
  }

  ///////////// Edit Profile Api ///////////////////////

  Future<bool> editProfileApi(
      {String name,
      String gender,
      String dob,
      String weight,
      String height,
      String goal,
      String occupations,
      String relationship_status,
      String imagePath}) async {
    var response = await _apiRepository.editApi(
        name: name,
        gender: gender,
        dob: dob,
        weight: weight,
        height: height,
        goal: goal,
        occupations: occupations,
        relationship_status: relationship_status,
        imagePath: imagePath);
    if (response['error_code'] == 1) {
      return true;
    }
    return false;
  }

  ///////////// Store measurement ///////////////////////

  Future storeMeasurement(
      {String weight,
      String neck,
      String thigh,
      String abs,
      String chest,
      String chest_triceps,
      String right_thigh,
      String left_thigh,
      String lower_abs,
      String upper_abs,
      String right_biceps,
      String left_biceps,
      String shoulders,
      String waist,
      String hips}) async {
    var response = await _apiRepository.storeMeasurement(
        weight: weight,
        neck: neck,
        thigh: thigh,
        abs: abs,
        chest: chest,
        chest_triceps: chest_triceps,
        right_thigh: right_thigh,
        left_thigh: left_thigh,
        lower_abs: lower_abs,
        upper_abs: upper_abs,
        right_biceps: right_biceps,
        left_biceps: left_biceps,
        shoulders: shoulders,
        waist: waist,
        hips: hips);
    if (response['error_code'] == 1) {
      return response;
    } else {}
  }

  //////////////////////////////// fetchProfileApi/////////////////////////////////

  Future fetchProfileApi() async {
    try {
      var response = await _apiRepository.fetchProfileApi();
      print(response['error_code'].toString() + "sssssss");
      if (response['error_code'] == 0) {
      } else {
        await SharedPrefManager.savePrefString(
            AppConstant.PHONE, response['data']['phone']);
        await SharedPrefManager.savePrefString(
            AppConstant.USERIDGRAPH, response['data']['id']);
        await SharedPrefManager.savePrefString(
            AppConstant.EMAIL, response['data']['email']);
        await SharedPrefManager.savePrefString(
            AppConstant.NAME, response['data']['name']);
        await SharedPrefManager.savePrefString(
            AppConstant.GENDER, response['data']['gender']);
        if (response['data']['image'] != null) {
          await SharedPrefManager.savePrefString(
              AppConstant.IMAGE, response['data']['image']);
        }
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  //subscribeApi
  Future subscribeApi() async {
    try {
      var response = await _apiRepository.isSubscriptionTaken();
      print(response['error_code'].toString() + "sssssss");
      if (response['error_code'] == 0) {
      } else {}
      return response['data'];
    } catch (e) {
      print(e);
    }
  }

  ////////////////////// useRefCodeApi/////////////////

  Future<ResponseReferalStatus> useRefCodeApi(
      String refCode, BuildContext context) async {
    try {
      var response = await _apiRepository.useRefCodeApi(refCode);
      if (response.errorCode == 0) {
        Fluttertoast.showToast(msg: "Hi,Please use valid referal code");
      } else {
        Fluttertoast.showToast(
            msg: "Referral code had been attached successfully");
        await SharedPrefManager.savePrefString(
            AppConstant.STATUS, response.data.privacyStatus);
        await SharedPrefManager.savePrefString(
            AppConstant.TRAINERID, response.data.id.toString());
        navigatorKey.currentState.pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  ////////////////////// fetchTrainerProfileApi/////////////////

  Future<ResponseReviewProfile> fetchTrainerProfileApi() async {
    try {
      var response = await _apiRepository.trainerPreviewScreenApi();
      if (response.errorCode.toString() == "0") {
      } else {
        await SharedPrefManager.savePrefString(
            AppConstant.TRAINERID, response.data.id.toString());
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  ////////////////////// questionApi/////////////////

  Future<ResponseQuestion> questionApi() async {
    try {
      var response = await _apiRepository.questionApi();
      // if(response.errorCode == 0){}else{
      return response;
      // }
    } catch (e) {
      print(e);
    }
  }

  ////////////isSubscriptionApi///////////////////

  Future<ResponseSubscription> isSubscriptionApi(BuildContext context) async {
    try {
      var response = await _apiRepository.isSubscriptionTakenApi();
      if (response.errorCode.toString() == "0") {
        await SharedPrefManager.savePrefString(
            AppConstant.ISSUBSCRIPTION, "NO");
      } else {
        // SharedPrefManager.savePrefString(AppConstant.STATUS, "PUBLIC");
        await SharedPrefManager.savePrefString(
            AppConstant.TRAINERID, response.data.trainerId.toString());
        await SharedPrefManager.savePrefString(
            AppConstant.USERID, response.data.userId.toString());
        SharedPrefManager.savePrefString(
            AppConstant.TRAINERSUBSCRIPTION, "SUBSCRIPTION");
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  ////////////blogApi///////////////////

  Future<ResponseBlogs> blogApi() async {
    try {
      var response = await _apiRepository.blogApi();
      if (response.errorCode == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  ////////////////////// startSevenDaysTrialApi/////////////////

  Future startSevenDaysTrial() async {
    try {
      var response = await _apiRepository.startSevenDaysTrial();
      if (response['error_code'] == 0) {
      } else {
        navigatorKey.currentState.pushReplacement(
            MaterialPageRoute(builder: (builder) => HomeScreen()));
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  //////////////////////// startSubscriptionApi ///////////////////

  Future startSubscriptionApi(String packageId) async {
    try {
      var response = await _apiRepository.startSubscriptionApi(packageId);
      if (response['error_code'] == 0) {
      } else {
        navigatorKey.currentState.pushReplacement(
            MaterialPageRoute(builder: (builder) => OrderPlaced()));
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// fetchCertificateTrainerApi ///////////////////

  Future fetchCertificateTrainerApi(String clientKey) async {
    try {
      var response = await _apiRepository.fetchCertificateTrainerApi(clientKey);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  //////fetchTransFormationApi

  Future fetchTransFormationApi(String clientKey) async {
    try {
      var response = await _apiRepository.fetchTransformationApi(clientKey);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// fetchMemberTrainerApi ////////////////////////////

  Future fetchMemberTrainerApi(String clientKey) async {
    try {
      var response = await _apiRepository.fetchMemberTrainerApi(clientKey);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// fetchMembershipPackageTrainerApi ///////////////////

  Future fetchMembershipPackageTrainerApi(String clientKey) async {
    try {
      var response =
          await _apiRepository.fetchMembershipPackageTrainerApi(clientKey);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  ///////////////////////////// fetchDietByDatesApi //////////////////////////

  Future fetchDietByDatesApi(String date) async {
    try {
      var response = await _apiRepository.fetchDietByDates(date);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// fetchWorkoutApi //////////////////////////////

  Future fetchWorkoutApi() async {
    try {
      var response = await _apiRepository.fetchWorkoutApi();
      print(response['error_code']);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// fetch_exercise_by_workout_id ///////////////////

  Future fetchExerciseByWorkoutId(String workoutId) async {
    try {
      var response = await _apiRepository.fetchExerciseByWorkoutApi(workoutId);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// mealTakenApi ///////////////////

  Future mealTakenApi(String mealId, String foodId) async {
    try {
      var response = await _apiRepository.mealTakenApi(mealId, foodId);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// fetchWorkoutByDatesApi ///////////////////

  Future fetchWorkoutByDatesApi(String date) async {
    try {
      var response = await _apiRepository.fetchWorkoutByDatesApi(date);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// submitAnswerApi ///////////////////

  Future submitAnswerApi(
      String question, String option, String description) async {
    try {
      var response =
          await _apiRepository.submitAnswerApi(question, option, description);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// storeMeasurementApi ///////////////////

  Future storeMeasurementApi(
      String weight,
      String neck,
      String thigh,
      String abs,
      String chestTriceps,
      String rightThigh,
      String leftThigh,
      String hips,
      String waist,
      String lowerAbs,
      String upperAbs,
      String rightBiceps,
      String leftBiceps,
      String chest,
      String shoulder) async {
    try {
      var response = await _apiRepository.storeSubscriptionApi(
          weight,
          neck,
          thigh,
          abs,
          chestTriceps,
          rightThigh,
          leftThigh,
          hips,
          waist,
          lowerAbs,
          upperAbs,
          rightBiceps,
          leftBiceps,
          chest,
          shoulder);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// sendMessageApi ////////////////////////////////

  Future sendMessageApi(msg) async {
    try {
      var response = await _apiRepository.sendMessageApi(msg);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// newsendMessageApi ////////////////////////////////

  Future newSendMessageApi(msg, filename) async {
    try {
      var response = await _apiRepository.newSendMessageApi(msg, filename);
      if (response['error_code'] == 0) {
      } else {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////FetchIndividualChatApi ////////////////////////////////

  Future<ResponseFetchChatMessage> fetchIndividualChat() async {
    final response = await _apiRepository.fetchIndividualChat();
    if (response.errorCode.toString() == "1") {
      return response;
    }
  }

  ///////////////////add Food Api////////////////////////

  Future addFoodApi(
      String name, String protein, String carb, String fats, String id) async {
    try {
      var response = await _apiRepository.addFoodApi(name, protein, carb, fats);
      print(response['error_code'].toString());
      if (response['error_code'] == 1) {
        addFoodToMealApi(response['data']['id'].toString(), id);
      }
      return Fluttertoast.showToast(
          msg: response['reponse_string'], gravity: ToastGravity.BOTTOM);
      // navigatorKey.currentState.push(BouncyPageRoute(widget: WorkOut()));
    } catch (e) {
      print(e);
    }
  }

  ///////////////////workOutTakenApi////////////////////////

  Future workOutTakenApi(String id, String isDone) async {
    try {
      var response = await _apiRepository.workoutTakenApi(id, isDone);
      print(response['error_code'].toString());
      if (response['error_code'] == 1) {
        addFoodToMealApi(response['data']['id'].toString(), id);
      }
      return Fluttertoast.showToast(
          msg: response['reponse_string'], gravity: ToastGravity.BOTTOM);
      // navigatorKey.currentState.push(BouncyPageRoute(widget: WorkOut()));
    } catch (e) {
      print(e);
    }
  }

  ///////////////////add Food To Meal Api////////////////////////

  Future addFoodToMealApi(String id, String mealId) async {
    try {
      var response = await _apiRepository.addFoodToMealApi(id, mealId);
      // print(response['error_code'].toString());
      navigatorKey.currentState.pushReplacement(
          MaterialPageRoute(builder: (context) => MyCheckin()));
      return Fluttertoast.showToast(
          msg: response['reponse_string'], gravity: ToastGravity.BOTTOM);
      // navigatorKey.currentState.push(BouncyPageRoute(widget: WorkOut()));
    } catch (e) {
      print(e);
    }
  }

  ///////////////////add Food To Meal Api////////////////////////

  Future questionSubmitApi(
      Set question, List<String> answer, List<String> description) async {
    try {
      var response =
          await _apiRepository.questionSubmitApi(question, answer, description);
      // print(response['error_code'].toString());
      navigatorKey.currentState.pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
      return Fluttertoast.showToast(
          msg: "Physical question had been completed successfully",
          gravity: ToastGravity.BOTTOM);
      // navigatorKey.currentState.push(BouncyPageRoute(widget: WorkOut()));
    } catch (e) {
      print(e);
    }
  }
}
