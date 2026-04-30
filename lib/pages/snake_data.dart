import 'snake_info.dart';

final Map<String, SnakeInfo> snakeDatabase = {
  "Cobra": SnakeInfo(
    name: "Cobra (Naja naja)",
    symptoms: [
      "Severe pain and swelling",
      "Drooping eyelids (ptosis)",
      "Breathing difficulty",
      "Numbness or paralysis",
      "Vomiting",
    ],
    dos: [
      "Keep patient calm and still",
      "Immobilize bitten limb",
      "Go to hospital immediately",
      "Remove rings/bracelets",
    ],
    donts: [
      "Do NOT suck venom",
      "Do NOT cut wound",
      "Do NOT apply ice or tourniquet",
      "Do NOT panic or allow movement",
    ],
  ),

  "Russell Viper": SnakeInfo(
    name: "Russell’s Viper (Thith Polaga)",
    symptoms: [
      "Severe swelling and pain",
      "Bleeding gums / internal bleeding",
      "Low blood pressure",
      "Kidney pain or failure signs",
      "Blistering",
    ],
    dos: [
      "Immobilize limb",
      "Urgent hospital transport",
      "Keep patient lying down",
      "Monitor breathing",
    ],
    donts: [
      "No tourniquet",
      "No alcohol or coffee",
      "No wound cutting or aggressive washing",
    ],
  ),

  "Common indian Krait": SnakeInfo(
    name: "Common Indian Krait (Thel Karawalaya)",
    symptoms: [
      "Minimal pain initially",
      "Muscle paralysis (especially at night)",
      "Breathing failure",
      "Abdominal pain",
      "Drooping eyelids",
    ],
    dos: [
      "Immediate hospital transfer",
      "Keep patient warm and still",
      "Monitor breathing",
    ],
    donts: [
      "Do NOT wait for symptoms",
      "Do NOT move patient unnecessarily",
      "Do NOT apply traditional remedies",
    ],
  ),

  "Banded Racer": SnakeInfo(
    name: "Banded Racer (Wal Garadiya)",
    symptoms: [
      "Usually non-venomous",
      "Mild pain or scratches",
      "No systemic symptoms",
    ],
    dos: [
      "Clean wound with water",
      "Apply antiseptic",
      "Observe for infection",
    ],
    donts: ["No unnecessary panic", "No harmful chemicals on wound"],
  ),

  "Barnes's cat snake": SnakeInfo(
    name: "Barnes’s Cat Snake (Paduru Mapila)",
    symptoms: [
      "Mild local pain",
      "Slight swelling",
      "No serious systemic effects",
    ],
    dos: ["Wash wound", "Basic dressing", "Observe patient"],
    donts: ["Do not assume venomous bite", "Do not apply tourniquet"],
  ),

  "Beddomes cat snake": SnakeInfo(
    name: "Beddome’s Cat Snake (Kaha Mapila)",
    symptoms: [
      "Mild bite pain",
      "Small puncture marks",
      "No dangerous venom effects",
    ],
    dos: ["Clean wound properly", "Keep area dry and clean"],
    donts: ["No panic treatment needed", "No cutting or sucking"],
  ),

  "Brown vine snake": SnakeInfo(
    name: "Brown Vine Snake (Henakadaya)",
    symptoms: [
      "Very mild bite",
      "Local irritation only",
      "No systemic symptoms",
    ],
    dos: ["Wash with soap and water", "Monitor for infection"],
    donts: ["No hospital emergency unless symptoms worsen"],
  ),

  "Common cat snake": SnakeInfo(
    name: "Common Cat Snake (Ran Mapila)",
    symptoms: ["Mild pain or swelling", "No neurotoxic effects"],
    dos: ["Clean wound", "Basic first aid dressing"],
    donts: ["Do not treat as venom emergency unless unsure"],
  ),

  "Green vine snake": SnakeInfo(
    name: "Green Vine Snake (Ahatulla)",
    symptoms: ["Mild pain or no pain", "Small bleeding at bite site"],
    dos: ["Clean wound", "Observe for infection"],
    donts: ["No emergency panic needed"],
  ),

  "Srilankan krait": SnakeInfo(
    name: "Sri Lankan Krait (Mudu / Dunu Karawala)",
    symptoms: [
      "Delayed paralysis",
      "Respiratory failure",
      "Muscle weakness",
      "No early pain",
    ],
    dos: [
      "Emergency hospital transfer",
      "Keep airway monitored",
      "Keep patient still",
    ],
    donts: ["Do NOT sleep or delay treatment", "Do NOT apply home remedies"],
  ),

  "Srilanka cat snake": SnakeInfo(
    name: "Sri Lankan Cat Snake (Nidi Mapila)",
    symptoms: ["Mild local reaction", "No systemic venom effects"],
    dos: ["Wash wound", "Basic dressing"],
    donts: ["No aggressive treatment needed"],
  ),

  "Forsten's cat snake": SnakeInfo(
    name: "Forsten’s Cat Snake (Le / Naga Mapila)",
    symptoms: ["Mild bite reaction", "No dangerous systemic symptoms"],
    dos: ["Clean wound", "Monitor"],
    donts: ["No panic escalation"],
  ),

  "Wart snake / Cloth snake": SnakeInfo(
    name: "Wart / Cloth Snake (Diya Naya)",
    symptoms: ["Usually non-venomous", "Local irritation only"],
    dos: ["Clean wound thoroughly", "Basic antiseptic care"],
    donts: ["No toxic emergency assumptions unless symptoms appear"],
  ),

  "Red bellied coral snake": SnakeInfo(
    name: "Red-bellied Coral Snake",
    symptoms: [
      "Delayed neurotoxic effects",
      "Muscle weakness",
      "Breathing difficulty",
      "Numbness",
    ],
    dos: [
      "Immediate hospital emergency",
      "Keep patient immobile",
      "Monitor breathing",
    ],
    donts: ["Do NOT wait for symptoms", "Do NOT apply pressure cuts"],
  ),

  "Saw scaled viper": SnakeInfo(
    name: "Saw-scaled Viper (Wali Polaga)",
    symptoms: [
      "Severe pain and swelling",
      "Internal bleeding",
      "Shock symptoms",
      "Kidney damage risk",
    ],
    dos: [
      "Emergency hospital transfer",
      "Immobilize limb",
      "Keep patient calm",
    ],
    donts: ["No tourniquet", "No cutting or suction"],
  ),

  "Merrem's Hump-nosed Viper": SnakeInfo(
    name: "Merrem’s Hump-nosed Viper (Kuna Katuwa)",
    symptoms: [
      "Severe swelling",
      "Bleeding disorder",
      "Kidney complications",
      "Pain and bruising",
    ],
    dos: ["Immediate hospital care", "Keep limb still", "Monitor bleeding"],
    donts: ["No traditional treatment delays", "No tight bindings"],
  ),
};
