import 'dart:io';

import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  //Object To Fetch User Image, Name, Number
  UserSettings userSettings = UserSettings();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );

  //Header
  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: 50.0,
        ),

        //User Information.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 50.0,
              child: UserSettings.profileImage == null
                  ? Image.asset(
                      'images/dummyImage.png',
                    )
                  : Image.file(
                      File('${UserSettings.profileImage?.path}'),
                    ),
            ),
            Column(
              children: [
                Text(
                  '${UserSettings.name}',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${UserSettings.phone}',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // Container(
            //     decoration: BoxDecoration(
            //         color: greenColor,
            //         borderRadius: BorderRadius.all(Radius.circular(10.0))),
            //     height: 30.0,
            //     width: 40.0,
            //     child: Center(
            //       child: Text(
            //         'Edit',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ))
          ],
        ),
      );

//Drawer Items
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          //Dashboard
          SingleLevelTile(
            name: 'Dashboard',
            icon: Icon(FontAwesomeIcons.gaugeHigh),
            color: primaryColor,
            screen: Dashboard.id,
          ),

          //Human Resources
          MultiLevelTile(
            icon: Icon(FontAwesomeIcons.user),
            name: 'Human Resources',
            subLevelTiles: [
              SingleLevelTile(
                name: 'Add User',
                screen: AddUser.id,
              ),
              SingleLevelTile(
                name: 'Staff List',
                screen: StaffList.id,
              ),
              SingleLevelTile(
                name: 'User List',
                screen: UserList.id,
              ),
              SingleLevelTile(
                name: 'Add Salary',
                screen: AddSalary.id,
              ),
              SingleLevelTile(
                  name: 'Employee Salary', screen: EmployeeSalary.id),
            ],
          ),

          //Milk Parlor
          MultiLevelTile(
              icon: Icon(Icons.water_drop_sharp),
              name: 'Milk Parlor',
              subLevelTiles: [
                SingleLevelTile(
                    name: 'Add Milk Collection', screen: AddMilkCollection.id),
                SingleLevelTile(name: 'Collect Milk', screen: CollectMilk.id),
                SingleLevelTile(name: 'Add Milk Sale', screen: AddMilkSale.id),
                SingleLevelTile(name: 'Sale Milk', screen: SaleMilk.id),
                SingleLevelTile(
                  name: 'Milk Sale Due',
                  screen: MilkSaleDue.id,
                )
              ]),

          //Cow Feed
          MultiLevelTile(
              icon: Icon(Icons.restaurant),
              name: 'Cow Feed',
              subLevelTiles: [
                SingleLevelTile(
                    name: 'Add Cow Feed Information',
                    screen: AddCowFeedInformation.id),
                SingleLevelTile(
                    name: 'Cow Feed Information', screen: CowFeed.id),
              ]),

          //Cow Monitor
          MultiLevelTile(
              icon: Icon(Icons.monitor),
              name: 'Cow Monitor',
              subLevelTiles: [
                SingleLevelTile(
                  name: 'Add Routine Information',
                  screen: AddRoutineInformation.id,
                ),
                SingleLevelTile(
                    name: 'Routine Monitor', screen: RoutineMonitor.id),
                SingleLevelTile(
                  name: 'Add Vaccine Information',
                  screen: AddVaccineInformation.id,
                ),
                SingleLevelTile(
                  name: 'Vaccine Monitor',
                  screen: VaccineMonitor.id,
                ),
                SingleLevelTile(
                  name: 'Add Animal Pregnancy Information',
                  screen: AddAnimalPregnancyInformation.id,
                ),
                SingleLevelTile(
                    name: 'Animal Pregnancy', screen: AnimalPregnancy.id),
              ]),

          //Farm Expense
          MultiLevelTile(
              icon: Icon(FontAwesomeIcons.moneyBill1),
              name: 'Farm Expense',
              subLevelTiles: [
                SingleLevelTile(
                  name: 'Add Farm Expense',
                  screen: AddExpense.id,
                ),
                SingleLevelTile(name: 'Farm Expense', screen: ExpenseList.id),
              ]),

          //Suppliers
          MultiLevelTile(
              icon: Icon(FontAwesomeIcons.users),
              name: 'Suppliers',
              subLevelTiles: [
                SingleLevelTile(
                  name: 'Add Supplier',
                  screen: AddSupplier.id,
                ),
                SingleLevelTile(
                    name: 'Suppliers List', screen: SuppliersList.id),
              ]),

          //Management
          MultiLevelTile(
              icon: Icon(Icons.manage_accounts),
              name: 'Management',
              subLevelTiles: [
                SingleLevelTile(
                  name: 'Add Cow',
                  screen: AddCow.id,
                ),
                SingleLevelTile(name: 'Manage Cow', screen: ManageCow.id),
                SingleLevelTile(
                  name: 'Add Calf',
                  screen: AddCalf.id,
                ),
                SingleLevelTile(name: 'Manage Calf', screen: ManageCalf.id),
                SingleLevelTile(
                  name: 'Add Stall',
                  screen: AddStall.id,
                ),
                SingleLevelTile(name: 'Manage Stalls', screen: ManageStalls.id)
              ]),

          //Catalog
          MultiLevelTile(
              icon: Icon(Icons.apps),
              name: 'Catalog',
              subLevelTiles: [
                // SingleLevelTile(
                //   name: 'Branch',
                //   screen: Branch.id,
                // ),
                SingleLevelTile(
                  name: 'User Type',
                  screen: UserType.id,
                ),
                // SingleLevelTile(
                //   name: 'Designation',
                //   screen: Designation.id,
                // ),
                SingleLevelTile(
                  name: 'Catalog Colors',
                  screen: CatalogColors.id,
                ),
                SingleLevelTile(
                  name: 'Animal Type',
                  screen: AnimalTypes.id,
                ),
                SingleLevelTile(
                  name: 'Vaccines',
                  screen: Vaccines.id,
                ),
                SingleLevelTile(
                  name: 'Food Item',
                  screen: FoodItem.id,
                ),
                // SingleLevelTile(
                //   name: 'Food Unit',
                //   screen: FoodUnit.id,
                // ),
              ]),

          //Reports
          MultiLevelTile(
            icon: Icon(FontAwesomeIcons.chartColumn),
            name: 'Reports',
            subLevelTiles: [
              SingleLevelTile(
                name: 'Expense Report',
                screen: ExpenseReport.id,
              ),
              SingleLevelTile(
                name: 'Employee Salary Report',
                screen: EmployeeSalaryReport.id,
              ),
              SingleLevelTile(
                name: 'Milk Collection Report',
                screen: MilkCollectionReport.id,
              ),
              SingleLevelTile(
                name: 'Milk Sale Report',
                screen: MilkSaleReport.id,
              ),
              SingleLevelTile(
                name: 'Vaccine Monitor Report',
                screen: VaccineMonitorReport.id,
              ),
              SingleLevelTile(
                name: 'Cow Sale Report',
                screen: CowSaleReport.id,
              ),
              // SingleLevelTile(
              //   name: 'Animal Statistics Report',
              //   screen: AnimalStatistics.id,
              // ),
            ],
          ),

          //Settings
          SingleLevelTile(
              name: 'Settings',
              icon: Icon(FontAwesomeIcons.wrench),
              color: primaryColor,
              screen: UserSettings.id),

          //Log Out
          SingleLevelTile(
              name: 'Logout',
              icon: Icon(Icons.logout),
              color: primaryColor,
              screen: Login.id),
        ],
      );
}
