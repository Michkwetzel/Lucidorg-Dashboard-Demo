# LucidOrg Assessment Platform

End-to-end organizational assessment platform with email distribution and real-time analytics. Built from 0→MVP in 4 months as founding engineer.


> **📖 [Read the Complete Case Study →](https://www.notion.so/LucidOrg-Assessment-Platform-From-Manual-to-Automated-SaaS-Deep-Dive-28db502d0e3a80aa9a12c88c7a4a274c?source=copy_link)**  
> *For videos, architecture deep-dives, production deployment learnings, and complete reflections on what I'd do differently*

---

## 🎯 The Problem

Early-stage startup was manually managing assessments:
- Founders sending links via personal email
- Manual Airtable data collection
- Hand-calculated benchmarks
- Individual client reports

**Mission:** Build self-serve platform. Zero budget. No designer. 4-month deadline.

https://github.com/user-attachments/assets/71e56a37-d5f8-43c8-8ce3-56ea38f3e88d

## 📊 Impact

- **95% completion rate** on first enterprise deployment (20/21 responses)
- **Weeks → Hours** delivery timeline
- **Zero-budget MVP** shipped in 4 months
- Successfully deployed at C-suite leadership retreat

## 🛠️ Tech Stack

- **Frontend:** Flutter/Dart (2 apps)
- **Backend:** Google Cloud Functions (Python)
- **Database:** Firestore
- **Auth:** Firebase + Custom JWT

## ✨ Key Features

- **Token-based access system** - Launched MVP without payment gateway integration
- **Dual-app architecture** - Public assessment + admin dashboard
- **Automated distribution** - Email assessments with reminders
- **Real-time analytics** - Participation tracking & data visualizations
- **Dynamic questions** - Firestore-based content management

## 💡 What I Learned

### The Fundamental Mistake
Built production software without user validation. Should have started with Figma mockups and user research.

### Technical Growth
- **Production vs. Development:** How to debug Firebase auth at 2am during client demos
- **Full-stack ownership:** End-to-end architecture, Flutter/Dart, serverless backends, JWT implementation
- **Enterprise reality:** Custom domains for firewall compatibility, comprehensive logging, token-based auth

### Product Thinking
- **Your vision ≠ user needs** - Spent weeks on visualizations users ignored
- **Founders want everything** - "Build Amazon meets Netflix by Tuesday" → Learning to scope MVPs became critical
- **Actionable > Beautiful** - Users need answers ("What's broken?"), not charts

### The Pivot
Post-launch revealed fixed hierarchies don't match real business structures. Beautiful analytics weren't actionable. Required complete product rebuild with user-centered design.

---

**Built as Founding Engineer | Oct 2024 - Feb 2025**
