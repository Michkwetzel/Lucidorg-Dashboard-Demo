# LucidOrg Assessment Platform v1

> **[Read the full case study](https://www.notion.so/Case-Study-1-Assessment-Platform-MVP-294b502d0e3a809f8142e4b78171f6e7?source=copy_link)**

End-to-end enterprise assessment platform built as sole founding engineer. Automated a weeks-long manual process to hours, achieving 95% completion rate with first enterprise client (21-person deployment).

https://github.com/user-attachments/assets/71e56a37-d5f8-43c8-8ce3-56ea38f3e88d


## Tech Stack

- **Frontend**: Flutter/Dart (assessment engine + admin dashboard)
- **Backend**: Google Cloud Functions (Python)
- **Database**: Cloud Firestore with real-time sync
- **Auth**: Firebase Authentication with custom token-based access
- **Email**: Amazon SES with delivery tracking

## Key Features

- **Token-Based Access System** - Rapid MVP deployment without payment gateway
- **Two-App Architecture** - Public survey interface + authenticated admin dashboard
- **Automated Distribution** - Email management, custom templates, automated reminders
- **Real-Time Tracking** - Live participation monitoring and benchmark calculations
- **Automated Reporting** - Dynamic visualizations (bar, pie, radar charts) with business impact analysis

## Technical Highlights

- Built complete serverless architecture from authentication to email infrastructure
- Implemented real-time data synchronization across distributed clients
- Deployed production system in 4 months as solo engineer
- Added custom domain support overnight when enterprise firewalls blocked Firebase

## Key Learnings

This project taught me that technical execution isn't enough—product validation must come first. We built a working platform that enterprises couldn't use because our fixed 3-tier hierarchy couldn't represent their organizational structures. These insights directly informed the platform rebuild (v2).

**Timeline**: 4 months (Oct 2024 - Jan 2025)  
**Role**: Founding Engineer (Solo)  
**Impact**: Validated technical execution, revealed critical product assumptions

