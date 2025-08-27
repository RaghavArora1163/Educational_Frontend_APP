import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:online/controllers/add_to_cart_controller/add_to_cart_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';

class AddToCart extends StatelessWidget {
   AddToCart({super.key});

  final addToCartController = Get.find<AddToCartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        SizedBox(
            height: Get.height * .07,
            width: Get.width * .5,
            child: _proceedBtn()),
      ],
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0.0,
            toolbarHeight: Get.height * .200,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
            flexibleSpace: CommonAppbar(
              isDrawerShow: false,
              isSearchShow: false,
              isNotificationShow: false,
              title: 'Your Cart',
              onLeadingTap: () {
                Get.back();
              },
              clipper: CustomAppBarClipper(),  // Pass the clipper
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Items are worth - ₹447",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppColor.textClr,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: Get.height * .011),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 15.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                            color: AppColor.boxShadowClr,
                            offset: const Offset(1.64,2.19),
                            spreadRadius: 0,
                            blurRadius: 4.81,
                          )
                        ],
                      ),
                      child: const FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Selected Items worth - ",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff566A9D),
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            Text("₹298",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff2CBA4B),
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * .029),
                  Divider(color: AppColor.dividerClr,thickness: 1),
                  SizedBox(height: Get.height * .018),
                  Text("Items in your Bag",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppColor.textClr,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: Get.height * .014),
                  _cartItemsCard(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cartItemsCard(BuildContext context){
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      controller: ScrollController(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.0),
      itemCount: 3,
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.boxShadowClr,
                    blurRadius: 4.81,
                    spreadRadius: 0,
                    offset: const Offset(1.64,2.19),
                  )
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.screenHeight *.020,
                  width: context.width *.050,
                  child: Checkbox(
                      value: false,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(
                        color: Color(0xff566A9D),
                        width: 1.0,
                      ),
                      checkColor: Colors.white,
                      activeColor: const Color(0xff566A9D),
                      focusColor: Colors.transparent,
                      onChanged: (value){
                      }
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                    height: Get.height * .130,
                    width: Get.width * .4,
                    child: Image.asset(AppVectors.introVectorImage,fit: BoxFit.cover)),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Relativity Albert Einstein",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: Get.height * .01),
                      const Text("By Mr. Akhilesh Pandey",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff7E8099),
                            fontWeight: FontWeight.w400,
                            height: 1.0
                        ),
                      ),
                      SizedBox(height: Get.height * .012),
                      const Text("₹399 (75% off)",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xffB6B8D1),
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(width: 19.0),
                      const Text("₹99",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff2CBA4B),
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      );
    },
    ) ;

  }

  Widget _proceedBtn(){
    return GestureDetector(
      onTap: (){
        payBtn();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: const GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Color(0xff616CDD),
                Color(0xff01579B),
              ],
            ),
            width:1,
          ),
          gradient: const LinearGradient(
              colors: [
                Color(0xff191C3D),
                Color(0xff434BA3)
              ]
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0,4),
              spreadRadius: 0,
            )
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Proceed",
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 10.0),
            Icon(Icons.arrow_forward,color: Colors.white,size: 20.0,)
          ],
        ),
      ),
    );
  }

  ///show frequently asked question bottom sheet
  void payBtn(){
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColor.scaffold2,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * .042),
                const Text('Address & Contact Information',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3B4255),
                  ),
                ),
                SizedBox(height: Get.height * .01),
                const Text('To proceed please fill the details in mandatory fields.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff7E8099),
                  ),
                ),
                SizedBox(height: Get.height * .017),
                commonTextFields(controller: addToCartController.bottomSheetTextFieldController,hintText: "Name",prefixIcon: Image.asset(AppIcons.userHelpSupportIcon)),
                commonTextFields(controller: addToCartController.bottomSheetTextFieldController,hintText: "Email",prefixIcon: Image.asset(AppIcons.emailHelpSupportIcon)),
                commonTextFields(controller: addToCartController.bottomSheetTextFieldController,hintText: "Mobile Number",prefixIcon: Image.asset(AppIcons.phoneHelpSupportIcon)),
                commonDropDownBtn(initialValue: addToCartController.selectedState, image: Image.asset(AppVectors.indiaFlagIcon,width: 24, height: 24,),title: "State"),
                commonDropDownBtn(initialValue: addToCartController.selectedState, image: Image.asset(AppIcons.districtHelpSupportIcon,width: 24, height: 24,),title: "District"),
                SizedBox(height: Get.height *.015),
                Center(
                  child: GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      width: Get.width * .5,
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                          color: AppColor.bgColor,
                          borderRadius: BorderRadius.circular(50.0),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xff191C3D),
                                Color(0xff434BA3),
                              ]
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0,2.0),
                              blurRadius: 2.0,
                              spreadRadius: 3.0,
                            )
                          ]
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Pay Now',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.0
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          Icon(Icons.arrow_forward_outlined,color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height *.02),
              ],
            ),
          ),
        )
    );
  }

  ///Common textField of bottomSheet
  commonTextFields({required TextEditingController controller, required String hintText,required Widget prefixIcon}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Container(
            transform: Matrix4.translationValues(0, 7, 0),
            height: Get.height * .06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffC5D3F7),
                    offset: Offset(1.19,2.19),
                    blurRadius: 4.81,
                    spreadRadius: 0,
                  )
                ]
            ),
          ),

          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                fillColor: AppColor.scaffold1,
                filled: true,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffBFBFCC),
                ),
                prefixIconConstraints: const BoxConstraints(
                    minHeight:20.0,
                    maxHeight: 20.0
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                  child: SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: prefixIcon),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                )
            ),
          ),

        ],
      ),
    );
  }

  ///DropDown Button
  commonDropDownBtn({required String? initialValue,required Widget image,required String title}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container  (
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffC5D3F7),
                offset: Offset(1.19,2.19),
                blurRadius: 4.81,
                spreadRadius: 0,
              )
            ]
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: Colors.white,
            value: initialValue,
            hint: Row(
              children: [
                const SizedBox(width: 8),
                image,
                const SizedBox(width: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffBFBFCC),
                  ),
                ),
              ],
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            onChanged: (newValue) {
              addToCartController.selectedState = newValue;
            },
            items: addToCartController.states.map<DropdownMenuItem>((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400,color: Colors.black)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
