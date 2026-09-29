-- DockHub: run this once in Supabase > SQL Editor.
-- Change the admin email below if needed (keep it the same in both places).

-- 1) Per-user dashboard data (categories + bookmarks), synced across devices
create table if not exists public.user_dashboards (
  user_id uuid primary key references auth.users(id) on delete cascade,
  categories jsonb not null default '[]'::jsonb,
  dark boolean not null default true,
  updated_at timestamptz not null default now()
);
alter table public.user_dashboards enable row level security;

drop policy if exists "user_dashboards select own" on public.user_dashboards;
drop policy if exists "user_dashboards insert own" on public.user_dashboards;
drop policy if exists "user_dashboards update own" on public.user_dashboards;
create policy "user_dashboards select own" on public.user_dashboards for select using (auth.uid() = user_id);
create policy "user_dashboards insert own" on public.user_dashboards for insert with check (auth.uid() = user_id);
create policy "user_dashboards update own" on public.user_dashboards for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- If you previously created the old "dashboards" table, you can drop it:
-- drop table if exists public.dashboards;

-- 2) Admin check (server-side). Requires a CONFIRMED email.
create or replace function public.is_admin()
returns boolean language sql security definer set search_path = public stable as $$
  select exists (
    select 1 from auth.users u
    where u.id = auth.uid()
      and lower(u.email) = 'codeswithdark83@gmail.com'
      and u.email_confirmed_at is not null
  );
$$;

-- 3) Admin-only user list (reads auth.users, so values cannot be spoofed)
create or replace function public.admin_list_users()
returns table (id uuid, email text, name text, provider text, created_at timestamptz, last_sign_in_at timestamptz)
language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin() then
    raise exception 'not authorized';
  end if;
  return query
    select u.id, u.email::text,
           coalesce(u.raw_user_meta_data->>'name', u.raw_user_meta_data->>'full_name', '')::text,
           coalesce(u.raw_app_meta_data->>'provider', 'email')::text,
           u.created_at, u.last_sign_in_at
    from auth.users u
    order by u.created_at desc;
end;
$$;

revoke all on function public.admin_list_users() from public, anon;
grant execute on function public.admin_list_users() to authenticated;
revoke all on function public.is_admin() from public, anon;
grant execute on function public.is_admin() to authenticated;
