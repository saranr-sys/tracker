-- Run this entire SQL in your Supabase SQL Editor

-- 1. Tasks table
create table if not exists tasks (
  id text primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  name text not null,
  time text default '',
  emoji text default '✏️',
  section text default 'Morning',
  done boolean default false,
  created_at timestamptz default now()
);
alter table tasks enable row level security;
create policy "Users manage own tasks" on tasks for all using (auth.uid() = user_id);

-- 2. Completions table (daily task state)
create table if not exists completions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  task_id text references tasks(id) on delete cascade not null,
  date date not null,
  done boolean default false,
  unique(user_id, task_id, date)
);
alter table completions enable row level security;
create policy "Users manage own completions" on completions for all using (auth.uid() = user_id);

-- 3. Steps table
create table if not exists steps (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  date date not null,
  count integer default 0,
  unique(user_id, date)
);
alter table steps enable row level security;
create policy "Users manage own steps" on steps for all using (auth.uid() = user_id);

-- 4. Daily summary table (for streaks + weekly history)
create table if not exists daily_summary (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  date date not null,
  pct integer default 0,
  unique(user_id, date)
);
alter table daily_summary enable row level security;
create policy "Users manage own summary" on daily_summary for all using (auth.uid() = user_id);
