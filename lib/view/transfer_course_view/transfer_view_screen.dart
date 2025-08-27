import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';

class TransferViewScreen extends StatelessWidget {
  const TransferViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
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
                title: 'Transfer Course',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Enter Mobile Number in which you want to transfer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: Get.height * .011),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: _textField(context),
                    ),
                    SizedBox(height: Get.height * .049),
                    Divider(color: AppColor.dividerClr,thickness: 1),
                    SizedBox(height: Get.height * .022),
                    Text("Select Courses",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    SizedBox(height: Get.height * .025),

                    _transferCourseList(context),

                    SizedBox(height: Get.height * .048),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
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
                            Text("Verify with OTP",
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
                    ),
                  ],
                ),
              ),
            )
          ],
      ),
    );
  }

  Widget _transferCourseList(BuildContext context){
    return GridView.builder(
      padding: const EdgeInsets.all(0.0),
      controller: ScrollController(),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: context.screenHeight * .198
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){

          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffC5D3F7).withOpacity(0.5),
                    blurRadius: 4.81,
                    spreadRadius: 2.0,
                    offset: const Offset(1.64, 2.19),
                  )
                ]
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * .011),
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: 'https://img.freepik.com/free-photo/woman-beach-with-her-baby-enjoying-sunset_52683-144131.jpg?size=626&ext=jpg',
                          height: context.screenHeight * .130,
                          width: context.screenWidth * .22,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(height: Get.height * .011),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const FittedBox(
                            child: Text('Name',
                              style: TextStyle(
                                  color: Color(0xff7E8099),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  height: 1.0
                              ),
                            ),
                          ),
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
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: Get.height * .013,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
                    decoration: BoxDecoration(
                      color: const Color(0xffE45A3B),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text('Physical',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _textField(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 69.0,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 2.5,
                spreadRadius: 0.1,
                offset: Offset(0.0,4.0)
            )
          ],
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: null,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onTap: (){
          },
          onEditingComplete: (){
            FocusScope.of(context).unfocus();
          },
          onTapOutside: (PointerDownEvent event){
            FocusScope.of(context).unfocus();
          },
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
            color: Color(0xffB6B8D1),
          ),
          cursorHeight: 30.0,
          cursorWidth: 1.0,
          cursorColor: Colors.white,
          decoration:   const InputDecoration(
            counterText: "",
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('  +91  ',
                    style: TextStyle(
                        color: Color(0xffB6B8D1),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500
                    )
                ),
                VerticalDivider(
                  color: Color(0xffE6E1E6),
                  width: 1.0,
                ),
                SizedBox(width: 20.0,)
              ],
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        )
    );
  }
}

