import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medv/constants.dart';
import 'package:medv/screens/scanner/Scanner.dart';

class homeBody extends StatefulWidget {
  const homeBody({super.key});

  @override
  State<homeBody> createState() => _homeBodyState();
}

class _homeBodyState extends State<homeBody> {
  @override
  Widget build(BuildContext context) {
    var darkMode;
    return Container(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        onTap: () => Get.to(() => Scanner()),
        child: Container(
          width: 340,
          height: 500,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                "Medical Information ID",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: KDefaultPadding + 15, right: KDefaultPadding + 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 140,
                          width: 130,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/images/IDProfile.jpg"),
                            fit: BoxFit.cover,
                          )),
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: 125,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "John Doe",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18, // reduce font size
                                    ),
                              ),
                              Text(
                                "DOB : " + "07/06/2000",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13, // reduce font size
                                    ),
                              ),
                              Text(
                                "Height : " + "5'6",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13, // reduce font size
                                    ),
                              ),
                              Text(
                                "Weight : " + "72",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13, // reduce font size
                                    ),
                              ),
                              Text(
                                "Blood Type : " + "A+",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13, // reduce font size
                                    ),
                              ),
                              Text(
                                "Organ Donor : " + "No",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13, // reduce font size
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(height: 20, thickness: 2),
                    Container(
                      width: 270,
                      child: Column(
                        children: [
                          Text(
                            "Primary Medical Conditions:",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16, // reduce font size
                                ),
                          ),
                          Text(
                            "Diabeties, Asthma, Hiatal Hernia, Heart ByPass, Blood Pressure",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13, // reduce font size
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 270,
                      child: Column(
                        children: [
                          Text(
                            "Medications:",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16, // reduce font size
                                ),
                          ),
                          Text(
                            "Lidoderm Patch, Geratol, Vitamin D",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13, // reduce font size
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 270,
                      child: Column(
                        children: [
                          Text(
                            "Allergies:",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16, // reduce font size
                                ),
                          ),
                          Text(
                            "Penicillin, Sulfa, Peanuts",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13, // reduce font size
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Updated:" + "09/08/2022",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16, // reduce font size
                          ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              Spacer()
            ],
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ID.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(10, 0, 0, 0).withOpacity(0.1),
                    BlendMode.dstATop),
              ),
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    color: kPrimaryColor,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ]),
        ),
      ),
    );
  }
}
