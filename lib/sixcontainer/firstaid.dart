// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/sixcontainer/FirstaidPages/cpr.dart';

class FirstaidPge extends StatefulWidget {
  const FirstaidPge({super.key});

  @override
  State<FirstaidPge> createState() => _FirstaidPgeState();
}

class _FirstaidPgeState extends State<FirstaidPge> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusNode currenfocus = FocusScope.of(context);
        if (!currenfocus.hasPrimaryFocus) {
          currenfocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xff7a73e7),
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => const BottomNavigatorBar(),
                    ));
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              centerTitle: true,
              expandedHeight: 190,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/silva.jpg",
                  fit: BoxFit.fill,
                ),
                title: Text(
                  "F  I  R  S  T   A  I  d",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/cprFront.jpg",
                      text: "CPR",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "CPR",
                              imageSrc: "assets/images/lip.jpg",
                              content:
                                  "Assess the Scene Safety: Before approaching the person needing CPR, ensure the area is safe for both you and the victim. Look out for any potential dangers or hazards.Check Responsiveness: Gently shake the person and ask loudly if they are okay. If there's no response, shout for help and call emergency services.Protect Yourself: Use protective barriers such as gloves or a face shield to reduce the risk of infection and bodily fluid exposure.Position the Person: Lay the person on their back on a firm, flat surface. Ensure their airway is clear.Perform Compressions Properly: Place the heel of your hand on the center of the person's chest (usually between the nipples), interlace fingers, and push hard and fast—about 100 to 120 compressions per minute. Ensure you fully release pressure between compressions.Give Rescue Breaths: Open the airway using the head-tilt, chin-lift maneuver. Pinch the nose closed and give two rescue breaths, each lasting about one second, ensuring chest rise. Then, continue compressions.Minimize Interruptions: Try to minimize interruptions during CPR to maintain blood circulation. If you're alone, perform CPR for about two minutes before calling emergency services (if you haven't already) to provide continuous compressions and rescue breaths.Rotate if Possible: Performing CPR can be physically demanding. If there's someone available to take over, switch roles every two minutes to avoid fatigue and maintain effective compressions.Follow Training Guidelines: If you're certified in CPR, follow the guidelines you were taught. Stay focused and perform the techniques correctly.Do Not Hesitate: Act quickly and decisively. Every second counts in a cardiac arrest situation.",
                              siteUrl:
                                  "https://www.verywellhealth.com/how-to-do-cpr-1298446"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/nosebleeding1.jpg",
                      text: "NOSE  BLEEDING",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "NOSE BLEEDING",
                              imageSrc: "assets/images/nosebleeding2.jpg",
                              content:
                                  "Stay Calm: Although nosebleeds can be alarming, staying calm is crucial. Panic can elevate blood pressure and worsen the bleeding.Sit up straight: Do not tilt your head backward. Instead, sit upright and lean slightly forward. This helps prevent blood from flowing down the back of your throat.Pinch the nostrils: Using your thumb and forefinger, pinch the soft parts of your nose (just below the bony bridge) and apply constant pressure for about 10-15 minutes. Breathing through your mouth, try not to release the pressure during this time. If the bleeding persists, continue to apply pressure for an additional 10 minutes.Avoid blowing your nose: Blowing your nose right after a nosebleed can disrupt any clot that may have formed, potentially causing the bleeding to start again.Use a cold compress: Applying a cold compress or an ice pack wrapped in a towel to the bridge of the nose can help constrict blood vessels, which might help stop the bleeding.Moisturize your nasal passages: Use a saline spray or apply a thin layer of petroleum jelly to the inside of your nose to prevent it from drying out, which can cause further irritation and bleeding.Avoid irritants: Try to avoid picking your nose, forceful nose-blowing, or any other activities that may cause irritation to the nasal passages.Seek medical help if the bleeding doesn't stop: If the bleeding persists for more than 20-30 minutes despite applying pressure or is recurrent, seek medical attention. It might be a sign of an underlying issue that needs to be addressed.Preventive measures: If you experience frequent nosebleeds, you might want to use a humidifier to add moisture to the air and avoid excessive dryness in your nasal passages. Also, be gentle when cleaning or blowing your nose.",
                              siteUrl:
                                  "https://www.onlymyhealth.com/4-tips-to-control-nose-bleeding-with-these-simple-home-remedies-1587634025"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/first-aid-electric-shock2.png",
                      text: "ELECTRIC SHOCK",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "ELECTRIC SHOCK",
                              imageSrc: "assets/images/electricshock1.jpg",
                              content:
                                  "Safety First: Ensure the safety of yourself and others before approaching the person who has been shocked. Ensure the power is off and the area is safe to enter. Do not touch the person while they are still in contact with the electrical source.Switch Off Power: If possible, turn off the source of electricity or unplug the device causing the shock. If this isn’t possible, use a non-conductive item (such as a wooden stick or a dry cloth) to separate the person from the electrical source. Do not use conductive materials, such as metal objects, as they can transmit electricity to you.Call for Help: Dial emergency services immediately. Even if the person appears to be okay, it's important to get medical help to ensure there are no hidden injuries or internal damage.\nTreatment:\nCheck for Responsiveness: If the person is unconscious but still breathing, check for responsiveness. If they are not breathing, start CPR if you're trained to do so.Do Not Touch the Person: Until you’re certain the electrical source is turned off, do not touch the person as they might still be conducting electricity.Assess the Situation: Check for any visible injuries. If there are burns or injuries, avoid touching them directly, and cover the burns with a dry, sterile dressing if available.Keep the Person Warm and Calm: Cover the person with a blanket or clothing to keep them warm. Try to keep them calm and reassure them that help is on the way.Do Not Administer Water or Food: Avoid giving the person food or water if they are unconscious or having difficulty swallowing.Monitor Vital Signs: If the person is breathing and has a pulse, continue monitoring their vital signs until medical help arrives.Do Not Move the Person Unless Absolutely Necessary: Moving an injured person might worsen their condition or cause further harm. However, if the person is in immediate danger (such as if there's a fire), carefully move them to safety.",
                              siteUrl:
                                  "https://www.atlantictraining.com/blog/15-safety-precautions-electrical-safety/"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/heartstroke1.jpg",
                      text: "HEART STROKE",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "HEART STROKE",
                              imageSrc: "assets/images/heartstroke2.jpg",
                              content:
                                  "Move to a Cooler Area: If someone is experiencing heatstroke, move them to a shaded or air-conditioned area immediately.Call for Emergency Assistance: Heatstroke can be life-threatening. Call emergency medical services or take the person to the nearest hospital for immediate medical attention.Cool the Body: Use any means available to cool the person. This can include applying cool water to the skin, using a fan, or placing ice packs or cold, wet towels on their body. Focusing on the armpits, neck, groin, and back where blood vessels are closer to the skin can help cool the body faster.Remove Excess Clothing: Loosen or remove any unnecessary clothing to help the body cool down.Hydration: If the person is conscious, give them cool water to drink. Avoid beverages that contain caffeine or alcohol.Monitor the Person: Continuously monitor their temperature and watch for any changes in their condition.Remember, heatstroke is a medical emergency. Taking prompt action can help prevent serious complications or even save a life. Always seek professional medical help as soon as possible.",
                              siteUrl:
                                  "https://www.news-medical.net/news/20230125/Sobering-statistics-from-the-AHAs-2023-heart-disease-and-stroke-update.aspx"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/asthma1 (1).jpg",
                      text: "ASTHMA",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "ASTHMA ",
                              imageSrc: "assets/images/asthma2.jpg",
                              content:
                                  "Stay Calm: Encourage the person experiencing the asthma attack to remain calm. Anxiety or panic can exacerbate the symptoms.Assist in Taking Medication: Help the person use their prescribed inhaler or nebulizer. Typically, it is a quick-relief medication like albuterol. Instruct them on how to properly use the inhaler if necessary.Encourage Upright Position: Help the person sit in an upright position, as this can make breathing easier. Loosen any tight clothing that might restrict breathing.Monitor the Person: Keep a close watch on the person's condition. Be ready to seek emergency medical assistance if their symptoms worsen or don't improve after using their inhaler.Eliminate Triggers: If you know the person's triggers (such as smoke, dust, pollen, etc.), try to remove or avoid those triggers from the environment.Provide Support: Reassure the person experiencing the attack and encourage them to continue taking slow, deep breaths. Stay with them until help arrives or the symptoms subside.Emergency Services: If the symptoms do not improve within a few minutes or if the person is having extreme difficulty breathing, call emergency services immediately.Remember, while these precautions can help manage an asthma attack in the short term, it's essential for individuals with asthma to have a well-defined asthma action plan and proper medications prescribed by a healthcare professional for long-term management.",
                              siteUrl:
                                  "https://www.livescience.com/41264-asthma-symptoms-treatment.html"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/mental1.jpg",
                      text: "MENTAL DISORDER",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "MENTAL DISORDER",
                              imageSrc: "assets/images/MENTAL2.jpg",
                              content:
                                  "Education and Awareness: Promoting mental health awareness can help in recognizing symptoms early, reducing stigma, and encouraging individuals to seek help.Healthy Lifestyle: Encouraging a healthy lifestyle that includes regular exercise, a balanced diet, and sufficient sleep can contribute to good mental health.Stress Management: Teaching stress reduction techniques such as mindfulness, meditation, or relaxation exercises can help in coping with stress, which can often be a trigger for mental health issues.Early Intervention: Addressing mental health concerns at the earliest sign is important. Encouraging people to seek help from mental health professionals if they notice changes in their behavior, emotions, or thinking patterns.Support Systems: Creating supportive environments within families, schools, workplaces, and communities helps individuals feel safe and supported, which can prevent the exacerbation of mental health conditions.Limiting Substance Abuse: Avoiding or minimizing the use of alcohol, drugs, or other substances that can affect mental health is important.Therapeutic Interventions: Psychological therapies and counseling can be useful for managing stress, anxiety, depression, and various mental health conditions.Regular Check-Ups: Encouraging regular health check-ups and mental health screenings can help in early identification of any potential issues.Healthy Communication: Promoting open and healthy communication within families and communities helps in reducing stress and the risk of mental health problems.Work-Life Balance: Encouraging a healthy balance between work, social life, and personal time is crucial in preventing burnout and mental health issues related to stress.It's important to note that these precautions might not prevent all mental health disorders, but they can significantly reduce the risk and support overall mental well-being. For individuals with diagnosed mental health conditions, following treatment plans, medications (if prescribed), and maintaining contact with healthcare providers is crucial. If you or someone you know is experiencing mental health issues, seeking professional help from a mental health specialist or therapist is essential.",
                              siteUrl:
                                  "https://economictimes.indiatimes.com/news/how-to/role-of-stress-in-mental-illness-learning-how-to-cope/articleshow/87177199.cms?from=mdr"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/choking.jpg",
                      text: "CHOKING",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "CHOCKING",
                              imageSrc: "assets/images/choking1.jpg",
                              content:
                                  "For conscious adults and children:\nEncourage Coughing: If the person is coughing forcefully, let them try to clear the blockage themselves. Do not intervene unless the person becomes unable to cough, talk, or breathe.Perform Abdominal Thrusts (Heimlich Maneuver): Stand behind the person and place your arms around their waist. Make a fist with one hand and place it slightly above the navel but below the ribcage. Grasp your fist with your other hand and thrust inward and upward in a quick, forceful motion. Repeat until the object is dislodged.\nFor unconscious adults:Call Emergency Services: Immediately call for emergency medical help.Perform CPR: If the person is unresponsive, begin CPR. Before giving breaths, open the mouth and perform a finger sweep to remove any visible objects. Then, start CPR with chest compressions and rescue breaths.\nFor conscious infants (under 1 year old):\nBack Blows and Chest Thrusts: If an infant is conscious but having difficulty breathing, place them face down along your forearm, supporting the head with your hand. Deliver up to five back blows between the shoulder blades with the heel of your hand. If the object is not dislodged, turn the infant face-up, supporting their head, and perform up to five chest thrusts on the center of the chest with two fingers.\nCall for Help: If the obstruction is not cleared, call emergency services.\nCall Emergency Services: Immediately call for emergency medical help.Perform CPR: For unconscious infants, CPR is performed by delivering chest compressions with two fingers (or two thumbs encircling the chest) and providing gentle breaths into the infant's mouth and nose.",
                              siteUrl:
                                  "https://www.mymed.com/health-wellness/interesting-health-info/what-to-do-when-someone-is-choking/how-to-recognise-the-signs-of-choking"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/bleeding1.jpg",
                      text: "BLEEDING",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "BLEEDING",
                              imageSrc: "assets/images/bleeding2.jpg",
                              content:
                                  "Ensure Safety: Before assisting the injured person, make sure the scene is safe for both them and you. This might involve assessing any potential dangers or hazards that caused the bleeding.Personal Protective Equipment (PPE): Wear gloves or any other available protective gear to prevent contact with the person's blood. This minimizes the risk of infection transmission.Assess the Situation: Determine the severity of the bleeding. Apply pressure with a clean cloth or sterile dressing directly on the wound to control bleeding.Call for Help: For severe bleeding, or if the bleeding doesn’t stop after applying direct pressure for a few minutes, call emergency services immediately.Elevate the Wound: If possible, raise the injured area above the level of the heart to help slow the bleeding.Apply Continuous Pressure: Maintain pressure on the wound using a clean cloth or bandage until help arrives. If blood soaks through the cloth, do not remove it; simply add another layer on top.Do Not Remove Impaled Objects: If an object is impaled in the wound, do not remove it. Stabilize the object without putting pressure on it and seek medical help.Monitor the Person: Keep the person calm and still. If they show signs of shock (pale, cold, clammy skin, rapid pulse, shallow breathing), lay them down, elevate their legs (unless this causes pain or is inadvisable due to injury), and cover them to keep them warm.Clean and Dress Wounds: Once bleeding is under control, if possible, clean the wound with water and cover it with a sterile bandage or dressing to prevent infection.Do Not Apply Tourniquets: Tourniquets should only be used by those trained in their application and in situations of severe, life-threatening bleeding where other measures have failed.",
                              siteUrl:
                                  "https://www.medicalnewstoday.com/articles/321996"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/burning.jpg",
                      text: "BURN",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "BURN",
                              imageSrc: "assets/images/burned.jpg",
                              content:
                                  "Safety first: Ensure the safety of both the victim and yourself before providing assistance. Check for any ongoing hazards or potential dangers in the environment, and if the situation is unsafe, wait for emergency services.Stop the burning process: If the burn is caused by a heat source, immediately remove the person from the source of the burn and stop the burning process. For instance, extinguish flames, remove hot objects, or rinse the burn area with cool water for at least 10-20 minutes to dissipate the heat.Assess the severity: Determine the severity of the burn. Burns are typically classified into three categories: first-degree, second-degree, and third-degree. Each category requires different levels of care.First-degree burns: Affect the outer layer of skin, causing redness and minor inflammation.Second-degree burns: Affect deeper layers, causing blistering, severe pain, and possible swelling.Third-degree burns: Penetrate through all layers of the skin, potentially causing white or blackened skin, numbness, and severe tissue damage.Do not break blisters: If blisters have formed, do not break them. Blisters help protect the skin underneath and breaking them can increase the risk of infection.Cover the burn: Once the burn is cooled, cover it with a clean, non-adhesive, dry dressing or a sterile, non-fluffy cloth to protect it from further injury or infection.Avoid home remedies: Avoid using any home remedies like butter, oil, or toothpaste on the burn, as they can trap heat or cause infection.Pain management: For minor burns, over-the-counter pain medications like acetaminophen or ibuprofen can help manage pain. However, for severe burns, immediate medical attention is crucial.Seek medical help: For severe burns or burns that cover a large area of the body, seek immediate medical attention. Signs of severe burns may include charred or white skin, intense pain, difficulty breathing, and shock.Keep the person warm: Cover the individual with a clean, dry cloth or blanket to prevent hypothermia, especially if a large portion of their body is burned.Monitor for signs of shock: Burns can lead to shock due to fluid loss. Look for signs such as pale skin, shallow breathing, rapid pulse, and confusion.",
                              siteUrl:
                                  "https://www.cederroth.com/knowledge-insights/burns-the-a-to-z-of-rapid-treatment/"),
                        ));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListOfFirstAid(
                      size: size,
                      img: "assets/images/fracture.jpg",
                      text: "FRACTURE",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "FRACTURE",
                              imageSrc: "assets/images/fracture2.jpg",
                              content:
                                  "Ensure Safety: Before providing aid, assess the scene for any potential hazards or dangers. Make sure it's safe for you to approach the injured person.Call for Medical Help: If the fracture is severe, involves an open wound, or if you suspect a bone is broken, call for emergency medical assistance immediately.Prevent Movement: Encourage the injured person to remain still and avoid moving the affected area. Immobilize the injured limb or joint to prevent further damage. Do not try to realign or straighten the broken bone.Stabilize the Fracture: Use available materials to immobilize the injured area. You can use splints, pillows, or towels to support and immobilize the injured limb. Avoid putting direct pressure on the site of the fracture.Control Bleeding: If there's an open wound or the fracture has caused bleeding, apply gentle pressure with a clean cloth to control the bleeding. However, avoid pressing directly on the site of the fracture.Elevate the Injured Area: If possible and appropriate, elevate the injured limb above the level of the heart to help reduce swelling and pain.Apply Cold Compress: Apply a cold compress or ice pack wrapped in a cloth to the injured area to help reduce swelling and alleviate pain. Do not apply ice directly to the skin as it can cause damage.Offer Comfort and Reassurance: Stay with the injured person, offering comfort and reassurance until medical help arrives. Keep the person calm and try to reduce their anxiety.Monitor Vital Signs: Continuously monitor the injured person's condition, paying attention to breathing, pulse, and level of consciousness. Be ready to administer CPR if necessary.Do Not Give Food or Drink: Do not offer the injured person food or drink in case they need surgery, as they might require anesthesia, which generally requires an empty stomach.Remember, providing first aid for a fracture is meant to stabilize the injured person until professional medical help arrives. If you're unsure or uncomfortable providing first aid for a fracture, focus on maintaining the injured person's comfort and safety while waiting for emergency medical services to arrive.",
                              siteUrl:
                                  "https://southshoreorthopedics.com/common-types-of-bone-fractures/"),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListOfFirstAid extends StatelessWidget {
  ListOfFirstAid({
    super.key,
    required this.size,
    required this.text,
    required this.img,
    required this.onTap,
  });

  final Size size;
  final String text;
  final String img;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height / 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 21, fontWeight: FontWeight.w700),
            ),
          )),
        ],
      ),
    );
  }
}
