-- Speed Rivals · esquema actual (referencia para Supabase)
-- Este archivo documenta la estructura que usa la versión publicada.
-- Revisa el proyecto y sus políticas antes de ejecutar en otra base de datos.

create table if not exists public.race_results (
  id uuid primary key default gen_random_uuid(),
  winner text not null,
  distance numeric not null default 0,
  player_one text not null default 'PILOTO',
  player_two text not null default 'RIVAL',
  created_at timestamptz not null default now(),
  user_id uuid references auth.users(id),
  race_id text,
  player_distance numeric
);

alter table public.race_results
  add column if not exists user_id uuid references auth.users(id),
  add column if not exists race_id text,
  add column if not exists player_distance numeric;

alter table public.race_results enable row level security;

create table if not exists public.race_leaderboard (
  race_id text primary key,
  winner text not null,
  distance numeric not null default 0,
  created_at timestamptz not null default now()
);

alter table public.race_leaderboard enable row level security;

-- El historial sólo puede verlo la cuenta propietaria del resultado.
drop policy if exists "Anyone can read race results" on public.race_results;
drop policy if exists "Anyone can insert race results" on public.race_results;
drop policy if exists "Cada jugador lee su propio historial" on public.race_results;
drop policy if exists "Usuarios guardan sus propios resultados" on public.race_results;

create policy "Cada jugador lee su propio historial"
on public.race_results
for select
to authenticated
using ((select auth.uid()) = user_id);

create policy "Usuarios guardan sus propios resultados"
on public.race_results
for insert
to authenticated
with check ((select auth.uid()) = user_id);

-- El ranking público sólo expone ganador, distancia y fecha.
drop policy if exists "Todos ven el Hall of Fame" on public.race_leaderboard;

create policy "Todos ven el Hall of Fame"
on public.race_leaderboard
for select
to anon, authenticated
using (true);

grant select, insert on public.race_results to authenticated;
grant select on public.race_leaderboard to anon, authenticated;

-- Cada resultado guardado actualiza el ranking compartido.
create or replace function public.sync_race_leaderboard()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  public_race_id text;
begin
  public_race_id := coalesce(new.race_id, new.id::text);

  insert into public.race_leaderboard as board
    (race_id, winner, distance, created_at)
  values
    (public_race_id, new.winner, new.distance, new.created_at)
  on conflict (race_id) do update
    set winner = excluded.winner,
        distance = greatest(board.distance, excluded.distance),
        created_at = least(board.created_at, excluded.created_at);

  return new;
end;
$$;

drop trigger if exists race_results_sync_leaderboard on public.race_results;

create trigger race_results_sync_leaderboard
after insert on public.race_results
for each row execute function public.sync_race_leaderboard();
