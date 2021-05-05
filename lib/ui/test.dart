import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Widget searchBarUI(String komut) {
    return FloatingSearchBar(
      hint: "Lütfen $komut seçiniz",
      openAxisAlignment: 0.0,
      maxWidth: 600,
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
      elevation: 4.0,
      physics: BouncingScrollPhysics(),
      onQueryChanged: (query) async {
        setState(() {});
        //  await cariara(query);
        setState(() {});
      },
      // showDrawerHamburger: false,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.close_outlined),
            onPressed: () {
              setState(() {});
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            color: Colors.white,
            child: Container(
                height: 400.0,
                color: Colors.white,
                child: Text(
                    "ff") /*ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true, //
                  itemCount: liscar == null ? 0 : liscar.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () {
                          cari = liscar[index];
                          print(cari.cariunvani);
                          conmus.text = cari.cariunvani;
                          liscar = [];
                          setState(() {
                            arama = false;
                          });
                        },
                        title: Text(liscar[index].cariunvani ?? ""),
                      ),
                    );
                  }),*/
                ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("gfd"),
          Text("hyf"),
          Container(
            height: 500,
            child: Stack(
              fit: StackFit.expand,
              children: [
                /*     TextFormField(
                    readOnly: true,
                    //   controller: conmus,
                    onChanged: (v) async {
                      setState(() {
                        //       _isloading = true;
                      });
                      //      await cariara(v);
                      setState(() {
                        //    _isloading = false;
                      });
                    },
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    //    validator: (value) {
                    // validation logic
                    //      },
                  ),*/
                Container(
                  height: 400,
                  color: Colors.red,
                  child: Text("ff"),
                ),
                searchBarUI("dd")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
