# My Routine Tracker — Setup Guide

## What you need (all free)
- GitHub account → github.com
- Supabase account → supabase.com
- Vercel account → vercel.com (sign in with GitHub)

---

## Step 1 — Supabase Setup

1. Go to supabase.com → New Project
2. Name it "my-routine" → set a password → Create
3. Wait ~1 min for it to spin up
4. Go to **SQL Editor** (left sidebar)
5. Paste the entire contents of `SUPABASE_SCHEMA.sql` → click **Run**
6. Go to **Authentication → Providers → Google** → Enable it
   - You'll need Google OAuth credentials (see below)
7. Go to **Project Settings → API** and copy:
   - `Project URL` → this is REACT_APP_SUPABASE_URL
   - `anon public` key → this is REACT_APP_SUPABASE_ANON_KEY

### Google OAuth (for Google login)
1. Go to console.cloud.google.com
2. Create a new project → APIs & Services → Credentials
3. Create OAuth 2.0 Client ID (Web application)
4. Add to Authorized redirect URIs:
   `https://YOUR-PROJECT.supabase.co/auth/v1/callback`
5. Copy Client ID and Secret into Supabase → Auth → Google provider

---

## Step 2 — GitHub Setup

1. Go to github.com → New repository
2. Name it "my-routine-tracker" → Public → Create
3. Upload all the files from this folder to the repo
   (drag and drop them in the GitHub web UI)

---

## Step 3 — Vercel Deploy

1. Go to vercel.com → Sign in with GitHub
2. Click "Add New Project" → Import your "my-routine-tracker" repo
3. In Environment Variables, add:
   - `REACT_APP_SUPABASE_URL` = your Supabase project URL
   - `REACT_APP_SUPABASE_ANON_KEY` = your Supabase anon key
4. Click Deploy → wait ~1 min
5. Vercel gives you a live URL like `https://my-routine-tracker.vercel.app`

### Add to Supabase allowed URLs
Go to Supabase → Authentication → URL Configuration:
- Site URL: `https://my-routine-tracker.vercel.app`
- Redirect URLs: `https://my-routine-tracker.vercel.app`

---

## Step 4 — Add to iPhone Home Screen

1. Open your Vercel URL in Safari on iPhone
2. Tap Share button → "Add to Home Screen"
3. Name it "My Routine" → Add
4. Done! Opens like a native app ✅

---

## Notes
- Magic link login works for ANY email — no Google needed
- Google login works once you set up OAuth credentials
- Data saves per user to Supabase — works across all devices
- Your streak and history are stored permanently in the database
