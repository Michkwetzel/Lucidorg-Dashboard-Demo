import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/auth/user_profile_data/userProfileData.dart';
import 'package:platform_front/lucid_HR/dataClasses/email_data_class.dart';
import 'package:platform_front/lucid_HR/dataClasses/job_search_data_class.dart';

class JobSearchState {
  final bool loading;
  final List<JobSearchDataClass> jobSearchData;

  JobSearchState({required this.loading, required this.jobSearchData});

  JobSearchState copyWith({bool? loading, List<JobSearchDataClass>? jobSearchData}) {
    return JobSearchState(
      loading: loading ?? this.loading,
      jobSearchData: jobSearchData ?? this.jobSearchData,
    );
  }

  factory JobSearchState.initial() {
    return JobSearchState(loading: true, jobSearchData: []);
  }
}

class JobSearchNotifier extends StateNotifier<JobSearchState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserProfileDataNotifier userInfo;
  late List<String> allJobSearchUIDs;

  JobSearchNotifier({required this.userInfo}) : super(JobSearchState.initial());

  Future<void> getJobSearchUIDs() async {
    print('Starting getJobSearchUIDs');

    final docRef = await firestore.collection('jobSearchMetrics_HR').doc(userInfo.companyUID).get();

    var rawData = docRef.data()!['allJobSearchUIDs'];
    allJobSearchUIDs = List<String>.from(rawData);

    print('Completed getJobSearchUIDs: Retrieved ${allJobSearchUIDs.length} job search UIDs: $allJobSearchUIDs');
  }

  Future<void> loadAllJobSearchData() async {
    List<JobSearchDataClass> allJobSearchData = [];

    for (var jobSearch in allJobSearchUIDs) {
      // First load emails
      List<EmailDataClass> allEmailsData = [];
      final collectionPath = firestore.collection("jobSearchData_HR/${userInfo.companyUID}/$jobSearch");
      final querySnapshot = await collectionPath.get();

      for (var doc in querySnapshot.docs) {
        // Load emailDataClass
        print(doc.data());
        EmailDataClass emailDataClass = EmailDataClass.fromMap(doc.data(), doc.id);
        allEmailsData.add(emailDataClass);
      }

      final docRef = await firestore.collection("jobSearchMetrics_HR/${userInfo.companyUID}/$jobSearch").doc("metrics").get();
      print(docRef.data());

      JobSearchDataClass jobSearchDataClass = JobSearchDataClass.loadMetricsFromMap(docRef.data()!, allEmailsData, jobSearch);
      allJobSearchData.add(jobSearchDataClass);
    }
    state = state.copyWith(loading: false, jobSearchData: allJobSearchData);
  }
}
