import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/data_class/indicator_data.dart';
import 'package:platform_front/config/enums.dart';

class AllIndicatorData {
  static Map<Indicator, IndicatorData> indicatorMap = {
    Indicator.orgAlign: IndicatorData(
      heading: 'Organizational Alignment',
      impactText: 'A well-structured organization enhances efficiency and reduces bottlenecks.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body':
              "Your organization is operating at a ___ aligned org structure benchmark, placing you above the industry average and demonstrating a well-defined and effective organizational hierarchy. This indicates that roles, responsibilities, and decision-making structures are clearly established, minimizing confusion and enabling efficient execution."
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body':
              "Your organization is operating at a ___ aligned org structure benchmark, positioning you slightly above the market average. This suggests that while your structure is generally well-defined, there may be opportunities to further refine how roles, responsibilities, and reporting lines function."
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body':
              "Your organization is operating at a ___ aligned org structure benchmark, aligning with the market average. While a foundation exists, there are likely inefficiencies in reporting lines, decision-making processes, or team structures that could use attention."
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body':
              "Your organization is operating at a ___ aligned org structure benchmark, which falls below the market average. This suggests that confusion around roles, responsibilities, or reporting structures is creating friction and reducing efficiency. Addressing these issues will provide immediate improvements in operational effectiveness."
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body':
              "Your organization is operating at a ___ aligned org structure benchmark, signaling significant opportunities for improvement. This score suggests a lack of clarity in how decisions are made, how teams interact, or how leadership structures are defined, creating major inefficiencies."
        },
      },
      diffTexts: {
        DiffRange.minimal:
            "Your organization's differentiation score is ___, indicating strong alignment across leadership and staff regarding organizational structure. This suggests that roles and responsibilities are well understood, minimizing inefficiencies and ensuring smooth execution.",
        DiffRange.moderate:
            "Your organization's differentiation score is ___, indicating minor misalignment in how leadership and staff perceive organizational structure. While roles and reporting lines are generally well-defined, there may be small inconsistencies that create friction. Resolving these will strengthen operational clarity and efficiency.",
        DiffRange.high:
            "Your organization's differentiation score is ___, signaling moderate misalignment in role clarity and reporting structures. This could result in inconsistent decision-making, inefficient workflows, or uncertainty regarding authority and responsibilities. These are critical gaps that need to be addressed to improve structural efficiency.",
        DiffRange.extreme:
            "Your organization's differentiation score is ___, indicating significant misalignment in organizational structure. This suggests that leadership, middle management, and staff may have conflicting understandings of roles and decision-making authority, leading to operational inefficiencies and frustration. Major misalignment in structure can lead to delays, inefficiencies, and a lack of accountability if not corrected immediately.",
      },
    ),
    Indicator.growthAlign: IndicatorData(
      heading: 'Growth Alignment',
      impactText: 'A well-structured organization enhances efficiency and reduces bottlenecks.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body':
              "Your organization is operating at a ___ growth alignment benchmark, placing you above the industry average and demonstrating a solid foundation in strategic clarity, budget allocation, and decision-making autonomy. This reflects strong alignment in growth strategies, ensuring teams are working towards the same objectives with minimal friction."
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body':
              "Your organization is operating at a ___ growth alignment benchmark, positioning you slightly above the market average. This suggests that while strategic alignment is strong, there are still opportunities to refine decision-making structures and ensure all teams fully understand growth priorities."
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body':
              "Your organization is operating at a ___ growth alignment benchmark, aligning with the market average. While a solid foundation exists, misalignment in priorities, budgeting, or decision-making authority may be creating inefficiencies. Addressing these areas can drive meaningful improvements in execution."
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body':
              "Your organization is operating at a ___ growth alignment benchmark, which falls below the market average. This indicates that strategic misalignment may be causing inefficiencies, resource misallocation, or conflicting priorities. Addressing these gaps will strengthen the organization's ability to execute growth initiatives effectively."
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body':
              "Your organization is operating at a ___ growth alignment benchmark, signaling significant opportunities for improvement. This suggests that teams may not be aligned with leadership's vision for growth, leading to wasted resources and misdirected efforts. Immediate action is required to establish clarity and cohesion."
        },
      },
      diffTexts: {
        DiffRange.minimal:
            "Your organization's differentiation score is ___, indicating high alignment across leadership and staff regarding growth strategies. This means teams clearly understand objectives, budgets, and decision-making structures, creating a strong foundation for execution.",
        DiffRange.moderate:
            "Your organization's differentiation score is ___, indicating minor misalignment across leadership and staff regarding growth objectives. While the overall strategic direction is clear, there may be small inconsistencies in how priorities, budgets, or responsibilities are interpreted. Addressing these gaps early will prevent them from evolving into major roadblocks.",
        DiffRange.high:
            "Your organization's differentiation score is ___, signaling moderate misalignment in growth alignment. Different teams or leadership levels may have conflicting views on strategic priorities, budgets, or execution strategies. If left unaddressed, this could lead to inefficiencies and stalled initiatives. This represents a critical gas in perception or execution that requires immediate attention.",
        DiffRange.extreme:
            "Your organization's differentiation score is ___, indicating significant misalignment in growth strategies. This level of disparity suggests that different teams or leadership groups are operating under conflicting priorities, leading to inconsistent execution and wasted resources. This represents major roadblocks that could hinder strategic execution and must be resolved before pursuing new growth initiatives.",
      },
    ),
    Indicator.collabKPI: IndicatorData(
      heading: 'Collaborative KPIs',
      impactText: 'Well-integrated KPIs lead to better decision-making and streamlined execution.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body':
              "Your organization is operating at a ___ collaborative KPIs benchmark, placing you above the industry average. This indicates that performance metrics are well-integrated across teams, fostering clarity, accountability, and alignment. Employees understand how their efforts contribute to broader goals, and cross-functional collaboration is strong."
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body':
              "Your organization is operating at a ___ collaborative KPIs benchmark, positioning you slightly above the market average. This suggests that KPI alignment is solid, but some teams may still interpret or apply them inconsistently, leading to minor inefficiencies."
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body':
              "Your organization is operating at a ___ collaborative KPIs benchmark, aligning with the market average. While KPIs are in place, inconsistencies in application, measurement, or accountability may be limiting their impact. This presents a strong opportunity for targeted improvements."
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body':
              "Your organization is operating at a ___ collaborative KPIs benchmark, which falls below the market average. This suggests that KPIs may not be well-integrated across teams, leading to inefficiencies, misaligned priorities, or a lack of ownership over key results."
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body':
              "Your organization is operating at a ___ collaborative KPIs benchmark, signaling significant opportunities for improvement. This suggests that KPIs may be unclear, inconsistently applied, or ineffective in driving alignment across teams."
        },
      },
      diffTexts: {
        DiffRange.minimal:
            "Your organization's differentiation score is ___, indicating strong alignment in how KPIs are defined and used. This means leadership and teams are working from the same set of performance expectations, ensuring that accountability and strategic priorities remain consistent across functions. However, keep in mind that even well-aligned organizations can refine KPI execution to maximize engagement and effectiveness.",
        DiffRange.moderate:
            "Your organization's differentiation score is ___, indicating minor misalignment in KPI implementation. While the overall framework is solid, some teams may interpret performance metrics differently, leading to slight inefficiencies in execution. Addressing these inconsistencies will improve strategic alignment and team accountability.",
        DiffRange.high:
            "Your organization's differentiation score is ___, signaling moderate misalignment in KPI clarity and usage. This suggests that some teams may struggle to see how KPIs connect to broader objectives, leading to inefficiencies in performance tracking and decision-making. This likely represents critical gaps that need immediate attention to improve alignment, ownership, and performance measurement.",
        DiffRange.extreme:
            "Your organization's differentiation score is ___, indicating significant misalignment in KPI structures. This level of disparity suggests that different teams or leadership groups may be using conflicting performance metrics, leading to inconsistent decision-making, poor accountability, and misaligned priorities. Major KPI misalignment can create siloed efforts, erode trust, and hinder strategic execution if not corrected immediately",
      },
    ),
    Indicator.engagedCommunity: IndicatorData(
      heading: 'Engaged Community',
      impactText: 'An engaged workforce drives productivity, innovation, and overall organizational health.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body':
              "Your organization is operating at a ___ engaged community benchmark, placing you above the industry average. This indicates a workplace culture where employees feel valued, connected, and motivated. A high level of engagement fosters collaboration, innovation, and long-term retention, positioning your organization for sustained success."
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body':
              "Your organization is operating at a ___ engaged community benchmark, positioning you slightly above the market average. This suggests that employees generally feel connected and engaged, but there may still be opportunities to strengthen team cohesion and cross-functional collaboration"
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body':
              "Your organization is operating at a ___ engaged community benchmark, aligning with the market average. This suggests a generally positive work environment but with room for more meaningful engagement and stronger collaboration across teams."
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body':
              "Your organization is operating at a ___ engaged community benchmark, which falls below the market average. This indicates that employee engagement is inconsistent, potentially leading to lower morale, higher turnover, and reduced productivity.",
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body':
              "Your organization is operating at a ___ engaged community benchmark, signaling significant disengagement. This score suggests that employees may feel undervalued, disconnected from leadership, or unclear about their role in the company's success. Immediate action is needed to address these concerns before they impact retention and performance."
        },
      },
      diffTexts: {
        DiffRange.minimal:
            "Your organization's differentiation score is ___, indicating strong alignment across leadership and staff regarding community engagement. This suggests that employees feel valued, connected, and actively participate in the company culture.",
        DiffRange.moderate:
            "Your organization's differentiation score is ___, indicating minor misalignment in employee engagement. While overall engagement is strong, there may be inconsistencies in how different teams or leadership levels perceive the company culture.",
        DiffRange.high:
            "Your organization's differentiation score is ___, signaling moderate misalignment in engagement efforts. Some employees may feel connected, while others experience disengagement due to unclear communication, lack of inclusion, or inconsistent leadership accessibility.",
        DiffRange.extreme:
            "Your organization's differentiation score is ___, indicating significant misalignment in engagement strategies. This suggests that employees and leadership may have vastly different perceptions of company culture, leading to widespread disengagement.",
      },
    ),
    Indicator.crossFuncComms: IndicatorData(
      heading: 'Cross-Functional Communication',
      impactText: 'Effective communication ensures alignment, reduces inefficiencies, and enhances decision-making.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body':
              "Your organization is operating at a ___ cross-functional communication benchmark, placing you above the industry average. This indicates that teams collaborate effectively, information flows seamlessly across departments, and decision-making is well-supported by clear, timely communication. Strong cross-functional communication enhances agility, problem-solving, and alignment.",
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body':
              "Your organization is operating at a ___ cross-functional communication benchmark, positioning you slightly above the market average. This suggests that while communication is generally effective, some teams may still experience occasional misalignment or delays in information sharing.",
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body':
              "Your organization is operating at a ___ cross-functional communication benchmark, aligning with the market average. While a foundation exists, inconsistencies in information flow, unclear messaging, or siloed communication may be creating inefficiencies.",
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body':
              "Your organization is operating at a ___ cross-functional communication benchmark, which falls below the market average. This suggests that breakdowns in communication may be leading to misunderstandings, delays, or inefficiencies that hinder operational success.",
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body':
              "Your organization is operating at a ___ cross-functional communication benchmark, signaling significant miscommunication or lack of information flow. This score suggests that departments may be working in silos, key messages may not be reaching the right people, or decision-making may be hindered by lack of clarity. Immediate action is required.",
        },
      },
      diffTexts: {
        DiffRange.minimal:
            "Your organization's differentiation score is ___, indicating strong alignment across leadership and staff regarding communication effectiveness. This suggests that teams are well-connected, information flows efficiently, and collaboration is smooth.",
        DiffRange.moderate:
            "Your organization's differentiation score is ___, indicating minor misalignment in communication practices. While overall communication is effective, some teams or leadership levels may perceive differences in how efficiently information is shared. Addressing these inconsistencies will strengthen transparency, alignment, and decision-making speed.",
        DiffRange.high:
            "Your organization's differentiation score is ___, signaling moderate misalignment in communication structures. Some departments or leadership groups may struggle to receive or interpret critical information in a timely manner, leading to operational delays. This indicates critical gaps that need immediate attention to improve cross-functional collaboration.",
        DiffRange.extreme:
            "Your organization's differentiation score is ___, indicating significant misalignment in communication practices. This suggests that teams and leadership may have vastly different perceptions of how effectively information is shared, leading to inefficiencies, duplicated efforts, or conflicting priorities. Major communication breakdowns can lead to confusion, misaligned goals, and a lack of cohesion if not resolved quickly.",
      },
    ),
    Indicator.crossFuncAcc: IndicatorData(
      heading: 'Cross-Functional Accountability',
      impactText: 'Strong accountability fosters trust and collaboration.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body':
              "Your organization is operating at a ___ cross-functional accountability benchmark, placing you above the industry average. This indicates that teams effectively hold each other accountable, ensuring responsibilities are clear, performance expectations are aligned, and collaboration is strong. Employees trust leadership and each other, fostering a culture of ownership and continuous improvement.",
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body':
              "Your organization is operating at a ___ cross-functional accountability benchmark, positioning you slightly above the market average. This suggests that while accountability is generally well-established, there may still be inconsistencies in execution across teams or leadership levels.",
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body':
              "Your organization is operating at a ___ cross-functional accountability benchmark, aligning with the market average. While teams generally understand expectations, inconsistencies in follow-through, ownership, or leadership accountability may limit performance.",
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body':
              "Your organization is operating at a ___ cross-functional accountability benchmark, which falls below the market average. This suggests that unclear responsibilities, lack of ownership, or inconsistent follow-through may be leading to inefficiencies, duplicated efforts, or conflicts between teams.",
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body':
              "Your organization is operating at a ___ cross-functional accountability benchmark, signaling a significant breakdown in responsibility-sharing and ownership. This may indicate that teams lack clear expectations, performance tracking is weak, or employees don't feel empowered to hold leadership accountable.",
        },
      },
      diffTexts: {
        DiffRange.minimal:
            "Your organization's differentiation score is ___, indicating strong alignment across leadership and staff regarding accountability. This suggests that employees understand their roles, expectations are clear, and ownership of outcomes is well-distributed.",
        DiffRange.moderate:
            "Your organization's differentiation score is ___, indicating minor misalignment in accountability execution. While expectations are generally understood, there may be inconsistencies in how different teams perceive responsibility-sharing, performance measurement, or leadership accountability. Addressing these inconsistencies will strengthen overall execution and collaboration.",
        DiffRange.high:
            "Your organization's differentiation score is ___, signaling moderate misalignment in accountability structures. Some teams or leadership groups may not be consistently holding themselves or others accountable, leading to inefficiencies in execution. This likely indicates critical gaps in ownership, performance expectations, or follow-through that require immediate attention.",
        DiffRange.extreme:
            "Your organization's differentiation score is ___, indicating significant misalignment in accountability. This suggests that different teams or leadership levels may have conflicting expectations regarding ownership, performance measurement, and follow-through, leading to frustration, inefficiencies, and missed opportunities. Major gaps in accountability can lead to team dysfunction, lack of trust, and stalled initiatives if not resolved quickly.",
      },
    ),
    Indicator.alignedTech: IndicatorData(
      heading: 'Aligned Tech Stack',
      impactText: 'A well-integrated tech ecosystem streamlines processes and minimizes friction.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body':
              "Your organization is operating at a ___ aligned tech stack benchmark, placing you above the industry average. This indicates that your technology infrastructure effectively supports operations, streamlines workflows, and enhances collaboration. A well-integrated tech stack allows teams to work efficiently, reducing redundancy and improving data accessibility.",
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body':
              "Your organization is operating at a ___ aligned tech stack benchmark, positioning you slightly above the market average. This suggests that while technology is well-integrated, there may be areas where tools could be better optimized, automated, or streamlined.",
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body':
              "Your organization is operating at a ___ aligned tech stack benchmark, aligning with the market average. While your technology infrastructure supports operations, inconsistencies in adoption, integration challenges, or outdated tools may be limiting performance.",
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body':
              "Your organization is operating at a ___ aligned tech stack benchmark, which falls below the market average. This suggests that disconnected systems, outdated tools, or inconsistent technology adoption may be leading to inefficiencies and workflow friction.",
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body':
              "Your organization is operating at a ___ aligned tech stack benchmark, signaling significant inefficiencies in your technology infrastructure. This score suggests that legacy systems, siloed data, or poor system usability may be severely limiting productivity and collaboration. Immediate action is needed.",
        },
      },
      diffTexts: {
        DiffRange.minimal:
            "Your organization's differentiation score is ___, indicating strong alignment across leadership and staff regarding your tech stack. This suggests that tools are well-integrated, widely adopted, and effectively support workflows.",
        DiffRange.moderate:
            "Your organization's differentiation score is ___, indicating minor misalignment in technology adoption or integration. While the overall infrastructure is effective, some teams may experience inefficiencies due to inconsistent usage or lack of system optimization.",
        DiffRange.high:
            "Your organization's differentiation score is ___, signaling moderate misalignment in technology usage and perception. This suggests that different teams may rely on disparate tools, causing inefficiencies and communication barriers. This differentiation indicates critical integration or adoption gaps that need immediate attention.",
        DiffRange.extreme:
            "Your organization's differentiation score is ___, indicating significant misalignment in technology infrastructure. This suggests that teams and leadership may have conflicting views on which tools are essential, leading to inefficiencies, duplicate efforts, and workflow roadblocks. Major technology misalignment can slow down operations, create siloed data, and hinder collaboration if not resolved quickly.",
      },
    ),
    Indicator.collabProcesses: IndicatorData(
      heading: 'Collaborative Processes',
      impactText: 'Strong collaborative processes improve accountability, reduce redundancies, and enhance agility.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body':
              "Your organization is operating at a ___ collaborative processes benchmark, placing you above the industry average. This indicates that teams work together seamlessly, workflows are well-structured, and collaboration is embedded in the company culture. A high level of process collaboration fosters efficiency, innovation, and stronger decision-making.",
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body':
              "Your organization is operating at a ___ collaborative processes benchmark, positioning you slightly above the market average. This suggests that while teams generally collaborate effectively, there are still opportunities to streamline processes and ensure consistency across departments.",
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body':
              "Your organization is operating at a ___ collaborative processes benchmark, aligning with the market average. This suggests that while a foundation for teamwork exists, inefficiencies in workflows, lack of standardization, or miscommunication may be limiting overall effectiveness.",
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body':
              "Your organization is operating at a ___ collaborative processes benchmark, which falls below the market average. This suggests that teams may be working in silos, experiencing process bottlenecks, or struggling with unclear collaboration structures. Addressing these inefficiencies will lead to stronger teamwork and productivity.",
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body':
              "Your organization is operating at a ___ collaborative processes benchmark, signaling significant inefficiencies in teamwork and workflow execution. This suggests that teams may not have clear collaboration guidelines, work in isolation, or lack visibility into shared goals. Immediate action is needed.",
        },
      },
      diffTexts: {
        DiffRange.minimal:
            "Your organization's differentiation score is ___, indicating strong alignment across leadership and staff regarding collaborative processes. This suggests that employees understand how to work together effectively, minimizing inefficiencies and ensuring streamlined execution.",
        DiffRange.moderate:
            "Your organization's differentiation score is ___, indicating minor misalignment in how leadership and staff perceive collaboration. While collaboration generally works well, there may be inconsistencies in how certain teams experience or execute collaborative processes.",
        DiffRange.high:
            "Your organization's differentiation score is ___, signaling moderate misalignment in collaboration structures. Some teams may struggle with unclear expectations, siloed workflows, or inefficient handoffs, leading to gaps in execution. This could indicate critical gaps in process efficiency, communication, or accountability that need immediate attention.",
        DiffRange.extreme:
            "Your organization's differentiation score is ___, indicating significant misalignment in collaborative processes. This suggests that different teams or leadership levels may have conflicting views on how collaboration should be structured, leading to inefficiencies, duplicated efforts, and process roadblocks. Major collaboration breakdowns can lead to delays, operational friction, and misaligned execution if not resolved quickly.",
      },
    ),
    Indicator.meetingEfficacy: IndicatorData(
      heading: 'Meeting Efficacy',
      impactText: 'Streamlined meetings drive productivity, improve morale, and minimize wasted time.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body': "Your organization is operating at a ___ meeting efficacy benchmark, placing you above the industry average. This indicates that meetings are well-structured, purposeful, and drive productivity rather than waste time. Employees come prepared, discussions stay on track, and outcomes translate into actionable steps.",
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body': "Your organization is operating at a ___ meeting efficacy benchmark, positioning you slightly above the market average. This suggests that meetings are generally productive, but there may be some inefficiencies, such as unclear follow-ups, overlong discussions, or inconsistent engagement.",
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body': "Your organization is operating at a ___ meeting efficacy benchmark, aligning with the market average. This suggests that while meetings serve their purpose, inefficiencies such as unclear agendas, frequent overruns, or lack of follow-through may be reducing their effectiveness.",
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body': "Your organization is operating at a ___ meeting efficacy benchmark, which falls below the market average. This suggests that meetings may be too frequent, lack clear structure, or fail to result in meaningful action, causing wasted time and frustration.",
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body': "Your organization is operating at a ___ meeting efficacy benchmark, signaling significant inefficiencies. This suggests that meetings may be poorly structured, too frequent, lack accountability, or fail to contribute to real business outcomes. Immediate action is required.",
        },
      },
      diffTexts: {
        DiffRange.minimal: "Your organization's differentiation score is ___, indicating strong alignment across leadership and staff regarding meeting effectiveness. This suggests that meetings are viewed as valuable, time-efficient, and actionable across all levels of the organization.",
        DiffRange.moderate: "Your organization's differentiation score is ___, indicating minor misalignment in how meetings are perceived. While meetings generally serve their purpose, some teams may experience more inefficiency or frustration than others.",
        DiffRange.high: "Your organization's differentiation score is ___, signaling moderate misalignment in meeting efficacy. This suggests that different teams or leadership levels may have inconsistent expectations regarding meeting structure, length, or purpose, leading to inefficiencies. This score indicates critical gaps in meeting execution, engagement, or follow-up accountability that require immediate attention.",
        DiffRange.extreme: "Your organization's differentiation score is ___, indicating significant misalignment in how meetings are perceived and executed. This suggests that employees and leadership may have vastly different views on the necessity, structure, and value of meetings, leading to wasted time, frustration, and decreased efficiency. Major meeting inefficiencies can lead to disengagement, decision-making delays, and operational slowdowns if not corrected quickly.",
      },
    ),
    Indicator.purposeDriven: IndicatorData(
      heading: 'Purpose Driven',
      impactText: 'A strong sense of purpose drives engagement, motivation, and long-term success.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body': "Your organization is operating at a ___ purpose-driven leadership benchmark, placing you above the industry average. This indicates that leadership is deeply aligned with the organization's purpose, consistently communicates a compelling vision, and fosters an environment where employees feel connected to a greater cause.",
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body': "Your organization is operating at a ___ purpose-driven leadership benchmark, positioning you slightly above the market average. This suggests that the organization is generally aligned with the company's purpose, but there may be opportunities to enhance clarity, motivation, or execution.",
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body': "Your organization is operating at a ___ purpose-driven leadership benchmark, aligning with the market average. While leadership is committed to a clear purpose, gaps in communication, cultural reinforcement, or strategic execution across the organization may be limiting the full impact of purpose-driven leadership.",
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body': "Your organization is operating at a ___ purpose-driven leadership benchmark, which falls below the market average. This suggests that while a purpose may exist, leadership is not fully integrating it into culture, decision-making, or daily operations, leading to disengagement and strategic misalignment.",
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body': "Your organization is operating at a ___ purpose-driven leadership benchmark, signaling significant disconnects between the organization and the company's purpose. This score suggests that employees may not see a clear vision, leadership may be misaligned, or purpose-driven decision-making is not actively guiding operations. Immediate action is needed.",
        },
      },
      diffTexts: {
        DiffRange.minimal: "Your organization's differentiation score is ___, indicating strong alignment across leadership and staff regarding purpose-driven leadership. This suggests that employees clearly understand and feel connected to the organization's purpose, creating a motivated and engaged workforce.",
        DiffRange.moderate: "Your organization's differentiation score is ___, indicating minor misalignment in leadership's communication or execution of the company's purpose. While leadership generally embraces purpose-driven strategies, some employees may feel disconnected or unclear about how their work contributes to the larger vision. Addressing these inconsistencies will reinforce the organization's purpose and create stronger cultural cohesion.",
        DiffRange.high: "Your organization's differentiation score is ___, signaling moderate misalignment in purpose-driven leadership. This suggests that different teams or leadership levels may have varying interpretations of the company's purpose, leading to inconsistencies in engagement, decision-making, and motivation.",
        DiffRange.extreme: "Your organization's differentiation score is ___, indicating significant misalignment in leadership's ability to communicate and execute a purpose-driven strategy. This suggests that employees and leadership may have vastly different perceptions of the organization's purpose, leading to disengagement, operational inefficiencies, and a lack of direction.  Major leadership misalignment can erode trust, reduce motivation, and hinder strategic execution if not corrected quickly.",
      },
    ),
    Indicator.empoweredLeadership: IndicatorData(
      heading: 'Empowered Leadership',
      impactText: ' Empowered leadership fosters innovation, accountability, and agility.',
      scoreTexts: {
        ScoreRange.perfect: {
          'heading': "Well Done! A Strong Foundation for Success",
          'body': "Your organization is operating at a ___ empowered leadership benchmark, placing you above the industry average. This indicates that leaders at all levels are trusted to make impactful decisions, have the autonomy to drive initiatives, and are equipped with the tools and support necessary for success. Employees feel confident in leadership, and decision-making is streamlined.",
        },
        ScoreRange.excellent: {
          'heading': "Excellent! A Strong Foundation with Room for Growth",
          'body': "Your organization is operating at a ___ empowered leadership benchmark, positioning you slightly above the market average. This suggests that while leadership autonomy is generally strong, some leaders and employees may still lack the full authority, confidence, or support to drive change effectively.",
        },
        ScoreRange.good: {
          'heading': "Opportunity Awaits: A Prime Opportunity for Growth",
          'body': "Your organization is operating at a ___ empowered leadership benchmark, aligning with the market average. This suggests that while leadership is encouraged to take initiative, bureaucratic hurdles, inconsistent decision-making authority, or lack of leadership development may be limiting full empowerment.",
        },
        ScoreRange.moderate: {
          'heading': "Time to Focus: Unlocking Opportunities for Improvement",
          'body': "Your organization is operating at a ___ empowered leadership benchmark, which falls below the market average. This suggests that leaders may not feel fully trusted, lack the authority to make impactful decisions, or operate within an overly bureaucratic structure that limits agility.",
        },
        ScoreRange.low: {
          'heading': "Needs Dedication: A Critical Opportunity for Transformation",
          'body': "Your organization is operating at a ___ empowered leadership benchmark, signaling significant leadership inefficiencies. This suggests that decision-making may be overly centralized, leaders and employees lack confidence in their authority, or leadership structures do not support independent problem-solving. Immediate action is required.",
        },
      },
      diffTexts: {
        DiffRange.minimal: "Your organization’s differentiation score is ___, indicating strong alignment across leadership and staff regarding leadership empowerment. This suggests that leaders at all levels feel trusted, autonomous, and confident in making impactful decisions.",
        DiffRange.moderate: "Your organization’s differentiation score is ___, indicating minor misalignment in leadership empowerment. While leadership is generally strong, some leaders and employees may feel they lack the authority, support, or trust needed to drive initiatives effectively. Addressing these gaps will reinforce leadership confidence and drive more agile decision-making.",
        DiffRange.high: "Your organization’s differentiation score is ___, signaling moderate misalignment in leadership empowerment. This suggests that different levels of leadership and hierarchies may have varying degrees of decision-making autonomy, creating inconsistencies in execution and strategic alignment.",
        DiffRange.extreme: "Your organization’s differentiation score is ___, indicating significant misalignment in leadership empowerment. This suggests that leaders and employees may not feel trusted, lack decision-making authority, or operate in a culture where initiative is discouraged. These conditions create operational bottlenecks, slow execution, and reduce innovation.",
      },
    ),
  };
}
