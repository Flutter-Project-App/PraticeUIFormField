import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application/data/models/patient.dart';
import 'package:flutter_application/utils/colors.dart';

class ListPatientPage extends StatelessWidget {
  static const ROUTE_NAME = 'ListPatientPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách bệnh nhân'),
        titleTextStyle: TextStyle(fontSize: 10),
        centerTitle: true,
      ),
      body: ListPatientView(),
    );
  }
}

class ListPatientView extends StatefulWidget {
  const ListPatientView({Key? key}) : super(key: key);

  @override
  _ListPatientViewState createState() => _ListPatientViewState();
}

class _ListPatientViewState extends State<ListPatientView>
    with SingleTickerProviderStateMixin, RestorationMixin {
  TabController? _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  final List<Patient> patientList = [
    Patient("02", "Đoàn Việt Anh", "35", "Nữ", "Đau dạ dày mãn tĩnh"),
    Patient("04", "Đoàn Việt", "35", "Nam", "Đau dạ dày mãn tĩnh"),
    Patient("04", "Đoàn Việt", "35", "Nam", "Đau dạ dày mãn tĩnh"),
  ];

  @override
  String? get restorationId => 'tab_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController?.index = tabIndex.value;
  }

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    _tabController?.addListener(() {
      setState(() {
        tabIndex.value = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ["Tử vong", "Xin về", "Chuyển khoa nội", "Ra viện", "Đã về"];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: mainColor,
          labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          unselectedLabelColor: textColor,
          labelPadding: EdgeInsets.all(14),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
                color: mainColor, width: 2, style: BorderStyle.solid),
          ),
          isScrollable: true,
          tabs: [for (final tab in tabs) Text(tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
              child: ListView.builder(
                  itemCount: patientList.length,
                  itemBuilder: (BuildContext context, index) =>
                      buildPatientCard(context, index))),
          Text(tabs[1]),
          Text(tabs[2]),
          Text(tabs[3]),
          Text(tabs[4]),
        ],
      ),
    );
  }

  Widget buildPatientCard(BuildContext context, int index) {
    return Container(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print("1");
        },
        splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
        highlightColor: Colors.transparent,
        child: Card(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 16,
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                child: Text(
                  patientList[index].bed,
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    patientList[index].name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                      "${patientList[index].age} tuổi, ${patientList[index].gender}",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  SizedBox(
                    height: 4,
                  ),
                  Text(patientList[index].diseases,
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  SizedBox(
                    height: 16,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
