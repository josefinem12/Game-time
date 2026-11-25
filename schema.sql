-- Deep Cut leaderboard database.
-- Paste this whole file into Supabase → SQL Editor → New query, then press Run.

create table if not exists public.dives (
  id          uuid primary key,
  player_id   text not null check (char_length(player_id) between 8 and 64),
  player_name text not null check (char_length(player_name) between 1 and 20),
  score       int  not null check (score between 0 and 700),
  categories  text[] not null default '{}',
  hard        boolean not null default false,
  created_at  timestamptz not null default now()
);

create table if not exists public.answers (
  id          bigint generated always as identity primary key,
  dive_id     uuid not null references public.dives(id) on delete cascade,
  player_id   text not null,
  prompt      text not null check (char_length(prompt) <= 200),
  category    text not null check (char_length(category) <= 40),
  answer      text check (char_length(answer) <= 80),
  tier        int  check (tier between 0 and 5),
  points      int  not null check (points between 0 and 100),
  created_at  timestamptz not null default now()
);

create index if not exists dives_score_idx on public.dives (score desc, created_at);
create index if not exists dives_created_idx on public.dives (created_at);
create index if not exists answers_prompt_idx on public.answers (prompt);

-- Row level security: anyone with the site can add dives and read the leaderboard,
-- but nobody can edit or delete someone else's results.
alter table public.dives   enable row level security;
alter table public.answers enable row level security;

drop policy if exists "read dives"  on public.dives;
drop policy if exists "add dives"   on public.dives;
drop policy if exists "read answers" on public.answers;
drop policy if exists "add answers"  on public.answers;

create policy "read dives"   on public.dives   for select to anon using (true);
create policy "add dives"    on public.dives   for insert to anon with check (true);
create policy "read answers" on public.answers for select to anon using (true);
create policy "add answers"  on public.answers for insert to anon with check (true);

grant select, insert on public.dives   to anon;
grant select, insert on public.answers to anon;
