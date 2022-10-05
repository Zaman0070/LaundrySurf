

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/Admin/about_rider/rider_search_List.dart';
import 'package:laundry_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

import 'package:sizer/sizer.dart';

class Rider {
  final String? email, image,uid,phone;

  final DocumentSnapshot? documentSnapshot;

  Rider(
      {
        this.phone,
        this.uid,
        this.email,
        this.documentSnapshot,
        this.image});
}

class RiderSearchService {
  search({context, userList, provider}) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    showSearch(
      context: context,
      delegate: SearchPage<Rider>(
        onQueryUpdate: (s) => print(s),
        items: userList,
        searchLabel: 'Search Users',
        suggestion: const RiderSearchList(),
        failure:const  Center(
          child: Text('No Product found :('),
        ),
        filter: (user) => [
          user.email,
          // user.uid,
         user.phone
         // user.sUid,

        ],
        builder: (user) => Column(
          children: [
            ListTile(
              onTap: () {
               },
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                      height: 6.h,
                      width: 6.h,
                      child: Image.network(
                        user.image!,
                        fit: BoxFit.cover,
                      ))),
              title: Text(user.email!),
              subtitle: Text(user.uid!),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            height: 20.h,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Are you sure?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    SizedBox(width: 5.w),
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteUser(user.documentSnapshot!.id);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.delete),
              )

            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
  Future<void> deleteUser(String userId) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

//17.30