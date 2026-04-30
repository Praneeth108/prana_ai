import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prana_ai/pages/Home/home.dart';

class Fainting extends StatelessWidget {
  const Fainting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAINTING',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A7A5E),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const FaintingEmergencyPage(),
    );
  }
}

// ─────────────────────────────────────────────
// COLOR PALETTE (matches PRANA AID theme)
// ─────────────────────────────────────────────
class AppColors {
  static const primary = Color(0xFF1A7A5E); // Deep teal-green
  static const primaryLight = Color(0xFF2EA87E);
  static const secondary = Color(0xFF1565C0); // Deep blue
  static const secondaryLight = Color(0xFF1E88E5);
  static const riskMedium = Color(0xFFF57C00); // Orange – medium risk
  static const riskHigh = Color(0xFFD32F2F); // Red – high risk
  static const riskLow = Color(0xFF388E3C); // Green – low risk
  static const ayurvedic = Color(0xFF558B2F); // Earthy green – Ayurvedic
  static const background = Color(0xFFF0F7F4);
  static const cardBg = Colors.white;
  static const textPrimary = Color(0xFF1A2B22);
  static const textSecondary = Color(0xFF546E5E);
  static const divider = Color(0xFFCBE5D8);
  static const critical = Color(0xFFB71C1C);
  static const warningBg = Color(0xFFFFF8E1);
  static const successBg = Color(0xFFE8F5E9);
  static const doColor = Color(0xFF1B5E20);
  static const dontColor = Color(0xFFC62828);
}

// ─────────────────────────────────────────────
// MAIN PAGE
// ─────────────────────────────────────────────
class FaintingEmergencyPage extends StatefulWidget {
  const FaintingEmergencyPage({super.key});

  @override
  State<FaintingEmergencyPage> createState() => _FaintingEmergencyPageState();
}

class _FaintingEmergencyPageState extends State<FaintingEmergencyPage>
    with TickerProviderStateMixin {
  late AnimationController _headerPulseController;
  late Animation<double> _headerPulse;
  int _activeStep = 0;
  final Map<int, bool> _completedSteps = {};

  @override
  void initState() {
    super.initState();
    _headerPulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _headerPulse = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _headerPulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _headerPulseController.dispose();
    super.dispose();
  }

  void _toggleStep(int index) {
    setState(() {
      _completedSteps[index] = !(_completedSteps[index] ?? false);
      if (_completedSteps[index]! && index == _activeStep) {
        _activeStep = index + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildRiskBanner(),
                _buildEmergencySummaryCard(),
                _buildStepByStepSection(),
                _buildDosDontsSection(),
                _buildAyurvedicSection(),
                _buildSeekHelpSection(),
                _buildEmergencyButtons(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── App Bar ──────────────────────────────────
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.white),
          onPressed: () => _showEmergencyCall(context),
        ),
        IconButton(
          icon: const Icon(Icons.share_rounded, color: Colors.white),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 56, bottom: 14),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.airline_seat_flat_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fainting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'Syncope / Loss of Consciousness',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D5C45), Color(0xFF1A7A5E), Color(0xFF1565C0)],
            ),
          ),
        ),
      ),
    );
  }

  // ── Risk Banner ──────────────────────────────
  Widget _buildRiskBanner() {
    return AnimatedBuilder(
      animation: _headerPulse,
      builder: (context, child) =>
          Transform.scale(scale: _headerPulse.value, child: child),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF57C00), Color(0xFFFF8F00)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.riskMedium.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MEDIUM RISK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'Follow instructions carefully. Seek medical help if symptoms persist.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'SYNCOPE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Emergency Summary Card ────────────────────
  Widget _buildEmergencySummaryCard() {
    return _SectionCard(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.summarize_outlined,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'Emergency Summary',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.riskMedium.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.riskMedium.withOpacity(0.4),
                  ),
                ),
                child: const Text(
                  'MEDIUM RISK',
                  style: TextStyle(
                    color: AppColors.riskMedium,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.divider, height: 20),
          _summaryRow(Icons.category_outlined, 'Type', 'Fainting / Syncope'),
          _summaryRow(
            Icons.accessibility_new_rounded,
            'Status',
            'Conscious / Unconscious',
          ),
          _summaryRow(
            Icons.access_time_rounded,
            'Response Time',
            'Act within 2 minutes',
          ),
          _summaryRow(
            Icons.medical_services_outlined,
            'Treatment',
            'Modern First Aid Primary',
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.warningBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFFFCC02).withOpacity(0.6),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFFF57C00),
                  size: 16,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Fainting can indicate serious conditions. Always seek medical evaluation after recovery.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5D4037),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Step-by-Step Section ──────────────────────
  Widget _buildStepByStepSection() {
    final steps = [
      _FirstAidStep(
        stepNum: 1,
        title: 'Ensure Scene Safety',
        subtitle: 'CRITICAL',
        subtitleColor: AppColors.riskHigh,
        description:
            'Check the area is safe for you and the person before approaching. Remove any hazards nearby.',
        icon: Icons.shield_outlined,
        iconColor: AppColors.riskHigh,
        timerSeconds: 10,
      ),
      _FirstAidStep(
        stepNum: 2,
        title: 'Check Responsiveness',
        subtitle: 'CRITICAL',
        subtitleColor: AppColors.riskHigh,
        description:
            'Gently tap the person and ask "Are you okay?" in a firm voice. Look for any movement or response.',
        icon: Icons.touch_app_outlined,
        iconColor: AppColors.riskHigh,
        timerSeconds: 15,
      ),
      _FirstAidStep(
        stepNum: 3,
        title: 'Call Emergency Services',
        subtitle: 'CRITICAL',
        subtitleColor: AppColors.riskHigh,
        description:
            'If unresponsive, call 1990 or local emergency immediately. Tell them the location and condition.',
        icon: Icons.call_rounded,
        iconColor: AppColors.riskHigh,
        timerSeconds: 30,
        actionLabel: 'Call 1990',
        onAction: () => _showEmergencyCall(context),
      ),
      _FirstAidStep(
        stepNum: 4,
        title: 'Position the Person',
        subtitle: 'HIGH',
        subtitleColor: AppColors.riskMedium,
        description:
            'Lay the person flat on their back. Elevate their legs 8–12 inches above heart level to improve blood flow to the brain.',
        icon: Icons.airline_seat_flat_rounded,
        iconColor: AppColors.riskMedium,
        timerSeconds: 20,
      ),
      _FirstAidStep(
        stepNum: 5,
        title: 'Loosen Tight Clothing',
        subtitle: 'MEDIUM',
        subtitleColor: AppColors.secondary,
        description:
            'Loosen any tight collars, ties, or belts. Ensure the airway is clear and the person can breathe easily.',
        icon: Icons.dry_cleaning_outlined,
        iconColor: AppColors.secondary,
        timerSeconds: null,
      ),
      _FirstAidStep(
        stepNum: 6,
        title: 'Check for Breathing',
        subtitle: 'CRITICAL',
        subtitleColor: AppColors.riskHigh,
        description:
            'Look for chest rise, listen for breath sounds, and feel for airflow. If not breathing, begin CPR immediately.',
        icon: Icons.air_rounded,
        iconColor: AppColors.riskHigh,
        timerSeconds: 10,
      ),
      _FirstAidStep(
        stepNum: 7,
        title: 'Keep Person Comfortable',
        subtitle: 'ONGOING',
        subtitleColor: AppColors.primary,
        description:
            'Reassure the person, keep them warm and in a comfortable position. Stay with them until help arrives.',
        icon: Icons.favorite_border_rounded,
        iconColor: AppColors.primary,
        timerSeconds: null,
      ),
    ];

    return _SectionCard(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.format_list_numbered_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step-by-Step Instructions',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Follow in order for best results',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...steps.asMap().entries.map(
            (e) => _StepCard(
              step: e.value,
              index: e.key,
              isActive: _activeStep == e.key,
              isCompleted: _completedSteps[e.key] ?? false,
              onToggle: () => _toggleStep(e.key),
            ),
          ),
        ],
      ),
    );
  }

  // ── Dos & Don'ts ─────────────────────────────
  Widget _buildDosDontsSection() {
    final dos = [
      'Stay calm and reassure the victim',
      'Elevate legs above heart level',
      'Keep the person warm and comfortable',
      'Monitor vital signs continuously',
      'Document what happened for medical staff',
      'Check if person has a medical alert bracelet',
    ];

    final donts = [
      "Don't move the person if spinal injury suspected",
      "Don't give anything to eat or drink",
      "Don't leave the person alone",
      "Don't apply strong smells (like ammonia) near face",
      "Don't splash water on the face forcefully",
      "Don't hold victim upright while fainting",
    ];

    return _SectionCard(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.rule_rounded, color: AppColors.primary, size: 20),
              SizedBox(width: 8),
              Text(
                'DO & DON\'T',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.divider, height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _DosDontsColumn(
                  title: '✓  DO',

                  titleColor: AppColors.doColor,
                  bgColor: AppColors.successBg,
                  borderColor: const Color(0xFFA5D6A7),
                  items: dos,
                  iconColor: AppColors.doColor,
                  icon: Icons.check_circle_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DosDontsColumn(
                  title: '✕  DON\'T',
                  titleColor: AppColors.dontColor,
                  bgColor: const Color(0xFFFFEBEE),
                  borderColor: const Color(0xFFEF9A9A),
                  items: donts,
                  iconColor: AppColors.dontColor,
                  icon: Icons.cancel_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Ayurvedic Support Section ─────────────────
  Widget _buildAyurvedicSection() {
    return _SectionCard(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      borderColor: AppColors.ayurvedic.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.ayurvedic.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.spa_rounded,
                  color: AppColors.ayurvedic,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ayurvedic First-Aid Support',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Supplementary support only · Modern medicine first',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.ayurvedic.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.ayurvedic.withOpacity(0.4),
                  ),
                ),
                child: const Text(
                  'AVAILABLE',
                  style: TextStyle(
                    color: AppColors.ayurvedic,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFFCC80)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFF57C00),
                  size: 16,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'These are supplementary remedies only. Always perform modern first aid first. Consult a doctor for persistent fainting.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF5D4037),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _AyurvedicRemedyCard(
            name: 'Tulsi (Holy Basil)',
            scientificName: 'Ocimum tenuiflorum',
            purpose: 'Stimulant & Stress Relief',
            description:
                'Tulsi leaves help revive consciousness and calm the nervous system. Mild stimulating properties aid in recovery.',
            properties: ['Stimulant', 'Adaptogen', 'Calming'],
            preparation:
                'Crush 4–5 fresh Tulsi leaves. Gently place under the person\'s nose (do not force). Brew as tea post-recovery.',
            frequency: 'Once during recovery; tea 2x daily',
            caution: 'Do not administer orally to unconscious person.',
            iconEmoji: '🌿',
          ),
          const SizedBox(height: 10),
          _AyurvedicRemedyCard(
            name: 'Brahmi',
            scientificName: 'Bacopa monnieri',
            purpose: 'Brain Tonic & Nerve Calming',
            description:
                'Brahmi supports brain circulation and helps stabilize the nervous system after a fainting episode.',
            properties: ['Nervine', 'Neuroprotective', 'Calming'],
            preparation:
                'Use Brahmi oil for gentle temple massage post-recovery. Brahmi powder in warm water as a calming drink.',
            frequency: 'Post-recovery massage; drink once daily',
            caution: 'Consult doctor before use in pregnant women or children.',
            iconEmoji: '🍃',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.successBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFA5D6A7)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety Guidelines',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: AppColors.doColor,
                  ),
                ),
                SizedBox(height: 6),
                _BulletText(
                  text: 'These remedies are supplementary support only',
                ),
                _BulletText(text: 'Always perform modern first aid first'),
                _BulletText(text: 'Test for allergies before full application'),
                _BulletText(
                  text: 'Discontinue if irritation or worsening occurs',
                ),
                _BulletText(text: 'Seek medical care if symptoms persist'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined, size: 16),
              label: const Text('Identify Ayurvedic Plants with AI Camera'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.ayurvedic,
                side: BorderSide(color: AppColors.ayurvedic.withOpacity(0.6)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Seek Help Section ─────────────────────────
  Widget _buildSeekHelpSection() {
    final conditions = [
      'Fainting doesn\'t stop after 1 minute of recovery',
      'Person becomes confused or disoriented',
      'Symptoms worsen or new symptoms appear',
      'Signs of infection develop (chest pain, palpitations)',
      'Repeated fainting episodes',
      'Person is pregnant or elderly',
    ];

    return _SectionCard(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      borderColor: AppColors.secondary.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.local_hospital_rounded,
                  color: AppColors.secondary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Seek Immediate Medical Help If:',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.divider, height: 20),
          ...conditions.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.arrow_right_rounded,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      c,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_on_rounded, size: 16),
              label: const Text('Find Nearby Hospitals'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Emergency Buttons ─────────────────────────
  Widget _buildEmergencyButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: _EmergencyButton(
              label: 'Call 1990',
              icon: Icons.call_rounded,
              color: AppColors.riskHigh,
              onPressed: () => _showEmergencyCall(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _EmergencyButton(
              label: 'Find Hospital',
              icon: Icons.local_hospital_rounded,
              color: AppColors.secondary,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyCall(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.phone_in_talk_rounded,
              color: AppColors.riskHigh,
              size: 48,
            ),
            const SizedBox(height: 12),
            const Text(
              'Emergency Services',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            _HotlineButton(
              label: 'Emergency Services',
              number: '1990',
              priority: 'CRITICAL',
              color: AppColors.riskHigh,
            ),
            const SizedBox(height: 8),
            _HotlineButton(
              label: 'Ambulance',
              number: '1990',
              priority: 'HIGH',
              color: AppColors.riskMedium,
            ),
            const SizedBox(height: 8),
            _HotlineButton(
              label: 'Police',
              number: '119',
              priority: 'HIGH',
              color: AppColors.secondary,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// STEP CARD WIDGET
// ─────────────────────────────────────────────
class _StepCard extends StatefulWidget {
  final _FirstAidStep step;
  final int index;
  final bool isActive;
  final bool isCompleted;
  final VoidCallback onToggle;

  const _StepCard({
    required this.step,
    required this.index,
    required this.isActive,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  int _secondsLeft = 0;
  Timer? _timer;
  bool _timerRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (widget.step.timerSeconds == null) return;
    setState(() {
      _secondsLeft = widget.step.timerSeconds!;
      _timerRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
        setState(() => _timerRunning = false);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool dimmed =
        !widget.isActive && !widget.isCompleted && widget.index != 0;

    return AnimatedOpacity(
      opacity: dimmed ? 0.55 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: widget.isCompleted
              ? AppColors.successBg
              : (widget.isActive
                    ? Colors.white
                    : Colors.white.withOpacity(0.85)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isCompleted
                ? const Color(0xFFA5D6A7)
                : (widget.isActive
                      ? AppColors.primary.withOpacity(0.4)
                      : AppColors.divider),
            width: widget.isActive ? 1.5 : 1,
          ),
          boxShadow: widget.isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              leading: GestureDetector(
                onTap: widget.onToggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.isCompleted
                        ? AppColors.doColor
                        : widget.step.iconColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.isCompleted
                          ? AppColors.doColor
                          : widget.step.iconColor.withOpacity(0.4),
                    ),
                  ),
                  child: widget.isCompleted
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 18,
                        )
                      : Center(
                          child: Text(
                            '${widget.step.stepNum}',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: widget.step.iconColor,
                            ),
                          ),
                        ),
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.step.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: widget.isCompleted
                            ? AppColors.doColor
                            : AppColors.textPrimary,
                        decoration: widget.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: widget.step.subtitleColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.step.subtitle,
                      style: TextStyle(
                        color: widget.step.subtitleColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.step.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            if (widget.step.timerSeconds != null ||
                widget.step.actionLabel != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Row(
                  children: [
                    if (widget.step.timerSeconds != null) ...[
                      _TimerChip(
                        seconds: _timerRunning
                            ? _secondsLeft
                            : widget.step.timerSeconds!,
                        isRunning: _timerRunning,
                        onTap: _startTimer,
                      ),
                    ],
                    const Spacer(),
                    if (widget.step.actionLabel != null)
                      GestureDetector(
                        onTap: widget.step.onAction,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.riskHigh,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.call_rounded,
                                color: Colors.white,
                                size: 13,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.step.actionLabel!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TIMER CHIP
// ─────────────────────────────────────────────
class _TimerChip extends StatelessWidget {
  final int seconds;
  final bool isRunning;
  final VoidCallback onTap;

  const _TimerChip({
    required this.seconds,
    required this.isRunning,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isRunning
              ? AppColors.primary.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isRunning
                ? AppColors.primary.withOpacity(0.4)
                : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isRunning
                  ? Icons.timer_rounded
                  : Icons.play_circle_outline_rounded,
              size: 14,
              color: isRunning ? AppColors.primary : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              isRunning ? '${seconds}s' : '${seconds}s',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isRunning ? AppColors.primary : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// AYURVEDIC REMEDY CARD
// ─────────────────────────────────────────────
class _AyurvedicRemedyCard extends StatefulWidget {
  final String name;
  final String scientificName;
  final String purpose;
  final String description;
  final List<String> properties;
  final String preparation;
  final String frequency;
  final String caution;
  final String iconEmoji;

  const _AyurvedicRemedyCard({
    required this.name,
    required this.scientificName,
    required this.purpose,
    required this.description,
    required this.properties,
    required this.preparation,
    required this.frequency,
    required this.caution,
    required this.iconEmoji,
  });

  @override
  State<_AyurvedicRemedyCard> createState() => _AyurvedicRemedyCardState();
}

class _AyurvedicRemedyCardState extends State<_AyurvedicRemedyCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.ayurvedic.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.ayurvedic.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.ayurvedic.withOpacity(0.3)),
              ),
              child: Center(
                child: Text(
                  widget.iconEmoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            title: Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.scientificName,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.ayurvedic.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'First Aid',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.ayurvedic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.ayurvedic,
                ),
              ),
              onPressed: () => setState(() => _expanded = !_expanded),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: AppColors.divider, height: 1),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: widget.properties
                        .map(
                          (p) => Chip(
                            label: Text(
                              p,
                              style: const TextStyle(fontSize: 10),
                            ),
                            backgroundColor: AppColors.ayurvedic.withOpacity(
                              0.08,
                            ),
                            side: BorderSide(
                              color: AppColors.ayurvedic.withOpacity(0.3),
                            ),
                            visualDensity: VisualDensity.compact,
                            labelPadding: EdgeInsets.zero,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.science_outlined,
                    label: 'Preparation',
                    value: widget.preparation,
                  ),
                  const SizedBox(height: 6),
                  _InfoRow(
                    icon: Icons.access_time_rounded,
                    label: 'Frequency',
                    value: widget.frequency,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFFCC80)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFF57C00),
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.caution,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF5D4037),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SMALL HELPER WIDGETS
// ─────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final Color? borderColor;

  const _SectionCard({required this.child, this.margin, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DosDontsColumn extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color bgColor;
  final Color borderColor;
  final List<String> items;
  final Color iconColor;
  final IconData icon;

  const _DosDontsColumn({
    required this.title,
    required this.titleColor,
    required this.bgColor,
    required this.borderColor,
    required this.items,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 13, color: iconColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 11, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _EmergencyButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 3,
        shadowColor: color.withOpacity(0.4),
      ),
    );
  }
}

class _HotlineButton extends StatelessWidget {
  final String label;
  final String number;
  final String priority;
  final Color color;

  const _HotlineButton({
    required this.label,
    required this.number,
    required this.priority,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.phone_rounded, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Tap to call $number',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              priority,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;
  const _BulletText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.doColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: AppColors.ayurvedic),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────
class _FirstAidStep {
  final int stepNum;
  final String title;
  final String subtitle;
  final Color subtitleColor;
  final String description;
  final IconData icon;
  final Color iconColor;
  final int? timerSeconds;
  final String? actionLabel;
  final VoidCallback? onAction;

  _FirstAidStep({
    required this.stepNum,
    required this.title,
    required this.subtitle,
    required this.subtitleColor,
    required this.description,
    required this.icon,
    required this.iconColor,
    this.timerSeconds,
    this.actionLabel,
    this.onAction,
  });
}
