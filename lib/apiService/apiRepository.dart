// @dart=2.9
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:twsuser/apiService/apiResponse/ResponseBlogs.dart';
import 'package:twsuser/apiService/apiResponse/ResponseFetchChatMessage.dart';
import 'package:twsuser/apiService/apiResponse/ResponseQuestion.dart';
import 'package:twsuser/apiService/apiResponse/ResponseReferalStatus.dart';
import 'package:twsuser/apiService/apiResponse/ResponseReviewProfile.dart';
import 'package:twsuser/apiService/apiResponse/responsesubscription.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';

import 'AppConstant.dart';
import 'diocleint.dart';

class APIRepository {
  DioClient dioClient;
  String _baseUrl = "http://fitnessapp.frantic.in/";

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(_baseUrl, dio);
  }

  ////////////////// Login Api ////////////////////////////////

  Future loginApi(String phone) async {
    FormData formData = new FormData.fromMap({"phone": phone});
    print(formData.fields);
    try {
      final response = await dioClient.post("AuthApi/login", data: formData);
      return response;
    } catch (e) {}
  }

  /////////////////// Verify Otp//////////////////////////////

  Future verifyOtpApi(String phone, String otp) async {
    FormData formData = new FormData.fromMap({"phone": phone, "otp": otp});
    print(formData.fields);
    try {
      final response =
          await dioClient.post("AuthApi/verify_otp", data: formData);
      return response;
    } catch (e) {}
  }

  /////////////////// RegisterApi//////////////////////////////

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
    var phone = await SharedPrefManager.getPrefrenceString(AppConstant.NUMBER);
    FormData formData = new FormData.fromMap({
      "phone": phone,
      "email": email,
      "name": name,
      "user_type": "USER",
      "location": location,
      "workout_experience": workOutExperience,
      "gender": gender,
      "dob": dob,
      "weight": weight,
      "height": height,
      "goal": goal
    });
    // FormData formData = new FormData.fromMap({"phone": phone,"email":email,"name":name,"user_type":"TRAINER"});
    print(formData.fields);
    try {
      final response = await dioClient.post("AuthApi/register", data: formData);
      return response;
    } catch (e) {}
  }

  /////////////////// Edit API//////////////////////////////

  Future editApi({
    String name,
    String gender,
    String dob,
    String weight,
    String height,
    String goal,
    String occupations,
    String relationship_status,
    String imagePath,
  }) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    File image = File(imagePath);
    String fileName = image.path.split('/').last;
    FormData formData = new FormData.fromMap({
      "name": name,
      "gender": gender,
      "dob": dob,
      "weight": weight,
      "height": height,
      "goal": goal,
      "occupations": occupations,
      "relationship_status": relationship_status,
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
      "key": key
    });
    try {
      final response =
          await dioClient.post("UserRestApi/edit_profile", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////////fetchProfileApi/////////////

  Future fetchProfileApi() async {
    // ResponseProfile responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("UserRestApi/profile", data: formData);
      // responseProfile = ResponseProfile.fromJson(response);
      return response;
    } catch (e) {}
  }

  ////////////////////////is Subscription Api/////////////

  Future isSubscriptionTaken() async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response = await dioClient.post("UserRestApi/is_subscription_taken",
          data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////////store Measurement/////////////

  Future storeMeasurement({
    String weight,
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
    String hips,
  }) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "weight": weight,
      "neck": neck,
      "thigh": thigh,
      "abs": abs,
      "chest": chest,
      "chest_triceps": chest_triceps,
      "right_thigh": right_thigh,
      "left_thigh": left_thigh,
      "lower_abs": lower_abs,
      "upper_abs": upper_abs,
      "right_biceps": right_biceps,
      "left_biceps": left_biceps,
      "shoulders": shoulders,
      "waist": waist,
      "hips": hips,
    });
    try {
      final response =
          await dioClient.post("UserRestApi/store_measurement", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////////useRefCodeApi/////////////

  Future<ResponseReferalStatus> useRefCodeApi(String refCode) async {
    ResponseReferalStatus responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({"key": key, "ref_code": refCode});
    print(formData.fields);
    try {
      final response =
          await dioClient.post("UserRestApi/use_ref_code", data: formData);
      responseProfile = ResponseReferalStatus.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ////////////////////////trainerPreviewScreenApi/////////////

  Future<ResponseReviewProfile> trainerPreviewScreenApi() async {
    ResponseReviewProfile responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    print(trainerId);
    FormData formData =
        new FormData.fromMap({"key": key, "trainer_id": trainerId});

    print(formData.fields);

    try {
      final response = await dioClient.post("UserRestApi/fetch_trainer_profile",
          data: formData);
      responseProfile = ResponseReviewProfile.fromJson(response);

      return responseProfile;
    } catch (e) {}
  }

  ////////////////////////isSubscriptionTaken/////////////

  ResponseSubscription responseSubscription;
  Future<ResponseSubscription> isSubscriptionTakenApi() async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({"key": key});

    print(formData.fields);

    try {
      final response = await dioClient.post("UserRestApi/is_subscription_taken",
          data: formData);
      responseSubscription = ResponseSubscription.fromJson(response);
      return responseSubscription;
    } catch (e) {}
  }

  ///////////////////////////////add Foods Api////////////////////////////////////

  Future addFoodApi(
      String name, String protein, String carb, String fats) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": name,
      "protein": protein,
      "carbs": carb,
      "fats": fats,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("UserRestApi/add_food", data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////workout_takenApi////////////////////////////////////

  Future workoutTakenApi(String id, String isDone) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "trainer_workout_exercise_id": id,
      "is_done": isDone,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("UserRestApi/workout_taken", data: formData);
      return response;
    } catch (e) {}
  }

  /////////////add food to meal api

  Future addFoodToMealApi(String id, String mealId) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    // var
    FormData formData =
        new FormData.fromMap({"key": key, "meal_id": mealId, "food_id": id});
    print(formData.fields);
    try {
      final response =
          await dioClient.post("UserRestApi/add_food_to_meal", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////////questionApi/////////////

  Future<ResponseQuestion> questionApi() async {
    ResponseQuestion responseQuestion;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({"key": key});
    print(formData.fields);

    try {
      final response =
          await dioClient.post("UserRestApi/fetch_question", data: formData);
      responseQuestion = ResponseQuestion.fromJson(response);
      return responseQuestion;
    } catch (e) {}
  }

  ///////////// questionList /////////
  Future questionSubmitApi(
      Set question, List<String> answer, List<String> description) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "question_id[]": question,
      "selected_option[]": answer,
    });
    print(formData.fields);

    try {
      final response =
          await dioClient.post("UserRestApi/submit_answer", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////////blogApi///////////////////////////////

  Future<ResponseBlogs> blogApi() async {
    ResponseBlogs responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    print(trainerId);
    FormData formData =
        new FormData.fromMap({"key": key, "trainer_id": trainerId});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/blogs",
        data: formData,
      );
      responseProfile = ResponseBlogs.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ////////////////////////startSevenDaysTrial///////////////////////////////

  Future startSevenDaysTrial() async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    print(trainerId);
    FormData formData =
        new FormData.fromMap({"key": key, "trainer_id": trainerId});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/start_seven_day_trial",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  ////////////////////////startSubscriptionApi///////////////////////////////

  Future startSubscriptionApi(String packageId) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    print(trainerId);
    FormData formData = new FormData.fromMap({
      "key": key,
      "trainer_id": trainerId,
      "package_id": packageId,
    });

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/start_subscription",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  ///////////////////fetchCertificateTrainerApi //////////////

  Future fetchCertificateTrainerApi(String clientKey) async {
    FormData formData = new FormData.fromMap({"key": clientKey});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "TrainerRestApi/fetch_certificate",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  /////////////fetchTransformationApi //////////////

  Future fetchTransformationApi(String clientKey) async {
    FormData formData = new FormData.fromMap({"key": clientKey});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "TrainerRestApi/fetch_transformation",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  ///////////////////fetchMemberTrainerApi ///////////////////////

  Future fetchMemberTrainerApi(String clientKey) async {
    FormData formData = new FormData.fromMap({"key": clientKey});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "TrainerRestApi/fetch_member",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  ///////////////////fetchMembershipPackageTrainerApi //////////////

  Future fetchMembershipPackageTrainerApi(String clientKey) async {
    FormData formData = new FormData.fromMap({"key": clientKey});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "TrainerRestApi/fetch_membership_package",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  /////////////////////fetchDietByDatesApi //////////////////////////

  Future fetchDietByDates(String date) async {
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap(
        {"key": key, "trainer_id": trainerId, "date": date});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/diet_by_dates",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  /////////////////////fetchWorkoutApi //////////////////////////

  Future fetchWorkoutApi() async {
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    print("trainerId" + trainerId);
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData =
        new FormData.fromMap({"key": key, "trainer_id": trainerId});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/fetch_workout",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  /////////////////////fetchExerciseByWorkout //////////////////////////

  Future fetchExerciseByWorkoutApi(String workoutId) async {
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({
      "key": key,
      "trainer_id": trainerId,
      "workout_id": workoutId,
    });

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/fetch_exercise_by_workout_id",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  /////////////////////mealTakenApi//////////////////////////

  Future mealTakenApi(String mealId, String foodId) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap(
        {"key": key, "meal_id": mealId, "food_id": foodId});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/meal_taken",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  /////////////////////fetchWorkoutByDatesApi //////////////////////////

  Future fetchWorkoutByDatesApi(String date) async {
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap(
        {"key": key, "trainer_id": trainerId, "date": date});

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/workout_by_dates",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  /////////////////////submitAnswerApi//////////////////////////

  Future submitAnswerApi(
      String question, String option, String description) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({
      "key": key,
      "question": question,
      "option": option,
      "description": description
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("UserRestApi/submit_answer", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////////storeMeasurementApi///////////////////////////////

  Future storeSubscriptionApi(
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
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    print(trainerId);
    FormData formData = new FormData.fromMap({
      "key": key,
      "weight": weight,
      "neck": neck,
      "thigh": thigh,
      "abs": abs,
      "chest_triceps": chestTriceps,
      "right_thigh": rightThigh,
      "left_thigh": leftThigh,
      "hips": hips,
      "waist": waist,
      "lower_abs": lowerAbs,
      "upper_abs": upperAbs,
      "right_biceps": rightBiceps,
      "left_biceps": leftBiceps,
      "chest": chest,
      "shoulders": shoulder,
    });

    print(formData.fields);

    try {
      final response = await dioClient.post(
        "UserRestApi/store_measurement",
        data: formData,
      );
      return response;
    } catch (e) {}
  }

  /////////////////////////////////SEND MESSAGE Api/////////////////////////////////////

  Future sendMessageApi(msg) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    try {
      FormData formData =
          new FormData.fromMap({"key": key, "msg_to": trainerId, "msg": msg});

      print(formData.fields);

      final response =
          await dioClient.post("UserRestApi/send_message", data: formData);
      return response;
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////////////New SEND MESSAGE Api////////////////////////////////////////////

  Future newSendMessageApi(msg, filename) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);
    try {
      FormData formData = new FormData.fromMap({
        "key": key,
        "msg_to": trainerId,
        "msg": "",
        "image": MultipartFile.fromFileSync(filename.path)
      });

      final response =
          await dioClient.post("UserRestApi/send_message", data: formData);
      return response;
    } catch (e) {
      print(e);
    }
  }

  ///////////////////////////////// fetchIndividualChatApi //////////////////////////

  ResponseFetchChatMessage responseIndividudal;

  Future<ResponseFetchChatMessage> fetchIndividualChat() async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId =
        await SharedPrefManager.getPrefrenceString(AppConstant.TRAINERID);

    try {
      FormData formData =
          new FormData.fromMap({"key": key, "msg_to": trainerId});

      print(formData.fields);

      final response =
          await dioClient.post("UserRestApi/fetch_message", data: formData);
      responseIndividudal = ResponseFetchChatMessage.fromJson(response);
      return responseIndividudal;
    } catch (e) {
      print(e);
    }
  }
}
