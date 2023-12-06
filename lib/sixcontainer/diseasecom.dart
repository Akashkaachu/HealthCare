// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/homescreen.dart';
import 'package:healthcare/sixcontainer/FirstaidPages/cpr.dart';

class DeseaseComPge extends StatefulWidget {
  const DeseaseComPge({super.key});

  @override
  State<DeseaseComPge> createState() => _DeseaseComPgeState();
}

class _DeseaseComPgeState extends State<DeseaseComPge> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                "assets/images/diseasecompile.jpg",
                fit: BoxFit.fill,
              ),
              title: Text(
                "          DISEASE \nCOMPILISATION",
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/cancer1.jpg",
                    text: "CANCER ",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "CANCER",
                              imageSrc: "assets/images/cancer2.jpg",
                              content:
                                  "Managing Symptoms: Learn to recognize common symptoms or side effects of cancer and its treatments, such as nausea, vomiting, pain, fever, bleeding, or fatigue. Having an understanding of how to manage these symptoms or when to seek immediate medical attention is crucial.Wound Care: Patients undergoing cancer treatments like chemotherapy may experience side effects such as skin rashes, sores, or blisters. First aid includes caring for these wounds by keeping them clean, dry, and protected to prevent infection. Understanding proper wound care techniques is essential.Infection Control: Cancer patients, especially those undergoing chemotherapy or radiation, might have compromised immune systems, making them more susceptible to infections. First aid involves basic infection control measures such as proper hand hygiene, avoiding sick individuals, and maintaining a clean environment.Pain Management: Managing pain effectively is essential in cancer care. Providing or assisting the patient with their prescribed pain relief measures can be a part of first aid.Emergency Response: Be prepared for emergencies. Learn basic life support techniques such as CPR in case of emergencies like cardiac arrest. Additionally, knowing how to contact emergency medical services in your area is crucial.Psychological Support: Cancer patients might face emotional distress or anxiety. First aid can involve providing emotional support, active listening, and helping them access appropriate resources for mental health support.Remember, while providing first aid for cancer patients, it's crucial to prioritize their safety and comfort. However, always defer to medical professionals and seek immediate medical attention if there's any uncertainty or if the situation is beyond basic first aid measures. ",
                              siteUrl:
                                  "https://www.cancercenter.com/community/blog/2018/02/how-does-cancer-do-that-sizing-up-cells-and-their-shapes")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/HIV2.jpg",
                    text: "HIV",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "HIV",
                              imageSrc: "assets/images/HIV1.jpg",
                              content:
                                  "Managing Symptoms: Learn to recognize common symptoms or side effects of cancer and its treatments, such as nausea, vomiting, pain, fever, bleeding, or fatigue. Having an understanding of how to manage these symptoms or when to seek immediate medical attention is crucial.Wound Care: Patients undergoing cancer treatments like chemotherapy may experience side effects such as skin rashes, sores, or blisters. First aid includes caring for these wounds by keeping them clean, dry, and protected to prevent infection. Understanding proper wound care techniques is essential.Infection Control: Cancer patients, especially those undergoing chemotherapy or radiation, might have compromised immune systems, making them more susceptible to infections. First aid involves basic infection control measures such as proper hand hygiene, avoiding sick individuals, and maintaining a clean environment.Pain Management: Managing pain effectively is essential in cancer care. Providing or assisting the patient with their prescribed pain relief measures can be a part of first aid.Emergency Response: Be prepared for emergencies. Learn basic life support techniques such as CPR in case of emergencies like cardiac arrest. Additionally, knowing how to contact emergency medical services in your area is crucial.Psychological Support: Cancer patients might face emotional distress or anxiety. First aid can involve providing emotional support, active listening, and helping them access appropriate resources for mental health support.Remember, while providing first aid for cancer patients, it's crucial to prioritize their safety and comfort. However, always defer to medical professionals and seek immediate medical attention if there's any uncertainty or if the situation is beyond basic first aid measures. ",
                              siteUrl:
                                  "https://www.consultant360.com/articles/cutaneous-manifestations-hiv-infection-children-part-1-infection")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/OBESITY.jpg",
                    text: "OBESITY",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "OBESITY",
                              imageSrc: "assets/images/OBESITY2.jpg",
                              content:
                                  "Obesity is a complex, multifaceted health condition characterized by an excessive accumulation of body fat. It is a significant global health concern, with its prevalence steadily rising in many parts of the world. It results from a combination of genetic, environmental, behavioral, and hormonal factors.The Body Mass Index (BMI) is a commonly used metric to classify obesity. A BMI of 30 or higher is typically considered obese, although it's essential to note that BMI alone may not always accurately represent an individual's health, as it doesn't account for factors like muscle mass or distribution of fat.There are numerous causes and contributing factors to obesity:Unhealthy Diet: Consumption of high-calorie, low-nutrient foods, especially those high in sugars and fats, can lead to weight gain. Fast food, processed snacks, and sugary beverages contribute significantly to obesity.Lack of Physical Activity: Sedentary lifestyles, with minimal physical activity, are linked to weight gain. Modern conveniences, such as cars, elevators, and desk jobs, often lead to reduced physical movement.Genetics and Hormones: Genetic factors can influence an individual's predisposition to obesity. Hormonal imbalances or conditions affecting hormone regulation can also contribute to weight gain.Environmental Factors: Socioeconomic status, access to healthy food options, cultural influences, and environmental cues can impact dietary choices and lifestyle, affecting obesity rates.The implications of obesity on health are extensive and severe. It significantly increases the risk of developing various chronic conditions, including type 2 diabetes, cardiovascular diseases, hypertension, certain cancers, respiratory issues, and musculoskeletal disorders. It can also affect mental health, leading to depression and low self-esteem due to societal stigmatization and discrimination.Addressing and preventing obesity requires a multi-faceted approach:Healthy Eating Habits: Encouraging the consumption of a balanced diet rich in fruits, vegetables, lean proteins, and whole grains while limiting processed foods and sugary drinks.Regular Physical Activity: Promoting an active lifestyle through regular exercise and reducing sedentary behaviors.Education and Awareness: Raising awareness about the risks of obesity and providing education on healthy lifestyle choices from an early age.Policy Changes: Implementing policies that support healthier environments, such as providing access to nutritious foods in schools, workplaces, and communities, and promoting urban designs that encourage physical activity.Combating obesity requires a collaborative effort involving individuals, communities, healthcare professionals, policymakers, and the food and beverage industry to create a supportive environment for healthier choices and behaviors. Additionally, personalized approaches considering individual differences are crucial in addressing this complex health issue.",
                              siteUrl:
                                  "https://www.health.com/obesity-7967228")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/osteo1.jpg",
                    text: "OSTEOPOROSIS",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "OSTEOPOROSIS",
                              imageSrc: "assets/images/osteo1.jpg",
                              content:
                                  "Osteoporosis is a bone disease characterized by weakened, porous bones that are more susceptible to fractures. The condition occurs when the creation of new bone doesn’t keep pace with the removal of old bone. As a result, bones become brittle and fragile, making even a minor fall or stress on the bones potentially causing a fracture.Causes and Risk Factors:\nAge and Gender: Osteoporosis is more common in older adults, particularly women after menopause due to a decrease in estrogen levels.Hormonal Changes: Reduced sex hormones (estrogen in women and testosterone in men) contribute to bone loss.Family History and Genetics: A family history of osteoporosis can increase one's risk.Lifestyle Factors: Lack of exercise, a diet low in calcium and vitamin D, excessive alcohol consumption, smoking, and certain medications can increase the risk of osteoporosis.Symptoms:\nOsteoporosis is often referred to as a silent disease because it progresses without symptoms until a fracture occurs. Some indicators may include:Back Pain: Caused by a fractured or collapsed vertebra.Loss of Height: A stooped posture due to spinal bone fractures.Fractures: Easily occurring with minor bumps or falls, especially in the wrist, hip, or spine.Diagnosis and Treatment:Bone Density Tests: These tests measure bone mineral density and assess the risk of fractures. Dual-energy X-ray absorptiometry (DXA) scans are commonly used for diagnosis.Medications: Various medications help prevent bone loss and reduce the risk of fractures. These include bisphosphonates, hormone-related therapy, denosumab, and others.Lifestyle Changes: Regular weight-bearing and muscle-strengthening exercises, calcium and vitamin D supplements, and dietary changes can help manage the condition.Prevention:\nPreventing osteoporosis involves a combination of lifestyle modifications and, when necessary, medical intervention:Balanced Diet: Consuming adequate calcium and vitamin D, essential for bone health.Regular Exercise: Weight-bearing exercises and resistance training help maintain bone density and strength.Avoiding Risk Factors: Limiting alcohol consumption, quitting smoking, and being cautious about medications that may affect bone health.Osteoporosis is a chronic condition that requires long-term management to prevent fractures and maintain bone health. Early diagnosis, lifestyle changes, and appropriate medical treatment can significantly help in managing the condition and reducing the risk of fractures. Regular check-ups and consultations with healthcare professionals are important for those at risk or diagnosed with osteoporosis.",
                              siteUrl:
                                  "https://www.endocrine.org/patient-engagement/endocrine-library/osteoporosis")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/liver1.jpg",
                    text: "Liver Diseases".toUpperCase(),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DisplayFirstAidScrn(
                              title: "Liver Diseases".toUpperCase(),
                              imageSrc: "assets/images/liver1.jpg",
                              content:
                                  "Liver diseases encompass a wide range of conditions that affect the liver, a vital organ responsible for numerous functions within the body, including detoxification, protein synthesis, and the production of biochemicals necessary for digestion. Some common liver diseases include:Hepatitis:\nHepatitis A, B, C, D, and E: Viral infections that cause inflammation of the liver. They spread through various means including contaminated food or water (Hepatitis A and E) and blood-to-blood contact, sexual contact, or perinatal transmission (Hepatitis B, C, and D).Cirrhosis:\nCirrhosis: A late stage of scarring of the liver caused by many forms of liver diseases and conditions, such as chronic alcoholism, hepatitis B and C, and fatty liver disease.Fatty Liver Disease:Non-alcoholic Fatty Liver Disease (NAFLD): A condition where excessive fat builds up in the liver, not due to excessive alcohol consumption. It includes non-alcoholic fatty liver (NAFL) and non-alcoholic steatohepatitis (NASH), which is a more severe form associated with liver inflammation.Other Liver Conditions:\nLiver Cancer: It can arise within the liver or spread from other areas of the body.Autoimmune Hepatitis: The body's immune system attacks the liver causing inflammation and damage.Hemochromatosis: A genetic disorder causing the body to absorb too much iron, leading to liver damage and other complications.Symptoms of Liver Diseases:\nSymptoms can vary based on the specific liver condition, but some common signs include:\nJaundice (yellowing of the skin and eyes)\nAbdominal pain and swelling\nSwelling in the legs and ankles\nDark urine\nPale-colored stool\nFatigue\nNausea or vomiting\nDiagnosis and Treatment:\nDiagnosis often involves blood tests, imaging studies (like ultrasound or MRI), and sometimes liver biopsy to determine the specific condition.Treatment varies based on the cause of the liver disease and its severity. It might include lifestylechanges, medications, or in severe cases, liver transplant as a last resort.Prevention:\nAvoid excessive alcohol consumption.\nVaccination against hepatitis A and B.\nMaintain a healthy diet and exercise routine.Follow safe practices to prevent transmission of viral hepatitisLiver diseases can range from mild to severe, with some causing long-term damage or even life-threatening complications. Early detection and proper management, often through lifestyle changes and medical interventions, are essential in treating and controlling these conditions. Consulting with a healthcare professional is crucial for diagnosis, treatment, and ongoing management.",
                              siteUrl:
                                  "https://medlineplus.gov/liverdiseases.html")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/MUSCULAR DYSTROPHY.jpg",
                    text: "MUSCULAR DYSTROPHY",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "MUSCULAR DYSTROPHY",
                              imageSrc: "assets/images/MUSCULAR DYSTROPHY.jpg",
                              content:
                                  "Muscular Dystrophy (MD) is a group of genetic disorders characterized by progressive muscle weakness and degeneration. There are multiple types of muscular dystrophy, each caused by different genetic mutations affecting specific proteins essential for maintaining healthy muscle.Common Types of Muscular Dystrophy:Duchenne Muscular Dystrophy (DMD): One of the most common and severe forms, primarily affecting boys. It typically becomes apparent in early childhood and leads to progressive muscle weakness, making tasks like walking and even breathing challenging.Becker Muscular Dystrophy (BMD): Similar to DMD but less severe and with a later onset. The progression of muscle weakness tends to be slower in BMD.Facioscapulohumeral Muscular Dystrophy (FSHD): Affects the face, shoulders, and upper arms. Symptoms might include difficulty in closing the eyes, lifting arms, and some degree of facial weakness.Myotonic Dystrophy: The most common form in adults, characterized by prolonged muscle contractions (myotonia), weakness, and a range of other symptoms that can involve multiple body systems.Symptoms of Muscular Dystrophy:\nProgressive muscle weakness\nMuscle wasting\nMuscle stiffness\nTrouble with motor skills\nDifficulty walking\nContractures (tightening of muscles and tendons)\nRespiratory and cardiac complications in some types of MD\nDiagnosis and Treatment:\nDiagnosis involves a combination of physical examinations, genetic testing, muscle biopsies, and sometimes electromyography (EMG) to assess electrical activity in muscles.Currently, there is no cure for muscular dystrophy. Treatment focuses on managing symptoms and improving quality of life. This can include:Physical therapy to maintain mobility and flexibility.Assistive devices such as braces, walkers, or wheelchairs.Medications to manage symptoms and potentially slow disease progression in some cases.Some ongoing research into gene therapies and other potential treatments to address the genetic causes of muscular dystrophy.Management and Support:Regular medical monitoring is crucial to manage and address complications.Support groups and counseling can be invaluable for individuals and families dealing with muscular dystrophy, providing emotional support and information.Each type of muscular dystrophy has its own distinct features, age of onset, and rate of progression. While the conditions are often debilitating, advances in research and medical interventions continue to offer hope for improved treatments and potential therapies to address the underlying genetic causes of these disorders. Early detection, comprehensive care, and ongoing support play critical roles in managing the impact of muscular dystrophy on individuals and their families.",
                              siteUrl:
                                  "https://www.cdc.gov/ncbddd/musculardystrophy/facts.html")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/HUNTINGTONS DISEASE.jpg",
                    text: "HUNTINGTON'S DISEASE",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "HUNTINGTON'S DISEASE",
                              imageSrc: "assets/images/HUNTINGTONS DISEASE.jpg",
                              content:
                                  "Liver diseases encompass a wide range of conditions that affect the liver, a vital organ responsible for numerous functions within the body, including detoxification, protein synthesis, and the production of biochemicals necessary for digestion. Some common liver diseases include:Hepatitis:\nHepatitis A, B, C, D, and E: Viral infections that cause inflammation of the liver. They spread through various means including contaminated food or water (Hepatitis A and E) and blood-to-blood contact, sexual contact, or perinatal transmission (Hepatitis B, C, and D).Cirrhosis:\nCirrhosis: A late stage of scarring of the liver caused by many forms of liver diseases and conditions, such as chronic alcoholism, hepatitis B and C, and fatty liver disease.Fatty Liver Disease:Non-alcoholic Fatty Liver Disease (NAFLD): A condition where excessive fat builds up in the liver, not due to excessive alcohol consumption. It includes non-alcoholic fatty liver (NAFL) and non-alcoholic steatohepatitis (NASH), which is a more severe form associated with liver inflammation.Other Liver Conditions:\nLiver Cancer: It can arise within the liver or spread from other areas of the body.Autoimmune Hepatitis: The body's immune system attacks the liver causing inflammation and damage.Hemochromatosis: A genetic disorder causing the body to absorb too much iron, leading to liver damage and other complications.Symptoms of Liver Diseases:\nSymptoms can vary based on the specific liver condition, but some common signs include:\nJaundice (yellowing of the skin and eyes)\nAbdominal pain and swelling\nSwelling in the legs and ankles\nDark urine\nPale-colored stool\nFatigue\nNausea or vomiting\nDiagnosis and Treatment:\nDiagnosis often involves blood tests, imaging studies (like ultrasound or MRI), and sometimes liver biopsy to determine the specific condition.Treatment varies based on the cause of the liver disease and its severity. It might include lifestylechanges, medications, or in severe cases, liver transplant as a last resort.Prevention:\nAvoid excessive alcohol consumption.\nVaccination against hepatitis A and B.\nMaintain a healthy diet and exercise routine.Follow safe practices to prevent transmission of viral hepatitisLiver diseases can range from mild to severe, with some causing long-term damage or even life-threatening complications. Early detection and proper management, often through lifestyle changes and medical interventions, are essential in treating and controlling these conditions. Consulting with a healthcare professional is crucial for diagnosis, treatment, and ongoing management.",
                              siteUrl:
                                  "https://www.alz.org/alzheimers-dementia/what-is-dementia/types-of-dementia/huntington-s-disease")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/TUBERCULOSIS.jpg",
                    text: "TUBERCULOSIS",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "TUBERCULOSIS",
                              imageSrc: "assets/images/TUBERCULOSIS.jpg",
                              content:
                                  "Tuberculosis (TB) is a potentially serious infectious disease caused by bacteria known as Mycobacterium tuberculosis. It primarily affects the lungs but can also impact other parts of the body. TB spreads through the air when an infected person coughs, sneezes, or talks, allowing the bacteria to enter the air and be inhaled by others.Types of Tuberculosis:\nLatent TB Infection: In this condition, the bacteria remain in the body in an inactive state and do not cause symptoms. However, they can become active in the future. Latent TB is not contagious, but it can progress to active TB if not treated.Active TB Disease: This form of TB causes symptoms and can be contagious. It usually occurs within the first few years after infection but can also develop later if the immune system weakens.Symptoms of Active TB:\nPersistent cough lasting more than three weeks\nChest pain\nCoughing up blood or sputum\nWeakness or fatigue\nWeight loss\nFever and night sweats\nDiagnosis:\nTB skin test (Mantoux test)\nTB blood tests\nChest X-rays\nSputum tests to detect the bacteria\nTreatment:\nTB is treatable and curable with antibiotics. Treatment typically involves a combination of several antibiotics taken over several months. The most common regimen for drug-sensitive TB involves a 6-9 month course of antibiotics.\nPrevention:\nVaccination: The Bacille Calmette-Guérin (BCG) vaccine can help prevent severe forms of TB in children. However, its effectiveness in preventing pulmonary TB in adults is limited.\nIsolation and Protection: Infected individuals should cover their mouth and nose when coughing or sneezing, and avoid close contact with others until treatment makes them non-infectious.\nChallenges:\nDrug-Resistant TB: Some strains of TB bacteria have developed resistance to the antibiotics commonly used to treat the disease. Multi-drug-resistant TB (MDR-TB) and extensively drug-resistant TB (XDR-TB) are more challenging to treat and require different, more complex drug regimens.\nGlobal Health Issue: TB remains a significant global health problem, particularly in developing countries and among immunocompromised individuals.\nEarly diagnosis and treatment are essential in preventing the spread of TB and reducing its impact. Completing the full course of medication is critical to prevent the development of drug-resistant strains and ensure a successful recovery. Public health efforts and ongoing research continue to focus on strategies to control and ultimately eradicate TB worldwide.",
                              siteUrl:
                                  "https://www.premiumtimesng.com/news/headlines/562375-global-tuberculosis-cases-increase-for-first-time-in-20-years-report.html?tztc=1")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/Diabetesmellitus.jpg",
                    text: "DIABETES NELLITUS",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "DIABETES NELLITUS",
                              imageSrc: "assets/images/Diabetesmellitus.jpg",
                              content:
                                  "Type 1 Diabetes: Typically diagnosed in children and young adults. It's an autoimmune condition where the immune system mistakenly attacks and destroys insulin-producing cells in the pancreas, leading to little to no insulin production.Type 2 Diabetes: More common in adults, although it's increasingly seen in younger individuals. In this type, the body either does not produce enough insulin or cannot effectively use the insulin it produces.Gestational Diabetes: Develops during pregnancy and usually goes away after the baby is born. However, it increases the risk of both the mother and child developing Type 2 diabetes later in life.Diagnosis and Treatment:Diabetes is diagnosed through blood tests measuring blood sugar levels. Management and treatment of diabetes involve various approaches:Lifestyle Changes: A healthy diet, regular physical activity, and weight management are crucial for managing both Type 1 and Type 2 diabetes.Medications: Insulin and oral medications may be prescribed for Type 1 and Type 2 diabetes, respectively. Some individuals with Type 2 diabetes may require insulin as the disease progresses.Regular Monitoring: Keeping track of blood sugar levels and maintaining regular check-ups with healthcare providers is essential to manage the condition effectively.Education and Support: Learning about the condition and seeking support from healthcare professionals, nutritionists, and support groups is crucial for effective self-management.Prevention:\nType 1 diabetes cannot be prevented, but Type 2 diabetes can often be prevented or delayed by maintaining a healthy lifestyle, including a balanced diet, regular physical activity, and weight management.Diabetes management aims to keep blood sugar levels within a target range to prevent or delay complications. Early diagnosis, regular monitoring, and adherence to a treatment plan are critical in managing diabetes effectively and living a healthy life.",
                              siteUrl:
                                  "https://en.wikipedia.org/wiki/Diabetes")));
                    },
                  ),
                  const SizedBox(height: 15),
                  ListOfDisease(
                    size: size,
                    img: "assets/images/stroke.jpg",
                    text: "STROKE",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DisplayFirstAidScrn(
                              title: "STROKE",
                              imageSrc: "assets/images/stroke.jpg",
                              content:
                                  "A stroke is a medical emergency that occurs when there is a disruption of blood flow to the brain, leading to a lack of oxygen and nutrients reaching brain cells. This interruption can be caused by either a blockage of blood flow (ischemic stroke) or the rupture of a blood vessel (hemorrhagic stroke).\nTypes of Strokes:\nIschemic Stroke: This type accounts for about 80% of all strokes. It occurs when a blood clot or plaque blocks a blood vessel supplying the brain.Hemorrhagic Stroke: This type results from a weakened blood vessel that ruptures and bleeds into the brain.Symptoms of Stroke (Remember the Acronym FAST):\nFace drooping: One side of the face may droop or become numb.\nArm weakness: One arm may be weak or numb and may drift downward when raised.\nSpeech difficulty: Speech may be slurred or difficult to understand.\nTime to call emergency services: If any of these symptoms are observed, it's crucial to seek immediate medicalattention.\nRisk Factors for Stroke:\nHigh blood pressure: This is the most significant risk factor for stroke.\nSmoking\nHighcholesterol\nDiabetes\nObesity\nPhysical inactivity\nFamily history of stroke\nDiagnosis and Treatment:\nDiagnosis often involves a physical examination, neurological tests, imaging scans like CT or MRI, and blood tests to determine the type and cause of the stroke.Treatment may involve medications to dissolve clots (in the case of ischemic stroke), surgery to repair bleeding blood vessels, or procedures to remove clots. Rehabilitation and recovery after a stroke may involve physical therapy, speech therapy, and other forms of rehabilitation.Prevention:\nLifestyle changes such as quitting smoking, regular exercise, maintaining a healthy diet, and managing conditions like high blood pressure, diabetes, and high cholesterol can significantly reduce the risk of stroke.Aftereffects:\nThe impact of a stroke can vary widely, ranging from minor effects to severe disabilities. This includes paralysis, speech and languagedifficulties, memory loss, and emotional changes.Time Sensitivity:\nSeeking immediate medical attention during a stroke is critical. The phrase Time is Brain reflects the urgency in seeking medical care to minimize brain damage and improve outcomes.Early recognition of stroke symptoms and prompt medical intervention are vital in reducing the potential long-term effects and improving the chances of recovery.",
                              siteUrl:
                                  "https://vitals.sutterhealth.org/stroke-and-heart-attack-rapid-response-timing-is-everything/")));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListOfDisease extends StatelessWidget {
  ListOfDisease(
      {super.key,
      required this.size,
      required this.img,
      required this.text,
      required this.onTap});

  final Size size;
  final String img;
  final String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: size.height / 2 - 200,
              width: size.width,
              child: Image.asset(
                img,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
