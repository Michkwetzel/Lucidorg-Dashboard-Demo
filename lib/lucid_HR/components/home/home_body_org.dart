import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_HR/config/providers_hr.dart';
import 'package:platform_front/lucid_HR/dataClasses/job_search_data_class.dart';

class HomeBodyOrg extends ConsumerStatefulWidget {
  const HomeBodyOrg({super.key});

  @override
  ConsumerState<HomeBodyOrg> createState() => _HomeBodyOrgState();
}

class _HomeBodyOrgState extends ConsumerState<HomeBodyOrg> {
  late List<Stream<JobSearchDataClass>> jobSearchStreams;
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          SizedBox(
            width: 1060,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Home Lucid HR",
                  style: kH1TextStyle,
                ),
                TextButton(
                    onPressed: () async {
                      await ref.read(jobSearchNotifier.notifier).getJobSearchUIDs();
                      await ref.read(jobSearchNotifier.notifier).loadAllJobSearchData();
                      setState(() {
                        done = true;
                      });
                    },
                    child: Text("Press me")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
