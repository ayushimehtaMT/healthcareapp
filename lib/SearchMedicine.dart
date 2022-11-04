import 'package:flutter/material.dart';
import 'package:healthcareapp/MedicineDetails.dart';

class SearchMedicine extends StatefulWidget {
  const SearchMedicine({super.key, required this.title});
  final String title;

  @override
  State<SearchMedicine> createState() => SearchMedicineState();
}

class SearchMedicineState extends State<SearchMedicine>{
  TextEditingController controller = new TextEditingController();
  List<MedicineDetails> _searchResult = [];
  List<MedicineDetails> _medicineDetails = [];

  @override
  void initState() {
    super.initState();

    getMedicineDetails();
  }

  Future<Null> getMedicineDetails() async {
   // final response = await http.get(url);
    //final responseJson = json.decode(response.body);

    setState(() {
      //for (Map user in responseJson) {
        _medicineDetails.add(MedicineDetails(1, 'Abs CV Tablet', 'Dowell Pharmaceutical'));
        _medicineDetails.add(MedicineDetails(2, 'MG Clave 625 Tablet', 'Mega Biosciences'));
        _medicineDetails.add(MedicineDetails(3, 'Moxikind-CV 625 Tablet', 'Mankind Pharma Ltd'));
        _medicineDetails.add(MedicineDetails(4, 'Clavam 625 Tablet', 'Alkem Laboratories Ltd'));
        _medicineDetails.add(MedicineDetails(5, 'Moxclav 625 Tablet', 'Sun Pharmaceutical Industries Ltd'));
        _medicineDetails.add(MedicineDetails(6, 'Duet 625 Tablet', 'Lupin Ltd'));
        _medicineDetails.add(MedicineDetails(7, 'Novamox CV 625mg Tablet', 'Cipla Ltd'));
        _medicineDetails.add(MedicineDetails(8, 'Clavidur 625 Tablet', 'Lupin Ltd'));
        _medicineDetails.add(MedicineDetails(9, 'Mega-CV 625 Tablet', 'Aristo Pharmaceuticals Pvt Ltd'));
        _medicineDetails.add(MedicineDetails(10, 'Fightox 625 Tablet', 'Abbott'));
      //}
    });
  }

  @override
  Widget build(BuildContext context) {return new Scaffold(
    appBar: new AppBar(
      title: new Text('Search Medicine'),
      elevation: 0.0,
    ),
    body: new Column(
      children: <Widget>[
        new Container(
          color: Theme.of(context).primaryColor,
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              child: new ListTile(
                leading: new Icon(Icons.search),
                title: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                ),
                trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                  controller.clear();
                  onSearchTextChanged('');
                },),
              ),
            ),
          ),
        ),
        new Expanded(
          child: _searchResult.length != 0 || controller.text.isNotEmpty
              ? new ListView.builder(
            itemCount: _searchResult.length,
            itemBuilder: (context, i) {
              return new Card(
                child: new ListTile(
                  //leading: new CircleAvatar(backgroundImage: new NetworkImage(_searchResult[i].profileUrl,),),
                  title: new Text(_searchResult[i].medicineName),
                  subtitle: new Text(_searchResult[i].medicineDesc),
                ),
                margin: const EdgeInsets.all(0.0),
              );
            },
          )
              : new ListView.builder(
            itemCount: _medicineDetails.length,
            itemBuilder: (context, index) {
              return new Card(
                child: new ListTile(
                  //leading: new CircleAvatar(backgroundImage: new NetworkImage(_userDetails[index].profileUrl,),),
                  title: new Text(_medicineDetails[index].medicineName),
                  subtitle: new Text(_medicineDetails[index].medicineDesc),
                ),
                margin: const EdgeInsets.all(0.0),
              );
            },
          ),
        ),
      ],
    ),
  );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _medicineDetails.forEach((MedicineDetails) {
      if (MedicineDetails.medicineName.contains(text))
        _searchResult.add(MedicineDetails);
    });

    setState(() {});
  }
}