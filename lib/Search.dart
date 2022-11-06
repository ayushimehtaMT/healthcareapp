
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/MedicineDetails.dart';
import 'package:healthcareapp/MedicineModel.dart';
import 'package:healthcareapp/SearchMedicinesProvider.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => {

      }, icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new),
      onPressed: () => {
        Navigator.pop(context)
      },
    );
  }


  SearchMedicinesProvider searchMedicinesProvider = SearchMedicinesProvider();

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder(future: searchMedicinesProvider.getMedicines(query),
          builder: (context, AsyncSnapshot<List<Medicine>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(
                  color: Colors.blue
              ),);
            }
            return ListView.builder(
                itemCount: snapshot.data!.length <= 3 ? snapshot.data!.length : 3,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(snapshot.data![index]!.productName!,
                                style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) =>
                            MedicineDetails(data: snapshot.data![index]!),
                        ));
                      },
                    ),
                  );
                });
        }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Medicines',
        style: GoogleFonts.getFont(
          'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

}