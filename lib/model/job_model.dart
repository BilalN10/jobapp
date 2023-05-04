import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JObsModel {
  String? jobId;
  String? accomodation;
  String? allowcatedForFuture;
  String? allowcatedForFuture1;
  String? allowcatedForFuture2;
  String? allowcatedForFuture3;
  String? contractPeriodinYears;
  String? country;
  String? currency;
  String? dailyWorkHour;
  String? deadlineAd;
  String? deadlineBS;

  String? employerName;
  String? employerEmail;
  String? employerLocation;
  String? estimatedSalary;
  String? expiryDate;
  String? femaleQuotaApproved;
  String? foodFacility;
  String? freeTicket;
  String? freeVisa;
  String? headline;
  String? jobIdentifier;
  String? jobTitle;
  String? jobTitleEnglish;
  String? licenseNo;
  String? linkTOPage;
  String? locationGoogleMap;
  String? lotNumber;
  String? maleQuotaApproved;
  String? newsPaperImage;
  String? newspaperDetailsName;
  String? newspaperDetailsPublishDate;
  String? newspaperDetailsSlogan;
  String? other;
  String? post;
  String? qualification;
  String? recruitingAgencyLocation;
  String? recruitingAgencyName;
  String? recruitingAgencyPhone_1;
  String? recruitingAgencyPhone_2;
  String? remainningFemaleQuota;
  String? remainMaleQuota;
  String? ramainingDays;
  String? sallary;
  String? scrappingDate;
  String? skillType;
  String? totalExpense;
  String? weeklyWorkDay;
  String? countryFlag;

  JObsModel(
      {this.jobId,
      this.accomodation,
      this.allowcatedForFuture,
      this.allowcatedForFuture1,
      this.allowcatedForFuture2,
      this.allowcatedForFuture3,
      this.contractPeriodinYears,
      this.country,
      this.currency,
      this.dailyWorkHour,
      this.deadlineAd,
      this.employerEmail,
      this.employerLocation,
      this.employerName,
      this.estimatedSalary,
      this.expiryDate,
      this.femaleQuotaApproved,
      this.foodFacility,
      this.freeTicket,
      this.freeVisa,
      this.headline,
      this.jobIdentifier,
      this.jobTitle,
      this.licenseNo,
      this.linkTOPage,
      this.locationGoogleMap,
      this.lotNumber,
      this.maleQuotaApproved,
      this.newsPaperImage,
      this.newspaperDetailsName,
      this.newspaperDetailsPublishDate,
      this.newspaperDetailsSlogan,
      this.other,
      this.post,
      this.qualification,
      this.ramainingDays,
      this.recruitingAgencyLocation,
      this.recruitingAgencyName,
      this.recruitingAgencyPhone_1,
      this.recruitingAgencyPhone_2,
      this.remainMaleQuota,
      this.remainningFemaleQuota,
      this.sallary,
      this.scrappingDate,
      this.skillType,
      this.totalExpense,
      this.weeklyWorkDay,
      this.countryFlag,
      this.deadlineBS,
      this.jobTitleEnglish});

  JObsModel.fromSnamshot(DocumentSnapshot<Map<String, dynamic>> data) {
    jobId = data.id;
    accomodation = data.data()!["accomodation"].toString() == 'null'
        ? '----'
        : data.data()!["accomodation"].toString();
    allowcatedForFuture =
        data.data()!["allocated_for_future"].toString() == 'null'
            ? '----'
            : data.data()!["allocated_for_future"].toString();
    allowcatedForFuture1 =
        data.data()!["allocated_for_future_1"].toString() == 'null'
            ? '----'
            : data.data()!["allocated_for_future_1"].toString();
    allowcatedForFuture2 =
        data.data()!["allocated_for_future_2"].toString() == 'null'
            ? '----'
            : data.data()!["allocated_for_future_2"].toString();
    allowcatedForFuture3 =
        data.data()!["allocated_for_future_3"].toString() == 'null'
            ? '----'
            : data.data()!["allocated_for_future_3"].toString();
    contractPeriodinYears =
        data.data()!["contract_period_in_years"].toString() == 'null'
            ? '----'
            : data.data()!["contract_period_in_years"].toString();
    country = data.data()!["country"].toString() == 'null'
        ? '----'
        : data.data()!["country"].toString();
    currency = data.data()!["currency"].toString() == 'null'
        ? '----'
        : data.data()!["currency"].toString();
    dailyWorkHour = data.data()!["daily_work_hour"].toString() == 'null'
        ? '----'
        : data.data()!["daily_work_hour"].toString();
    deadlineAd = data.data()!["deadline_AD"].toString() == 'null'
        ? '----'
        : data.data()!["deadline_AD"].toString();
    deadlineBS = data.data()!["deadline_BS"].toString() == 'null'
        ? '----'
        : data.data()!["deadline_BS"].toString();

    employerName = data.data()!["employer_Name"].toString() == 'null'
        ? '----'
        : data.data()!["employer_Name"].toString();
    employerEmail = data.data()!["employer_email"].toString() == 'null'
        ? '----'
        : data.data()!["employer_email"].toString();
    employerLocation = data.data()!["employer_location"].toString() == 'null'
        ? '----'
        : data.data()!["employer_location"].toString();
    estimatedSalary = data.data()!["estimated_salary"].toString() == 'null'
        ? '----'
        : data.data()!["estimated_salary"].toString();
    expiryDate = data.data()!["expiry_day_remaining"].toString() == 'null'
        ? '----'
        : data.data()!["expiry_day_remaining"].toString();

    femaleQuotaApproved =
        data.data()!["female_Quota_approved"].toString() == 'null'
            ? '----'
            : data.data()!["female_Quota_approved"].toString();
    foodFacility = data.data()!["food_facility"].toString() == 'null'
        ? '----'
        : data.data()!["food_facility"].toString();
    freeTicket = data.data()!["free_ticket"].toString() == 'null'
        ? '----'
        : data.data()!["free_ticket"].toString();
    freeVisa = data.data()!["free_visa"].toString() == 'null'
        ? '----'
        : data.data()!["free_visa"].toString();
    headline = data.data()!["headline"].toString() == 'null'
        ? '----'
        : data.data()!["headline"].toString();
    jobIdentifier = data.data()!["job_identifier"].toString() == 'null'
        ? '----'
        : data.data()!["job_identifier"].toString();
    jobTitle = data.data()!["job_title"].toString() == 'null'
        ? '----'
        : data.data()!["job_title"].toString();
    jobTitleEnglish = data.data()!["job_title_english"].toString() == 'null'
        ? '----'
        : data.data()!["job_title_english"].toString();

    licenseNo = data.data()!["license_No"].toString() == 'null'
        ? '----'
        : data.data()!["license_No"].toString();
    linkTOPage = data.data()!["link_to_page"].toString() == 'null'
        ? '----'
        : data.data()!["link_to_page"].toString();
    locationGoogleMap = data.data()!["location_google_map"].toString() == 'null'
        ? '----'
        : data.data()!["location_google_map"].toString();
    lotNumber = data.data()!["lot_number"].toString() == 'null'
        ? '----'
        : data.data()!["lot_number"].toString();
    maleQuotaApproved = data.data()!["male_quota_approved"].toString() == 'null'
        ? '----'
        : data.data()!["male_quota_approved"].toString();
    newsPaperImage =
        data.data()!["newspaper_details_link_to_image"].toString() == 'null'
            ? '----'
            : data.data()!["newspaper_details_link_to_image"].toString();
    newspaperDetailsName =
        data.data()!["newspaper_details_name"].toString() == 'null'
            ? '----'
            : data.data()!["newspaper_details_name"].toString();
    newspaperDetailsPublishDate =
        data.data()!["newspaper_details_publish_date"].toString() == 'null'
            ? '----'
            : data.data()!["newspaper_details_publish_date"].toString();
    newspaperDetailsSlogan =
        data.data()!["newspaper_details_slogan"].toString() == 'null'
            ? '----'
            : data.data()!["newspaper_details_slogan"].toString();
    other = data.data()!["others"].toString() == 'null'
        ? '----'
        : data.data()!["others"].toString();
    post = data.data()!["post"].toString() == 'null'
        ? '----'
        : data.data()!["post"].toString();
    qualification = data.data()!["qualification"].toString() == 'null'
        ? '----'
        : data.data()!["qualification"].toString();
    recruitingAgencyLocation =
        data.data()!["recruiting_agency_location"] == 'null'
            ? '----'
            : data.data()!["recruiting_agency_location"];
    recruitingAgencyName =
        data.data()!["recruiting_agency_name"].toString() == 'null'
            ? '----'
            : data.data()!["recruiting_agency_name"].toString();
    recruitingAgencyPhone_1 =
        data.data()!["recruiting_agency_phone_1"].toString() == 'null'
            ? '----'
            : data.data()!["recruiting_agency_phone_1"].toString();
    recruitingAgencyPhone_2 =
        data.data()!["recruiting_agency_phone_2"].toString() == 'null'
            ? '----'
            : data.data()!["recruiting_agency_phone_2"].toString();
    remainningFemaleQuota =
        data.data()!["remaining_Female_quota"].toString() == 'null'
            ? '----'
            : data.data()!["remaining_Female_quota"].toString();
    remainMaleQuota = data.data()!["remaining_Male_quota"].toString() == 'null'
        ? '----'
        : data.data()!["remaining_Male_quota"].toString();
    ramainingDays = data.data()!["remaining_days"].toString() == 'null'
        ? '----'
        : data.data()!["remaining_days"].toString();
    sallary = data.data()!["sallary"].toString() == 'null'
        ? '----'
        : data.data()!["sallary"].toString();
    scrappingDate = data.data()!["scrapping_Date"].toString() == 'null'
        ? '----'
        : data.data()!["scrapping_Date"].toString();
    skillType = data.data()!["skill_type"].toString() == 'null'
        ? '----'
        : data.data()!["skill_type"].toString();
    totalExpense = data.data()!["total_expenses_in_NPR"].toString() == 'null'
        ? '----'
        : data.data()!["total_expenses_in_NPR"].toString();
    weeklyWorkDay = data.data()!["weekly_work_day"].toString() == 'null'
        ? '----'
        : data.data()!["weekly_work_day"].toString();
    countryFlag = data.data()!["country_flag"].toString() == 'null'
        ? '----'
        : data.data()!["country_flag"].toString();
  }

  factory JObsModel.fromSnapshot(DocumentSnapshot data) {
    return JObsModel(
      jobId: data.id,
      accomodation: data['accomodation'].toString() == 'null'
          ? '----'
          : data['accomodation'].toString(),
      allowcatedForFuture: data['allocated_for_future'].toString() == 'null'
          ? '----'
          : data['allocated_for_future'].toString(),
      allowcatedForFuture1: data['allocated_for_future_1'].toString() == 'null'
          ? '----'
          : data['allocated_for_future_1'].toString(),
      allowcatedForFuture2: data['allocated_for_future_2'].toString() == 'null'
          ? '----'
          : data['allocated_for_future_2'].toString(),
      allowcatedForFuture3: data['allocated_for_future_3'].toString() == 'null'
          ? '----'
          : data['allocated_for_future_3'].toString(),
      contractPeriodinYears:
          data['contract_period_in_years'].toString() == 'null'
              ? '----'
              : data['contract_period_in_years'].toString(),
      country: data['country'].toString() == 'null'
          ? '----'
          : data['country'].toString(),
      currency: data['currency'].toString() == 'null'
          ? '----'
          : data['currency'].toString(),
      dailyWorkHour: data['daily_work_hour'].toString() == 'null'
          ? '----'
          : data['daily_work_hour'].toString(),
      deadlineAd: data['deadline_AD'].toString() == 'null'
          ? '----'
          : data['deadline_AD'].toString(),
      deadlineBS: data['deadline_BS'].toString() == 'null'
          ? '----'
          : data['deadline_BS'].toString(),
      employerName: data['employer_Name'].toString() == 'null'
          ? '----'
          : data['employer_Name'].toString(),
      employerEmail: data['employer_email'].toString() == 'null'
          ? '----'
          : data['employer_email'].toString(),
      employerLocation: data['employer_location'].toString() == 'null'
          ? '----'
          : data['employer_location'].toString(),
      estimatedSalary: data['estimated_salary'].toString() == 'null'
          ? '----'
          : data['estimated_salary'].toString(),
      expiryDate: data['expiry_day_remaining'].toString() == 'null'
          ? '----'
          : data['expiry_day_remaining'].toString(),
      femaleQuotaApproved: data['female_Quota_approved'].toString() == 'null'
          ? '----'
          : data['female_Quota_approved'].toString(),
      foodFacility: data['food_facility'].toString() == 'null'
          ? '----'
          : data['food_facility'].toString(),
      freeTicket: data['free_ticket'].toString() == 'null'
          ? '----'
          : data['free_ticket'].toString(),
      freeVisa: data['free_visa'].toString() == 'null'
          ? '----'
          : data['free_visa'].toString(),
      headline: data['headline'].toString() == 'null'
          ? '----'
          : data['headline'].toString(),
      jobIdentifier: data['job_identifier'].toString() == 'null'
          ? '----'
          : data['job_identifier'].toString(),
      jobTitle: data['job_title'].toString() == 'null'
          ? '----'
          : data['job_title'].toString(),
      jobTitleEnglish: data['job_title_english'].toString() == 'null'
          ? '----'
          : data['job_title_english'].toString(),
      linkTOPage: data['link_to_page'].toString() == 'null'
          ? '----'
          : data['link_to_page'].toString(),
      licenseNo: data['license_No'].toString() == 'null'
          ? '----'
          : data['license_No'].toString(),
      locationGoogleMap: data['location_google_map'].toString() == 'null'
          ? '----'
          : data['location_google_map'].toString(),
      lotNumber: data['lot_number'].toString() == 'null'
          ? '----'
          : data['lot_number'].toString(),
      maleQuotaApproved: data['male_quota_approved'].toString() == 'null'
          ? '----'
          : data['male_quota_approved'].toString(),
      newsPaperImage:
          data['newspaper_details_link_to_image'].toString() == 'null'
              ? '----'
              : data['newspaper_details_link_to_image'].toString(),
      newspaperDetailsName: data['newspaper_details_name'].toString() == 'null'
          ? '----'
          : data['newspaper_details_name'].toString(),
      newspaperDetailsPublishDate:
          data['newspaper_details_publish_date'].toString() == 'null'
              ? '----'
              : data['newspaper_details_publish_date'].toString(),
      newspaperDetailsSlogan:
          data['newspaper_details_slogan'].toString() == 'null'
              ? '----'
              : data['newspaper_details_slogan'].toString(),
      other: data['others'].toString() == 'null'
          ? '----'
          : data['others'].toString(),
      post:
          data['post'].toString() == 'null' ? '----' : data['post'].toString(),
      qualification: data['qualification'].toString() == 'null'
          ? '----'
          : data['qualification'].toString(),
      recruitingAgencyLocation:
          data['recruiting_agency_location'].toString() == 'null'
              ? '----'
              : data['recruiting_agency_location'].toString(),
      recruitingAgencyName: data['recruiting_agency_name'].toString() == 'null'
          ? '----'
          : data['recruiting_agency_name'].toString(),
      recruitingAgencyPhone_1:
          data['recruiting_agency_phone_1'].toString() == 'null'
              ? '----'
              : data['recruiting_agency_phone_1'].toString(),
      recruitingAgencyPhone_2:
          data['recruiting_agency_phone_2'].toString() == 'null'
              ? '----'
              : data['recruiting_agency_phone_2'].toString(),
      remainningFemaleQuota: data['remaining_Female_quota'].toString() == 'null'
          ? '----'
          : data['remaining_Female_quota'].toString(),
      remainMaleQuota: data['remaining_Male_quota'].toString() == 'null'
          ? '----'
          : data['remaining_Male_quota'].toString(),
      ramainingDays: data['remaining_days'].toString() == 'null'
          ? '----'
          : data['remaining_days'].toString(),
      sallary: data['sallary'].toString() == 'null'
          ? '----'
          : data['sallary'].toString(),
      scrappingDate: data['scrapping_Date'].toString() == 'null'
          ? '----'
          : data['scrapping_Date'].toString(),
      skillType: data['skill_type'].toString() == 'null'
          ? '----'
          : data['skill_type'].toString(),
      totalExpense: data['total_expenses_in_NPR'].toString() == 'null'
          ? '----'
          : data['total_expenses_in_NPR'].toString(),
      weeklyWorkDay: data['weekly_work_day'].toString() == 'null'
          ? '----'
          : data['weekly_work_day'].toString(),
      countryFlag: data['country_flag'].toString() == 'null'
          ? '----'
          : data['country_flag'].toString(),
    );
  }

  // factory JObsModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return JObsModel(
  //     jobTitleEnglish: data['job_title_english'],
  //     country: data['country'],
  //     maleQuotaApproved: data['male_quota_approved'].toString(),
  //     sallary: data['salary'].toString(),
  //     currency: data['currency'].toString(),
  //   );
  // }

  // factory JObsModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>
  //   return JObsModel(
  //     country: data['country'],
  //     accomodation : data.data()!["accomodation"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["accomodation"].toString(),
  //   allowcatedForFuture :
  //       data.data()!["allocated_for_future"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["allocated_for_future"].toString(),
  //   allowcatedForFuture1 :
  //       data.data()!["allocated_for_future_1"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["allocated_for_future_1"].toString(),
  //   allowcatedForFuture2 :
  //       data.data()!["allocated_for_future_2"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["allocated_for_future_2"].toString(),
  //   allowcatedForFuture3 :
  //       data.data()!["allocated_for_future_3"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["allocated_for_future_3"].toString(),
  //   contractPeriodinYears :
  //       data.data()!["contract_period_in_years"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["contract_period_in_years"].toString(),
  //   country : data.data()!["country"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["country"].toString(),
  //   currency : data.data()!["currency"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["currency"].toString(),
  //   dailyWorkHour : data.data()!["daily_work_hour"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["daily_work_hour"].toString(),
  //   deadlineAd : data.data()!["deadline_AD"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["deadline_AD"].toString(),
  //   deadlineBS : data.data()!["deadline_BS"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["deadline_BS"].toString(),

  //   employerName : data.data()!["employer_Name"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["employer_Name"].toString(),
  //   employerEmail : data.data()!["employer_email"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["employer_email"].toString(),
  //   employerLocation : data.data()!["employer_location"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["employer_location"].toString(),
  //   estimatedSalary : data.data()!["estimated_salary"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["estimated_salary"].toString(),
  //   expiryDate : data.data()!["expiry_day_remaining"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["expiry_day_remaining"].toString(),

  //   femaleQuotaApproved :
  //       data.data()!["female_Quota_approved"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["female_Quota_approved"].toString(),
  //   foodFacility : data.data()!["food_facility"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["food_facility"].toString(),
  //   freeTicket : data.data()!["free_ticket"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["free_ticket"].toString(),
  //   freeVisa : data.data()!["free_visa"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["free_visa"].toString(),
  //   headline : data.data()!["headline"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["headline"].toString(),
  //   jobIdentifier : data.data()!["job_identifier"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["job_identifier"].toString(),
  //   jobTitle : data.data()!["job_title"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["job_title"].toString(),
  //   jobTitleEnglish : data.data()!["job_title_english"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["job_title_english"].toString(),

  //   licenseNo : data.data()!["license_No"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["license_No"].toString(),
  //   linkTOPage : data.data()!["link_to_page"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["link_to_page"].toString(),
  //   locationGoogleMap : data.data()!["location_google_map"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["location_google_map"].toString(),
  //   lotNumber : data.data()!["lot_number"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["lot_number"].toString(),
  //   maleQuotaApproved : data.data()!["male_quota_approved"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["male_quota_approved"].toString(),
  //   newsPaperImage :
  //       data.data()!["newspaper_details_link_to_image"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["newspaper_details_link_to_image"].toString(),
  //   newspaperDetailsName :
  //       data.data()!["newspaper_details_name"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["newspaper_details_name"].toString(),
  //   newspaperDetailsPublishDate :
  //       data.data()!["newspaper_details_publish_date"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["newspaper_details_publish_date"].toString(),
  //   newspaperDetailsSlogan :
  //       data.data()!["newspaper_details_slogan"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["newspaper_details_slogan"].toString(),
  //   other : data.data()!["others"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["others"].toString(),
  //   post : data.data()!["post"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["post"].toString(),
  //   qualification : data.data()!["qualification"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["qualification"].toString(),
  //   recruitingAgencyLocation :
  //       data.data()!["recruiting_agency_location"] : 'null'
  //           ? '----'
  //           : data.data()!["recruiting_agency_location"],
  //   recruitingAgencyName :
  //       data.data()!["recruiting_agency_name"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["recruiting_agency_name"].toString(),
  //   recruitingAgencyPhone_1 :
  //       data.data()!["recruiting_agency_phone_1"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["recruiting_agency_phone_1"].toString(),
  //   recruitingAgencyPhone_2 :
  //       data.data()!["recruiting_agency_phone_2"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["recruiting_agency_phone_2"].toString(),
  //   remainningFemaleQuota :
  //       data.data()!["remaining_Female_quota"].toString() : 'null'
  //           ? '----'
  //           : data.data()!["remaining_Female_quota"].toString(),
  //   remainMaleQuota : data.data()!["remaining_Male_quota"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["remaining_Male_quota"].toString(),
  //   ramainingDays : data.data()!["remaining_days"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["remaining_days"].toString(),
  //   sallary : data.data()!["sallary"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["sallary"].toString(),
  //   scrappingDate : data.data()!["scrapping_Date"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["scrapping_Date"].toString(),
  //   skillType : data.data()!["skill_type"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["skill_type"].toString(),
  //   totalExpense : data.data()!["total_expenses_in_NPR"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["total_expenses_in_NPR"].toString(),
  //   weeklyWorkDay : data.data()!["weekly_work_day"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["weekly_work_day"].toString(),
  //   countryFlag : data.data()!["country_flag"].toString() : 'null'
  //       ? '----'
  //       : data.data()!["country_flag"].toString(),

  //   ),
  // }

  Future<DocumentSnapshot<Map<String, dynamic>>> toDocumentSnapshot(
      String jobId) async {
    final document =
        await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();
    return document;
  }
}
