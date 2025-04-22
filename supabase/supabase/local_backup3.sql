--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _realtime;


ALTER SCHEMA _realtime OWNER TO postgres;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: pg_cron; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_cron WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION pg_cron; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_cron IS 'Job scheduler for PostgreSQL';


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA supabase_functions;


ALTER SCHEMA supabase_functions OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: clean_expired_itineraries(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clean_expired_itineraries() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  DELETE FROM "FlightBooking" 
  WHERE departure_date < CURRENT_DATE;
END;
$$;


ALTER FUNCTION public.clean_expired_itineraries() OWNER TO postgres;

--
-- Name: delete_expired_itineraries(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_expired_itineraries() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Delete bookings where departure date is in the past
  DELETE FROM "FlightBooking" 
  WHERE departure_date < CURRENT_DATE;
  
  RETURN NULL;
END;
$$;


ALTER FUNCTION public.delete_expired_itineraries() OWNER TO postgres;

--
-- Name: group_flight_interests(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.group_flight_interests() RETURNS TABLE(origin text, destination text, total_adults bigint)
    LANGUAGE plpgsql
    AS $$
begin
  return query
  select 
    origin,
    destination,
    sum(adults) as total_adults
  from "FlightInterest"
  group by origin, destination;
end;
$$;


ALTER FUNCTION public.group_flight_interests() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
BEGIN
    RETURN query EXECUTE
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name || '/' AS name,
                    NULL::uuid AS id,
                    NULL::timestamptz AS updated_at,
                    NULL::timestamptz AS created_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
                ORDER BY prefixes.name COLLATE "C" LIMIT $3
            )
            UNION ALL
            (SELECT split_part(name, '/', $4) AS key,
                name,
                id,
                updated_at,
                created_at,
                metadata
            FROM storage.objects
            WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
            ORDER BY name COLLATE "C" LIMIT $3)
        ) obj
        ORDER BY name COLLATE "C" LIMIT $3;
        $sql$
        USING prefix, bucket_name, limits, levels, start_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
  DECLARE
    request_id bigint;
    payload jsonb;
    url text := TG_ARGV[0]::text;
    method text := TG_ARGV[1]::text;
    headers jsonb DEFAULT '{}'::jsonb;
    params jsonb DEFAULT '{}'::jsonb;
    timeout_ms integer DEFAULT 1000;
  BEGIN
    IF url IS NULL OR url = 'null' THEN
      RAISE EXCEPTION 'url argument is missing';
    END IF;

    IF method IS NULL OR method = 'null' THEN
      RAISE EXCEPTION 'method argument is missing';
    END IF;

    IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
      headers = '{"Content-Type": "application/json"}'::jsonb;
    ELSE
      headers = TG_ARGV[2]::jsonb;
    END IF;

    IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
      params = '{}'::jsonb;
    ELSE
      params = TG_ARGV[3]::jsonb;
    END IF;

    IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
      timeout_ms = 1000;
    ELSE
      timeout_ms = TG_ARGV[4]::integer;
    END IF;

    CASE
      WHEN method = 'GET' THEN
        SELECT http_get INTO request_id FROM net.http_get(
          url,
          params,
          headers,
          timeout_ms
        );
      WHEN method = 'POST' THEN
        payload = jsonb_build_object(
          'old_record', OLD,
          'record', NEW,
          'type', TG_OP,
          'table', TG_TABLE_NAME,
          'schema', TG_TABLE_SCHEMA
        );

        SELECT http_post INTO request_id FROM net.http_post(
          url,
          payload,
          params,
          headers,
          timeout_ms
        );
      ELSE
        RAISE EXCEPTION 'method argument % is invalid', method;
    END CASE;

    INSERT INTO supabase_functions.hooks
      (hook_table_id, hook_name, request_id)
    VALUES
      (TG_RELID, TG_NAME, request_id);

    RETURN NEW;
  END
$$;


ALTER FUNCTION supabase_functions.http_request() OWNER TO supabase_functions_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: extensions; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.extensions (
    id uuid NOT NULL,
    type text,
    settings jsonb,
    tenant_external_id text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _realtime.extensions OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE _realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: tenants; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.tenants (
    id uuid NOT NULL,
    name text,
    external_id text,
    jwt_secret text,
    max_concurrent_users integer DEFAULT 200 NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    max_events_per_second integer DEFAULT 100 NOT NULL,
    postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
    max_bytes_per_second integer DEFAULT 100000 NOT NULL,
    max_channels_per_client integer DEFAULT 100 NOT NULL,
    max_joins_per_second integer DEFAULT 500 NOT NULL,
    suspend boolean DEFAULT false,
    jwt_jwks jsonb,
    notify_private_alpha boolean DEFAULT false,
    private_only boolean DEFAULT false NOT NULL
);


ALTER TABLE _realtime.tenants OWNER TO supabase_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: FlightBooking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FlightBooking" (
    booking_id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    amadeus_id text,
    queueing_office_id text,
    user_id uuid DEFAULT gen_random_uuid(),
    itineraries jsonb[],
    travelers jsonb[],
    price jsonb,
    departure_date date
);


ALTER TABLE public."FlightBooking" OWNER TO postgres;

--
-- Name: FlightInterest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FlightInterest" (
    flight_interest_id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    origin text,
    destination text,
    departure_date date,
    one_way boolean,
    adults integer,
    user_id uuid,
    return_date date
);


ALTER TABLE public."FlightInterest" OWNER TO postgres;

--
-- Name: Profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Profiles" (
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    first_name text,
    last_name text,
    email text,
    phone text,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    role text
);


ALTER TABLE public."Profiles" OWNER TO postgres;

--
-- Name: ShuttleBooking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ShuttleBooking" (
    booking_id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id uuid DEFAULT gen_random_uuid(),
    first_name text,
    last_name text,
    departure_date date,
    phone_number text,
    email text,
    amount_paid double precision,
    company_id uuid,
    route_id uuid
);


ALTER TABLE public."ShuttleBooking" OWNER TO postgres;

--
-- Name: ShuttleInterest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ShuttleInterest" (
    shttle_interest_id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    origin text,
    destination text,
    departure_date date,
    user_id uuid DEFAULT gen_random_uuid()
);


ALTER TABLE public."ShuttleInterest" OWNER TO postgres;

--
-- Name: ShuttleRoutes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ShuttleRoutes" (
    route_id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    company_id uuid DEFAULT gen_random_uuid(),
    origin text,
    destination text,
    departure_time text,
    arrival_time text,
    bus_stops jsonb[],
    price double precision
);


ALTER TABLE public."ShuttleRoutes" OWNER TO postgres;

--
-- Name: ShuttleServiceCompany; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ShuttleServiceCompany" (
    company_id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    name text,
    address text,
    contact_phone text,
    contact_email text
);


ALTER TABLE public."ShuttleServiceCompany" OWNER TO postgres;

--
-- Name: flight_interest_stats; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.flight_interest_stats AS
 SELECT "FlightInterest".origin,
    "FlightInterest".destination,
    sum("FlightInterest".adults) AS total_adults
   FROM public."FlightInterest"
  GROUP BY "FlightInterest".origin, "FlightInterest".destination;


ALTER VIEW public.flight_interest_stats OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


ALTER TABLE supabase_functions.hooks OWNER TO supabase_functions_admin;

--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: supabase_functions_admin
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE supabase_functions.hooks_id_seq OWNER TO supabase_functions_admin;

--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE supabase_functions.migrations OWNER TO supabase_functions_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
9d2f05d0-233f-406a-b3ab-a3568c8f135f	postgres_cdc_rls	{"region": "us-east-1", "db_host": "+5JkR7EPoJsAtjz+cdk/ZGMDh4Ck8PWqtZx+VnDSocE=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2025-04-18 19:41:31	2025-04-18 19:41:31
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2025-04-08 05:43:42
20220329161857	2025-04-08 05:43:42
20220410212326	2025-04-08 05:43:42
20220506102948	2025-04-08 05:43:42
20220527210857	2025-04-08 05:43:42
20220815211129	2025-04-08 05:43:42
20220815215024	2025-04-08 05:43:42
20220818141501	2025-04-08 05:43:42
20221018173709	2025-04-08 05:43:42
20221102172703	2025-04-08 05:43:42
20221223010058	2025-04-08 05:43:42
20230110180046	2025-04-08 05:43:42
20230810220907	2025-04-08 05:43:42
20230810220924	2025-04-08 05:43:42
20231024094642	2025-04-08 05:43:42
20240306114423	2025-04-08 05:43:42
20240418082835	2025-04-08 05:43:42
20240625211759	2025-04-08 05:43:42
20240704172020	2025-04-08 05:43:42
20240902173232	2025-04-08 05:43:42
20241106103258	2025-04-08 05:43:42
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only) FROM stdin;
c408ab6e-dcad-4309-b1af-2ada2bd3acae	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2025-04-18 19:41:31	2025-04-18 19:41:31	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	9952b4cd-164d-41da-8f98-5a2c04bf0f40	{"action":"user_signedup","actor_id":"05781637-e3bc-4450-9cb7-a5bdcb9f7c97","actor_username":"test@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-08 05:47:55.655941+00	
00000000-0000-0000-0000-000000000000	addd6c20-0dbd-483f-9bcc-67d8fb865bb9	{"action":"login","actor_id":"05781637-e3bc-4450-9cb7-a5bdcb9f7c97","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-08 05:47:55.659667+00	
00000000-0000-0000-0000-000000000000	8fbae5ab-c235-40c8-8851-7266c69eebd3	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"05781637-e3bc-4450-9cb7-a5bdcb9f7c97","user_phone":""}}	2025-04-08 05:49:34.760072+00	
00000000-0000-0000-0000-000000000000	79061a1a-3157-4014-97a4-fade63d551bd	{"action":"user_signedup","actor_id":"33b4fdfd-160b-43c6-a746-45b13f87aece","actor_username":"test@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-08 05:51:30.019213+00	
00000000-0000-0000-0000-000000000000	ce3a63be-ba76-4032-ab15-2c205be83ef5	{"action":"login","actor_id":"33b4fdfd-160b-43c6-a746-45b13f87aece","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-08 05:51:30.022058+00	
00000000-0000-0000-0000-000000000000	d68cc357-a24d-49d5-a67d-cc13987bf7ae	{"action":"logout","actor_id":"33b4fdfd-160b-43c6-a746-45b13f87aece","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account"}	2025-04-08 05:51:54.152948+00	
00000000-0000-0000-0000-000000000000	d111db7a-83f7-4801-befc-67fd9b687af4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"33b4fdfd-160b-43c6-a746-45b13f87aece","user_phone":""}}	2025-04-08 05:52:08.72244+00	
00000000-0000-0000-0000-000000000000	f98c82df-62da-4e6a-a967-9de75b3f8379	{"action":"user_signedup","actor_id":"766e58e1-3d62-4165-95d5-f2fba43bfff7","actor_username":"test@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-08 05:53:10.227588+00	
00000000-0000-0000-0000-000000000000	c4c18e6e-d010-43cd-bf5d-c2c52b04a8a8	{"action":"login","actor_id":"766e58e1-3d62-4165-95d5-f2fba43bfff7","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-08 05:53:10.230356+00	
00000000-0000-0000-0000-000000000000	8e8cce59-88c4-44b3-8222-75fb381ef70a	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"766e58e1-3d62-4165-95d5-f2fba43bfff7","user_phone":""}}	2025-04-08 05:56:51.843199+00	
00000000-0000-0000-0000-000000000000	fd0249a7-74e1-44fc-853d-7c9b6cb7dfb4	{"action":"user_signedup","actor_id":"a7e1e9c7-c57c-4064-a0a3-d8adec6f6dc5","actor_username":"test@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-08 05:57:51.993105+00	
00000000-0000-0000-0000-000000000000	fb083570-70fe-4862-b4ac-93f6b7464d63	{"action":"login","actor_id":"a7e1e9c7-c57c-4064-a0a3-d8adec6f6dc5","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-08 05:57:51.996516+00	
00000000-0000-0000-0000-000000000000	9e89193a-6c1c-4e18-aafb-08053b99a7e9	{"action":"logout","actor_id":"a7e1e9c7-c57c-4064-a0a3-d8adec6f6dc5","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account"}	2025-04-08 05:59:57.615669+00	
00000000-0000-0000-0000-000000000000	5fdb6133-09c0-428a-bb7c-7dc7952deb3e	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@test.com","user_id":"a7e1e9c7-c57c-4064-a0a3-d8adec6f6dc5","user_phone":""}}	2025-04-08 06:04:07.873736+00	
00000000-0000-0000-0000-000000000000	95ad0526-20a8-4ce4-b09a-be3d857e684e	{"action":"user_signedup","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-08 06:04:33.351796+00	
00000000-0000-0000-0000-000000000000	e51e00a9-3830-4a33-a5bc-36e8db3064dd	{"action":"login","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-08 06:04:33.357325+00	
00000000-0000-0000-0000-000000000000	339e21b3-964a-4bd2-a76a-2b4577d3123b	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 07:04:01.240194+00	
00000000-0000-0000-0000-000000000000	78f83d6a-76fb-4737-98c7-3fe2b379828d	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 07:04:01.245526+00	
00000000-0000-0000-0000-000000000000	27cf0dde-6f5d-4294-9126-8a34fcd989be	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 08:03:35.557356+00	
00000000-0000-0000-0000-000000000000	04ab6f30-428b-4a36-ad46-46cec29cd254	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 08:03:35.560538+00	
00000000-0000-0000-0000-000000000000	7b3deea1-e536-4496-a4e0-cd50ba3f76ac	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 09:03:00.791097+00	
00000000-0000-0000-0000-000000000000	0723c84a-1877-4d7a-b10f-0aa0ba078fe9	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 09:03:00.80015+00	
00000000-0000-0000-0000-000000000000	7f1a5c4d-44ef-4168-9bec-1852795043c6	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 10:20:45.013475+00	
00000000-0000-0000-0000-000000000000	69cadb7d-9e3c-49e4-a72c-209435eeb751	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 10:20:45.017997+00	
00000000-0000-0000-0000-000000000000	1fe8db47-c7be-471c-ba4c-6b9a94c2fd13	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 12:22:34.832587+00	
00000000-0000-0000-0000-000000000000	3ac96c6e-400c-4137-bef6-47cd5e93314e	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 12:22:34.849718+00	
00000000-0000-0000-0000-000000000000	7ce3b240-bd58-4b5d-bcaf-5e22192a1546	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 13:22:01.242769+00	
00000000-0000-0000-0000-000000000000	0ad497ed-af91-4b8a-aee1-307ec4622a53	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-08 13:22:01.246711+00	
00000000-0000-0000-0000-000000000000	f7ed106a-df46-4d70-86f7-b0b9ff1fdcad	{"action":"logout","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account"}	2025-04-08 14:05:40.334249+00	
00000000-0000-0000-0000-000000000000	1ab5dac7-4545-4368-867d-693ae6d42e1c	{"action":"user_signedup","actor_id":"8904b0fd-0b3c-4776-87a5-eb403851e205","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-08 14:06:24.018473+00	
00000000-0000-0000-0000-000000000000	d6f91fbd-2777-4903-9bd2-bbfd111054aa	{"action":"login","actor_id":"8904b0fd-0b3c-4776-87a5-eb403851e205","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-08 14:06:24.025408+00	
00000000-0000-0000-0000-000000000000	71590fb9-5633-4ca6-afd0-c7ad5ea8ec12	{"action":"user_repeated_signup","actor_id":"8904b0fd-0b3c-4776-87a5-eb403851e205","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-04-08 14:07:37.572359+00	
00000000-0000-0000-0000-000000000000	9881b4aa-44ca-4d26-8bdb-561f1bac2789	{"action":"logout","actor_id":"8904b0fd-0b3c-4776-87a5-eb403851e205","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-08 14:08:07.78275+00	
00000000-0000-0000-0000-000000000000	32780235-0e64-4e5b-9dab-f2801bb9f8a7	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"simon@gmail.com","user_id":"8904b0fd-0b3c-4776-87a5-eb403851e205","user_phone":""}}	2025-04-08 14:08:10.202228+00	
00000000-0000-0000-0000-000000000000	72de6d67-7eaf-432d-b3ae-7c0e5c65fb5c	{"action":"user_signedup","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-08 14:08:29.83478+00	
00000000-0000-0000-0000-000000000000	34e0cbdf-4907-49ff-82fc-3feda91a4b04	{"action":"login","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-08 14:08:29.83839+00	
00000000-0000-0000-0000-000000000000	cc8866ed-28a6-44eb-816e-30d7fd88d501	{"action":"logout","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-08 14:11:49.611818+00	
00000000-0000-0000-0000-000000000000	d64799ce-3251-4f6b-8f44-27f393cfc292	{"action":"login","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-09 04:49:21.032857+00	
00000000-0000-0000-0000-000000000000	59ce4b2c-6f63-450b-b88b-670dec6a694a	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-09 05:58:59.604046+00	
00000000-0000-0000-0000-000000000000	27b6dd72-849c-4eb5-9833-89758842f560	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-09 05:58:59.606932+00	
00000000-0000-0000-0000-000000000000	17ade241-fa46-499b-b882-16f5e693d44c	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-09 11:05:08.067397+00	
00000000-0000-0000-0000-000000000000	7e8522e4-859e-401c-8829-b6cdfa1f0349	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-09 11:05:08.073605+00	
00000000-0000-0000-0000-000000000000	23efba87-bf4c-4416-9d34-b8ec26a1d449	{"action":"token_refreshed","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 04:36:57.479474+00	
00000000-0000-0000-0000-000000000000	af5fb4f4-66bc-46eb-ab9d-150a7c360ab4	{"action":"token_revoked","actor_id":"f7ca04aa-906e-403c-a742-17151ebfaf1e","actor_username":"test@test.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 04:36:57.49287+00	
00000000-0000-0000-0000-000000000000	d75e0a83-dbad-48eb-aa34-cb8c296bbdd8	{"action":"login","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 04:51:11.085023+00	
00000000-0000-0000-0000-000000000000	52722b80-49b6-4f18-941e-6119ac2aa53f	{"action":"token_refreshed","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 05:50:33.973276+00	
00000000-0000-0000-0000-000000000000	9de6d2e0-8b06-4b45-8d00-2cde7ea463c9	{"action":"token_revoked","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 05:50:33.978418+00	
00000000-0000-0000-0000-000000000000	311bcb8a-19ed-4342-9f0c-64b94ac3bc53	{"action":"token_refreshed","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 06:49:59.569752+00	
00000000-0000-0000-0000-000000000000	a01ff09a-2105-46d8-b2c5-5066604e57c5	{"action":"token_revoked","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 06:49:59.576826+00	
00000000-0000-0000-0000-000000000000	bfa6a07a-e3a9-442f-83f8-e8ebc55d21ad	{"action":"token_refreshed","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 07:49:21.162003+00	
00000000-0000-0000-0000-000000000000	020e25c4-61f5-4da5-a962-ab103f147d3b	{"action":"token_revoked","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 07:49:21.166843+00	
00000000-0000-0000-0000-000000000000	7b9b8ee5-19bb-4740-aad0-3b1cb4a8dc83	{"action":"token_refreshed","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 08:48:49.961909+00	
00000000-0000-0000-0000-000000000000	fdb7a995-fbee-4c97-bc92-97fccbbc6a17	{"action":"token_revoked","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 08:48:49.965038+00	
00000000-0000-0000-0000-000000000000	4a7a6763-d589-456f-a276-0b7a872153a6	{"action":"token_refreshed","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 09:48:09.950582+00	
00000000-0000-0000-0000-000000000000	8844013b-381a-4fa8-bbc7-132b443589f7	{"action":"token_revoked","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 09:48:09.952368+00	
00000000-0000-0000-0000-000000000000	c557f8a8-4211-45f9-8008-ed9d08395e15	{"action":"token_refreshed","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 10:47:32.508818+00	
00000000-0000-0000-0000-000000000000	e04fdbb2-d0c3-4c18-954e-94987ee2d559	{"action":"token_revoked","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 10:47:32.538833+00	
00000000-0000-0000-0000-000000000000	0853457c-afc7-4a30-bfac-da7e9366464a	{"action":"token_refreshed","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 11:47:02.481261+00	
00000000-0000-0000-0000-000000000000	8aaa065d-ad26-4c58-81b5-b68303cbf037	{"action":"token_revoked","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-10 11:47:02.489708+00	
00000000-0000-0000-0000-000000000000	68c27093-843e-4d42-8c24-df430e910e16	{"action":"logout","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 12:11:34.346191+00	
00000000-0000-0000-0000-000000000000	306ff067-f839-458b-abfb-18ff0c0c468c	{"action":"user_signedup","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-10 12:12:47.441309+00	
00000000-0000-0000-0000-000000000000	3534962c-54ec-4189-b3ec-eb459539c81d	{"action":"login","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 12:12:47.468172+00	
00000000-0000-0000-0000-000000000000	db462cf5-9b92-41c0-a1c5-12607de061ef	{"action":"logout","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 12:15:52.011122+00	
00000000-0000-0000-0000-000000000000	2f33291c-f38f-4c4c-a517-1e1cb01584da	{"action":"login","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 12:16:13.032011+00	
00000000-0000-0000-0000-000000000000	923c2660-a0ad-4429-8f06-e26647e26c83	{"action":"logout","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 12:16:16.07827+00	
00000000-0000-0000-0000-000000000000	cd533fc9-42f7-465f-b24c-e39d6a01b6e2	{"action":"login","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 12:18:35.528109+00	
00000000-0000-0000-0000-000000000000	dce4ce03-d990-4056-8773-ae222a97aa78	{"action":"logout","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 12:20:57.107666+00	
00000000-0000-0000-0000-000000000000	232ddfc7-cc50-4bf8-b351-f9fcd112af11	{"action":"login","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 12:24:08.608121+00	
00000000-0000-0000-0000-000000000000	9c2a647c-3d89-4812-9f4b-c6faab643f44	{"action":"logout","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 12:25:09.979124+00	
00000000-0000-0000-0000-000000000000	c45d720a-d12a-4cf8-90e9-0e688b48fba5	{"action":"login","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 12:25:27.63797+00	
00000000-0000-0000-0000-000000000000	b63db0a7-10f8-4aaa-a942-ec021c5c4576	{"action":"logout","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 12:27:40.269663+00	
00000000-0000-0000-0000-000000000000	fae83965-87cd-44ba-9f10-55fc6defd218	{"action":"user_signedup","actor_id":"11e13082-156f-44e3-9bd2-ee64cfd36af3","actor_username":"smahachi@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-10 12:29:41.352969+00	
00000000-0000-0000-0000-000000000000	9782371a-8c40-4c23-a43c-484f0ef37d64	{"action":"login","actor_id":"11e13082-156f-44e3-9bd2-ee64cfd36af3","actor_username":"smahachi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 12:29:41.356872+00	
00000000-0000-0000-0000-000000000000	9275c89c-8d90-41e5-96d4-0671b83ca193	{"action":"logout","actor_id":"11e13082-156f-44e3-9bd2-ee64cfd36af3","actor_username":"smahachi@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 12:32:06.243325+00	
00000000-0000-0000-0000-000000000000	f02e690b-abe6-4473-8000-ae1c90b2ccd8	{"action":"login","actor_id":"11e13082-156f-44e3-9bd2-ee64cfd36af3","actor_username":"smahachi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 12:35:34.124223+00	
00000000-0000-0000-0000-000000000000	8f4ac4c0-38f6-4f99-8e25-cf7b5609fcf3	{"action":"logout","actor_id":"11e13082-156f-44e3-9bd2-ee64cfd36af3","actor_username":"smahachi@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 13:04:37.695475+00	
00000000-0000-0000-0000-000000000000	6fe17a9f-9a73-4716-af38-2ae8c74cf494	{"action":"login","actor_id":"11e13082-156f-44e3-9bd2-ee64cfd36af3","actor_username":"smahachi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 13:04:46.517389+00	
00000000-0000-0000-0000-000000000000	ea66950f-9b9d-4b6f-913c-4b8c86f2c88c	{"action":"logout","actor_id":"11e13082-156f-44e3-9bd2-ee64cfd36af3","actor_username":"smahachi@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 13:26:24.829097+00	
00000000-0000-0000-0000-000000000000	3b5c59e9-99b1-4c0e-8626-a067cdb8292b	{"action":"user_signedup","actor_id":"8eeb97b5-f931-4e2b-83de-efddbddf8815","actor_username":"gmadamombe@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-10 13:27:57.287136+00	
00000000-0000-0000-0000-000000000000	b85ebd90-ee74-461b-a8a7-bbf21272e715	{"action":"login","actor_id":"8eeb97b5-f931-4e2b-83de-efddbddf8815","actor_username":"gmadamombe@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 13:27:57.292636+00	
00000000-0000-0000-0000-000000000000	068c512a-0d6e-4179-ba77-5e414e32b3b4	{"action":"logout","actor_id":"8eeb97b5-f931-4e2b-83de-efddbddf8815","actor_username":"gmadamombe@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 13:36:39.388765+00	
00000000-0000-0000-0000-000000000000	f37c2d36-1278-4972-8015-b7c9fc6d7ae8	{"action":"login","actor_id":"8eeb97b5-f931-4e2b-83de-efddbddf8815","actor_username":"gmadamombe@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 13:37:35.484034+00	
00000000-0000-0000-0000-000000000000	16df0c29-e1ae-41ed-b3ac-1751b91d8b63	{"action":"logout","actor_id":"8eeb97b5-f931-4e2b-83de-efddbddf8815","actor_username":"gmadamombe@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 13:43:25.005155+00	
00000000-0000-0000-0000-000000000000	6f94b219-dbc5-4416-a573-9b5c8868b764	{"action":"login","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 13:44:31.923221+00	
00000000-0000-0000-0000-000000000000	f3b91449-405f-46d0-a86d-5742a54d9fdd	{"action":"logout","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 13:44:37.430332+00	
00000000-0000-0000-0000-000000000000	1b8368d9-f8c1-4961-a4a6-72e9871be32a	{"action":"login","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 13:44:52.661529+00	
00000000-0000-0000-0000-000000000000	5a4315a3-f650-4898-a049-4479cff71886	{"action":"logout","actor_id":"fe6632be-8ed7-4528-9cf2-9ab1ca27707c","actor_username":"simon@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 14:11:14.442539+00	
00000000-0000-0000-0000-000000000000	7f313702-32cf-4340-b593-472a8b99e396	{"action":"login","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 14:11:56.090348+00	
00000000-0000-0000-0000-000000000000	002ec401-9933-40bd-ad58-be632abe993d	{"action":"logout","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 14:30:49.113433+00	
00000000-0000-0000-0000-000000000000	e822bb28-e913-46bc-9455-0c7b8bc48c57	{"action":"login","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 14:37:17.365754+00	
00000000-0000-0000-0000-000000000000	b3164d4f-ae9b-4df0-a474-b081632fcd25	{"action":"logout","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 14:39:33.44812+00	
00000000-0000-0000-0000-000000000000	9939124c-a402-451c-bc29-9eeadb469277	{"action":"login","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-10 14:39:55.037749+00	
00000000-0000-0000-0000-000000000000	cb5c2368-ef90-4b29-a4ff-0edc8ef74864	{"action":"logout","actor_id":"f38ce1fd-27f1-4534-92e1-e613d5a9a9ee","actor_username":"ajackson@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-10 14:42:17.358696+00	
00000000-0000-0000-0000-000000000000	95ceb2ed-9115-4209-871a-1ee49ed1c461	{"action":"user_signedup","actor_id":"7ded3799-80c0-4539-9c79-43a2003eaa5c","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-11 05:43:49.874937+00	
00000000-0000-0000-0000-000000000000	09ecdfc6-d7d0-4a7d-b9d6-765748faedd7	{"action":"login","actor_id":"7ded3799-80c0-4539-9c79-43a2003eaa5c","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-11 05:43:49.88269+00	
00000000-0000-0000-0000-000000000000	7570dacb-7a4f-4b32-8233-ea0d565ae1fd	{"action":"token_refreshed","actor_id":"7ded3799-80c0-4539-9c79-43a2003eaa5c","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 06:43:17.737633+00	
00000000-0000-0000-0000-000000000000	2354f2c0-1fdc-4f49-a3bf-4816f6fb28ef	{"action":"token_revoked","actor_id":"7ded3799-80c0-4539-9c79-43a2003eaa5c","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 06:43:17.739652+00	
00000000-0000-0000-0000-000000000000	c87e5269-131c-4519-9442-c1c50ef113d3	{"action":"token_refreshed","actor_id":"7ded3799-80c0-4539-9c79-43a2003eaa5c","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 07:42:47.883359+00	
00000000-0000-0000-0000-000000000000	42e57654-348b-4b51-9ddd-26fc7734d552	{"action":"token_revoked","actor_id":"7ded3799-80c0-4539-9c79-43a2003eaa5c","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 07:42:47.891826+00	
00000000-0000-0000-0000-000000000000	276b0473-e94d-4600-8dea-ab7e062f1aad	{"action":"logout","actor_id":"7ded3799-80c0-4539-9c79-43a2003eaa5c","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-11 08:06:51.692088+00	
00000000-0000-0000-0000-000000000000	f8970de8-9d2a-4619-8264-c491433b5e38	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"smotsi@gmail.com","user_id":"7ded3799-80c0-4539-9c79-43a2003eaa5c","user_phone":""}}	2025-04-11 08:07:08.694126+00	
00000000-0000-0000-0000-000000000000	281873d8-6eae-4fd7-90d4-e25841a2495e	{"action":"user_signedup","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-11 08:07:43.812294+00	
00000000-0000-0000-0000-000000000000	f8c793f5-4685-48ff-b994-90e09f5e4b57	{"action":"login","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-11 08:07:43.815778+00	
00000000-0000-0000-0000-000000000000	6ca416cd-7162-4516-8fb2-0ff4d3f4ff98	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 09:07:14.634983+00	
00000000-0000-0000-0000-000000000000	7a17de25-a554-40fd-8fe4-25906cd704de	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 09:07:14.643125+00	
00000000-0000-0000-0000-000000000000	410fe9fd-b3f2-4631-b983-e3d6c0c924a6	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 10:30:11.839952+00	
00000000-0000-0000-0000-000000000000	6aef75e1-0ebf-481d-ac50-352e47d98d66	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 10:30:11.845319+00	
00000000-0000-0000-0000-000000000000	4b5123d5-aeec-4613-85c1-721a22ddf202	{"action":"logout","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-11 11:16:02.625159+00	
00000000-0000-0000-0000-000000000000	46bb1f4e-6696-42e9-8263-4d15364257f2	{"action":"login","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-11 11:16:37.432149+00	
00000000-0000-0000-0000-000000000000	9bc0d283-defd-4238-bb73-c41865608a33	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 12:16:05.802893+00	
00000000-0000-0000-0000-000000000000	2dd651d8-89cc-4ff8-a2f2-202f230b40e0	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 12:16:05.807137+00	
00000000-0000-0000-0000-000000000000	0a1fda05-5d9c-4b0a-9053-005fcff138b2	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 13:15:31.105371+00	
00000000-0000-0000-0000-000000000000	c3c28833-e8e0-4b31-a900-3758b137331b	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 13:15:31.108276+00	
00000000-0000-0000-0000-000000000000	1148ff80-538c-4e56-b941-765fc534a379	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 14:15:01.195235+00	
00000000-0000-0000-0000-000000000000	0674fd6c-2efc-4d25-9998-7dfc8d5cef61	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-11 14:15:01.199437+00	
00000000-0000-0000-0000-000000000000	888d2f82-2f8f-4dc0-8138-02713931a11d	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-13 17:07:17.957703+00	
00000000-0000-0000-0000-000000000000	6fd8b87b-cf21-4f21-a75a-beb4f602ca10	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-13 17:07:17.965029+00	
00000000-0000-0000-0000-000000000000	e192b071-a67d-47a5-8154-308b715ea158	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-13 18:06:45.015196+00	
00000000-0000-0000-0000-000000000000	5a53707b-1d76-4f90-b655-409df32431dd	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-13 18:06:45.020215+00	
00000000-0000-0000-0000-000000000000	9cb488eb-3719-4dde-aab5-1a25fb57e0ca	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-13 19:06:14.597263+00	
00000000-0000-0000-0000-000000000000	e91d6857-9983-4ab6-aa5a-56f611c6bf8c	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-13 19:06:14.602503+00	
00000000-0000-0000-0000-000000000000	2710f1cc-3b76-414c-84de-1b148fec3d03	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 04:38:25.313365+00	
00000000-0000-0000-0000-000000000000	850a692e-6b42-4ca3-81c0-098e08c9023a	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 04:38:25.317799+00	
00000000-0000-0000-0000-000000000000	4d43f0eb-3a48-4e7a-ad7a-6f12968e018b	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 05:37:56.221628+00	
00000000-0000-0000-0000-000000000000	945951d8-065d-4db5-b574-b1cdc2046be6	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 05:37:56.223336+00	
00000000-0000-0000-0000-000000000000	2bc32469-259a-4bdd-b0fe-7e9003ba4a9b	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 06:37:26.047753+00	
00000000-0000-0000-0000-000000000000	e71060da-7abb-4740-8942-50da62a9441d	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 06:37:26.050227+00	
00000000-0000-0000-0000-000000000000	a97d33db-92a5-4616-9ef5-8cd123f278bb	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 07:36:58.275057+00	
00000000-0000-0000-0000-000000000000	07cf546f-0f3f-4167-9946-1e3d7d24d486	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 07:36:58.278913+00	
00000000-0000-0000-0000-000000000000	9185bc0f-6782-4bfa-85f9-c88e8c486ad9	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 08:36:25.973533+00	
00000000-0000-0000-0000-000000000000	15c0dcc3-6dbb-496b-bf05-9eb6abd7856d	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 08:36:25.977832+00	
00000000-0000-0000-0000-000000000000	b934a0d1-020a-4a60-9047-51a6ac487f79	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 09:58:52.479639+00	
00000000-0000-0000-0000-000000000000	a719d430-b6db-4d48-ae93-8bf502e21060	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 09:58:52.482846+00	
00000000-0000-0000-0000-000000000000	83053b1e-9732-48d8-a87f-8a9bf95f9d59	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 10:58:21.87935+00	
00000000-0000-0000-0000-000000000000	6fddec18-c579-4609-8b93-89f5d4c76425	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 10:58:21.88347+00	
00000000-0000-0000-0000-000000000000	a6208dde-6a7a-43b6-b783-70d2df9c7caf	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 11:57:44.343097+00	
00000000-0000-0000-0000-000000000000	fe990d6d-3c01-44a1-8152-b56d91c40f27	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 11:57:44.346624+00	
00000000-0000-0000-0000-000000000000	53aa5ce1-eea4-4b11-aafd-28c214d69ee0	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 14:38:27.562529+00	
00000000-0000-0000-0000-000000000000	67fd16cc-fd31-475e-860c-da611a49f87b	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-14 14:38:27.569256+00	
00000000-0000-0000-0000-000000000000	b8a40b91-7a8c-488d-bdc2-aaf4fdef8535	{"action":"logout","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-14 15:04:22.010306+00	
00000000-0000-0000-0000-000000000000	637a93ea-0c5a-47c6-a6b7-0c27aad7ca03	{"action":"user_signedup","actor_id":"3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223","actor_username":"igreats@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-04-14 15:05:07.387454+00	
00000000-0000-0000-0000-000000000000	50082825-b813-432a-8274-05110822a174	{"action":"login","actor_id":"3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223","actor_username":"igreats@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-14 15:05:07.396995+00	
00000000-0000-0000-0000-000000000000	acfd7abc-55e2-4fc5-8c67-a9c46a16f5ca	{"action":"logout","actor_id":"3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223","actor_username":"igreats@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-14 15:05:16.557097+00	
00000000-0000-0000-0000-000000000000	eac3908a-c2b1-48ce-936c-d4b6391495da	{"action":"login","actor_id":"3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223","actor_username":"igreats@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-14 15:05:39.615111+00	
00000000-0000-0000-0000-000000000000	bd4423c2-ed03-46eb-83c6-26208a9b10a1	{"action":"logout","actor_id":"3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223","actor_username":"igreats@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-04-14 15:07:24.846997+00	
00000000-0000-0000-0000-000000000000	e0ba3880-419d-411f-8bf5-e02a92045ae6	{"action":"login","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-14 15:08:04.574102+00	
00000000-0000-0000-0000-000000000000	4c49f62d-a7c7-44a8-918d-05411e0815e8	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 04:21:12.160133+00	
00000000-0000-0000-0000-000000000000	739a69a6-af6c-4e48-b324-fce5773c5485	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 04:21:12.162849+00	
00000000-0000-0000-0000-000000000000	a88a723c-b105-4ac6-a839-ec43d634a0af	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 05:20:44.103818+00	
00000000-0000-0000-0000-000000000000	1cdb33ae-38a1-4db3-8dac-5c3b590a3003	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 05:20:44.108846+00	
00000000-0000-0000-0000-000000000000	196fc8d2-7a25-464f-8d7c-035f4183f2d7	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 06:20:08.408673+00	
00000000-0000-0000-0000-000000000000	b3317fae-1a55-42af-bf0e-1bf20bb844fa	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 06:20:08.411037+00	
00000000-0000-0000-0000-000000000000	08a16e3a-be5c-4346-9ec5-33c05c8f2eec	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 07:19:39.200617+00	
00000000-0000-0000-0000-000000000000	809826b5-b84c-4268-8ede-936360558c1e	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 07:19:39.207897+00	
00000000-0000-0000-0000-000000000000	5f231c7d-bffb-469e-a388-10bb7fb4af02	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 08:19:01.456324+00	
00000000-0000-0000-0000-000000000000	249b3d41-5cad-4be7-ad4d-d072cb3b0a71	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 08:19:01.46058+00	
00000000-0000-0000-0000-000000000000	b0eb4adb-0146-4cfe-8720-541afcfc55b3	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 09:41:14.578802+00	
00000000-0000-0000-0000-000000000000	3e4b221b-2822-4b12-b73e-1fb7a16b94c6	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 09:41:14.584714+00	
00000000-0000-0000-0000-000000000000	6ca7847f-677c-4bc3-b28f-40bfdaea0cc8	{"action":"token_refreshed","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 10:40:44.590109+00	
00000000-0000-0000-0000-000000000000	ce4e5ecd-cff0-4e32-953a-c68c30289339	{"action":"token_revoked","actor_id":"95645fa0-84c2-492c-972e-e6feab30454e","actor_username":"smotsi@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-04-15 10:40:44.594563+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
f7ca04aa-906e-403c-a742-17151ebfaf1e	f7ca04aa-906e-403c-a742-17151ebfaf1e	{"sub": "f7ca04aa-906e-403c-a742-17151ebfaf1e", "role": "tourist", "email": "test@test.com", "phone": "12345", "last_name": "last", "first_name": "first", "email_verified": false, "phone_verified": false}	email	2025-04-08 06:04:33.349844+00	2025-04-08 06:04:33.349879+00	2025-04-08 06:04:33.349879+00	f025e963-3d44-467e-8957-09af48a04e10
fe6632be-8ed7-4528-9cf2-9ab1ca27707c	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	{"sub": "fe6632be-8ed7-4528-9cf2-9ab1ca27707c", "role": "tourist", "email": "simon@gmail.com", "phone": "987654", "last_name": "moyo", "first_name": "simon", "email_verified": false, "phone_verified": false}	email	2025-04-08 14:08:29.832386+00	2025-04-08 14:08:29.83242+00	2025-04-08 14:08:29.83242+00	66dc69c2-e074-4e18-a3d3-93668eaa3023
f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	{"sub": "f38ce1fd-27f1-4534-92e1-e613d5a9a9ee", "role": "tourist", "email": "ajackson@gmail.com", "phone": "0781996558", "last_name": "Jackson", "first_name": "Andrew", "email_verified": false, "phone_verified": false}	email	2025-04-10 12:12:47.431218+00	2025-04-10 12:12:47.431255+00	2025-04-10 12:12:47.431255+00	47b254be-4829-4b59-9d55-9fb2a04c280c
11e13082-156f-44e3-9bd2-ee64cfd36af3	11e13082-156f-44e3-9bd2-ee64cfd36af3	{"sub": "11e13082-156f-44e3-9bd2-ee64cfd36af3", "role": "tourist", "email": "smahachi@gmail.com", "phone": "123456789", "last_name": "Mahachi", "first_name": "Simbarashe", "email_verified": false, "phone_verified": false}	email	2025-04-10 12:29:41.350067+00	2025-04-10 12:29:41.350112+00	2025-04-10 12:29:41.350112+00	35c3185b-6aaa-415b-82bc-ca4360aae31b
8eeb97b5-f931-4e2b-83de-efddbddf8815	8eeb97b5-f931-4e2b-83de-efddbddf8815	{"sub": "8eeb97b5-f931-4e2b-83de-efddbddf8815", "role": "tourist", "email": "gmadamombe@gmail.com", "phone": "9876543210", "last_name": "Madamombe", "first_name": "Geoffrey", "email_verified": false, "phone_verified": false}	email	2025-04-10 13:27:57.283924+00	2025-04-10 13:27:57.283948+00	2025-04-10 13:27:57.283948+00	e9690f14-34cd-4a14-a666-8135d1d84cc9
95645fa0-84c2-492c-972e-e6feab30454e	95645fa0-84c2-492c-972e-e6feab30454e	{"sub": "95645fa0-84c2-492c-972e-e6feab30454e", "role": "tourist", "email": "smotsi@gmail.com", "phone": "+263782456123", "last_name": "Motsi", "first_name": "Simbarashe", "email_verified": false, "phone_verified": false}	email	2025-04-11 08:07:43.805333+00	2025-04-11 08:07:43.805373+00	2025-04-11 08:07:43.805373+00	b93b434a-a86b-453e-adb7-7587b1c624ec
3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223	3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223	{"sub": "3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223", "role": "tourist", "email": "igreats@gmail.com", "phone": "+263012345678", "last_name": "Greats", "first_name": "Innocent", "email_verified": false, "phone_verified": false}	email	2025-04-14 15:05:07.382599+00	2025-04-14 15:05:07.382664+00	2025-04-14 15:05:07.382664+00	b0056b71-1926-4a9c-a9ef-fdd421a355cf
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
bf636c60-5ad3-448a-8d32-045a6e05914a	2025-04-09 04:49:21.044482+00	2025-04-09 04:49:21.044482+00	password	e049b721-e99c-49ac-aa16-89841e91d881
5ebf5dce-87f3-4ecd-bfed-bcc3e563a836	2025-04-14 15:08:04.577636+00	2025-04-14 15:08:04.577636+00	password	a36c9d74-9bd4-41bb-b40b-ebe3eeeaf036
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	46	Y1ZW_X_yji_OWxT5B7Zh0w	f7ca04aa-906e-403c-a742-17151ebfaf1e	t	2025-04-09 04:49:21.038885+00	2025-04-09 05:58:59.607625+00	\N	bf636c60-5ad3-448a-8d32-045a6e05914a
00000000-0000-0000-0000-000000000000	47	xidihpHeZ2GhI45vSgIzKw	f7ca04aa-906e-403c-a742-17151ebfaf1e	t	2025-04-09 05:58:59.647352+00	2025-04-09 11:05:08.074919+00	Y1ZW_X_yji_OWxT5B7Zh0w	bf636c60-5ad3-448a-8d32-045a6e05914a
00000000-0000-0000-0000-000000000000	48	gD1V86XJPXoPI6YBSdkvJA	f7ca04aa-906e-403c-a742-17151ebfaf1e	t	2025-04-09 11:05:08.08023+00	2025-04-10 04:36:57.493462+00	xidihpHeZ2GhI45vSgIzKw	bf636c60-5ad3-448a-8d32-045a6e05914a
00000000-0000-0000-0000-000000000000	49	TnAMAiEekIfce3RV5apoVA	f7ca04aa-906e-403c-a742-17151ebfaf1e	f	2025-04-10 04:36:57.513667+00	2025-04-10 04:36:57.513667+00	gD1V86XJPXoPI6YBSdkvJA	bf636c60-5ad3-448a-8d32-045a6e05914a
00000000-0000-0000-0000-000000000000	97	axuIcuChuVzehDxM3eQ-dw	95645fa0-84c2-492c-972e-e6feab30454e	t	2025-04-14 15:08:04.576389+00	2025-04-15 04:21:12.163982+00	\N	5ebf5dce-87f3-4ecd-bfed-bcc3e563a836
00000000-0000-0000-0000-000000000000	130	sVYBCnqbvwGCkM2FC1n8fA	95645fa0-84c2-492c-972e-e6feab30454e	t	2025-04-15 04:21:12.164604+00	2025-04-15 05:20:44.109449+00	axuIcuChuVzehDxM3eQ-dw	5ebf5dce-87f3-4ecd-bfed-bcc3e563a836
00000000-0000-0000-0000-000000000000	131	ndinhkMEAP29E_I7hfnP4Q	95645fa0-84c2-492c-972e-e6feab30454e	t	2025-04-15 05:20:44.113017+00	2025-04-15 06:20:08.411539+00	sVYBCnqbvwGCkM2FC1n8fA	5ebf5dce-87f3-4ecd-bfed-bcc3e563a836
00000000-0000-0000-0000-000000000000	132	pYZKJY0zJDhMDgCKpRuy4A	95645fa0-84c2-492c-972e-e6feab30454e	t	2025-04-15 06:20:08.422242+00	2025-04-15 07:19:39.209017+00	ndinhkMEAP29E_I7hfnP4Q	5ebf5dce-87f3-4ecd-bfed-bcc3e563a836
00000000-0000-0000-0000-000000000000	133	_-g5KvNb5Yu08eyozcHgQQ	95645fa0-84c2-492c-972e-e6feab30454e	t	2025-04-15 07:19:39.216234+00	2025-04-15 08:19:01.461892+00	pYZKJY0zJDhMDgCKpRuy4A	5ebf5dce-87f3-4ecd-bfed-bcc3e563a836
00000000-0000-0000-0000-000000000000	134	gDv2lT3p3RaFku50lt-iPg	95645fa0-84c2-492c-972e-e6feab30454e	t	2025-04-15 08:19:01.464613+00	2025-04-15 09:41:14.585572+00	_-g5KvNb5Yu08eyozcHgQQ	5ebf5dce-87f3-4ecd-bfed-bcc3e563a836
00000000-0000-0000-0000-000000000000	135	rgIIMHKkdV4DS3tREtyBvw	95645fa0-84c2-492c-972e-e6feab30454e	t	2025-04-15 09:41:14.590013+00	2025-04-15 10:40:44.595067+00	gDv2lT3p3RaFku50lt-iPg	5ebf5dce-87f3-4ecd-bfed-bcc3e563a836
00000000-0000-0000-0000-000000000000	136	E0RRgK_1hm5O8AQSKALi6A	95645fa0-84c2-492c-972e-e6feab30454e	f	2025-04-15 10:40:44.596624+00	2025-04-15 10:40:44.596624+00	rgIIMHKkdV4DS3tREtyBvw	5ebf5dce-87f3-4ecd-bfed-bcc3e563a836
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
bf636c60-5ad3-448a-8d32-045a6e05914a	f7ca04aa-906e-403c-a742-17151ebfaf1e	2025-04-09 04:49:21.035485+00	2025-04-10 04:36:57.557205+00	\N	aal1	\N	2025-04-10 04:36:57.552724	Dart/3.7 (dart:io)	172.18.0.1	\N
5ebf5dce-87f3-4ecd-bfed-bcc3e563a836	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-14 15:08:04.575293+00	2025-04-15 10:40:44.603795+00	\N	aal1	\N	2025-04-15 10:40:44.603756	Dart/3.7 (dart:io)	172.18.0.1	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	95645fa0-84c2-492c-972e-e6feab30454e	authenticated	authenticated	smotsi@gmail.com	$2a$10$5V./66JUAwGh5lk.WHiYq.QY4y/oxijGCESRWHEXFxYUy65LqzR4O	2025-04-11 08:07:43.812738+00	\N		\N		\N			\N	2025-04-14 15:08:04.575255+00	{"provider": "email", "providers": ["email"]}	{"sub": "95645fa0-84c2-492c-972e-e6feab30454e", "role": "tourist", "email": "smotsi@gmail.com", "phone": "+263782456123", "last_name": "Motsi", "first_name": "Simbarashe", "email_verified": true, "phone_verified": false}	\N	2025-04-11 08:07:43.796324+00	2025-04-15 10:40:44.598591+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	authenticated	authenticated	ajackson@gmail.com	$2a$10$MpgqkcbGM9t/CNGGQcXwnOORmnPnQeaTF0XFU6RzDCYB1YkpAlPyS	2025-04-10 12:12:47.449124+00	\N		\N		\N			\N	2025-04-10 14:39:55.03846+00	{"provider": "email", "providers": ["email"]}	{"sub": "f38ce1fd-27f1-4534-92e1-e613d5a9a9ee", "role": "tourist", "email": "ajackson@gmail.com", "phone": "0781996558", "last_name": "Jackson", "first_name": "Andrew", "email_verified": true, "phone_verified": false}	\N	2025-04-10 12:12:47.404155+00	2025-04-10 14:39:55.041507+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f7ca04aa-906e-403c-a742-17151ebfaf1e	authenticated	authenticated	test@test.com	$2a$10$XaMG85Vqrj4Hn98F.XKlTO2.Dq0fSK3QHd0GGF6HehDWiuCveEpJa	2025-04-08 06:04:33.352138+00	\N		\N		\N			\N	2025-04-09 04:49:21.035399+00	{"provider": "email", "providers": ["email"]}	{"sub": "f7ca04aa-906e-403c-a742-17151ebfaf1e", "role": "tourist", "email": "test@test.com", "phone": "12345", "last_name": "last", "first_name": "first", "email_verified": true, "phone_verified": false}	\N	2025-04-08 06:04:33.348024+00	2025-04-10 04:36:57.524237+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8eeb97b5-f931-4e2b-83de-efddbddf8815	authenticated	authenticated	gmadamombe@gmail.com	$2a$10$wqhu8Qi8npoYYYMnlNkAeeFJcXreoOTjI6Ds7EEg30LaNYm8cZkSq	2025-04-10 13:27:57.287871+00	\N		\N		\N			\N	2025-04-10 13:37:35.484717+00	{"provider": "email", "providers": ["email"]}	{"sub": "8eeb97b5-f931-4e2b-83de-efddbddf8815", "role": "tourist", "email": "gmadamombe@gmail.com", "phone": "9876543210", "last_name": "Madamombe", "first_name": "Geoffrey", "email_verified": true, "phone_verified": false}	\N	2025-04-10 13:27:57.278841+00	2025-04-10 13:37:35.487215+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	11e13082-156f-44e3-9bd2-ee64cfd36af3	authenticated	authenticated	smahachi@gmail.com	$2a$10$53P.xjMJwuH3ixRx68hjcO4azlLAVQivPm.mDq0PPn6PpEKn8QxNK	2025-04-10 12:29:41.353502+00	\N		\N		\N			\N	2025-04-10 13:04:46.518283+00	{"provider": "email", "providers": ["email"]}	{"sub": "11e13082-156f-44e3-9bd2-ee64cfd36af3", "role": "tourist", "email": "smahachi@gmail.com", "phone": "123456789", "last_name": "Mahachi", "first_name": "Simbarashe", "email_verified": true, "phone_verified": false}	\N	2025-04-10 12:29:41.342208+00	2025-04-10 13:04:46.522461+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	authenticated	authenticated	simon@gmail.com	$2a$10$ssds1r8iWwYTHwMDe7p4r.38brMyMFmbHI1QfyocShyG/iN.lZaPm	2025-04-08 14:08:29.835292+00	\N		\N		\N			\N	2025-04-10 13:44:52.662095+00	{"provider": "email", "providers": ["email"]}	{"sub": "fe6632be-8ed7-4528-9cf2-9ab1ca27707c", "role": "tourist", "email": "simon@gmail.com", "phone": "987654", "last_name": "moyo", "first_name": "simon", "email_verified": true, "phone_verified": false}	\N	2025-04-08 14:08:29.82869+00	2025-04-10 13:44:52.66365+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223	authenticated	authenticated	igreats@gmail.com	$2a$10$Oiuc96wrCqgQx0UUjINc.OJX7A1S8k.yQaXVO7oygUKQy5tp0h56C	2025-04-14 15:05:07.388107+00	\N		\N		\N			\N	2025-04-14 15:05:39.615691+00	{"provider": "email", "providers": ["email"]}	{"sub": "3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223", "role": "tourist", "email": "igreats@gmail.com", "phone": "+263012345678", "last_name": "Greats", "first_name": "Innocent", "email_verified": true, "phone_verified": false}	\N	2025-04-14 15:05:07.3504+00	2025-04-14 15:05:39.617175+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: cron; Owner: supabase_admin
--

COPY cron.job (jobid, schedule, command, nodename, nodeport, database, username, active, jobname) FROM stdin;
1	30 20 * * *	SELECT public.clean_expired_itineraries()	localhost	5432	postgres	postgres	t	nightly-itinerary-cleanup
\.


--
-- Data for Name: job_run_details; Type: TABLE DATA; Schema: cron; Owner: supabase_admin
--

COPY cron.job_run_details (jobid, runid, job_pid, database, username, command, status, return_message, start_time, end_time) FROM stdin;
\.


--
-- Data for Name: FlightBooking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FlightBooking" (booking_id, created_at, amadeus_id, queueing_office_id, user_id, itineraries, travelers, price, departure_date) FROM stdin;
b8bbd2c9-e04c-4eb8-94dc-f2bb05d859b0	2025-04-10 04:57:45.349217+00	eJzTd9cPCXIODA8EAAvBAog%3D	NCE4D31SB	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	{"{\\"segments\\": [{\\"id\\": \\"2\\", \\"number\\": \\"722\\", \\"arrival\\": {\\"at\\": \\"2025-04-11T17:40:00\\", \\"iataCode\\": \\"ICN\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"77L\\"}, \\"duration\\": \\"PT3H35M\\", \\"departure\\": {\\"at\\": \\"2025-04-11T13:05:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"OZ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 150, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"3\\", \\"number\\": \\"222\\", \\"arrival\\": {\\"at\\": \\"2025-04-12T11:05:00\\", \\"iataCode\\": \\"JFK\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"359\\"}, \\"duration\\": \\"PT14H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-12T09:50:00\\", \\"iataCode\\": \\"ICN\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"OZ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 499, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"151\\", \\"number\\": \\"221\\", \\"arrival\\": {\\"at\\": \\"2025-04-19T17:40:00\\", \\"iataCode\\": \\"ICN\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"359\\"}, \\"duration\\": \\"PT15H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-18T12:55:00\\", \\"iataCode\\": \\"JFK\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"OZ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 499, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"152\\", \\"number\\": \\"721\\", \\"arrival\\": {\\"at\\": \\"2025-04-20T11:40:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"77L\\"}, \\"duration\\": \\"PT3H40M\\", \\"departure\\": {\\"at\\": \\"2025-04-20T09:00:00\\", \\"iataCode\\": \\"ICN\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"OZ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 150, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"JANE\\", \\"firstName\\": \\"MARY\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"987654\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"maryjane@gmail.com\\"}, \\"dateOfBirth\\": \\"1998-04-10\\"}"}	{"base": "707.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1014.81", "currency": "USD", "grandTotal": "1014.81", "billingCurrency": "USD"}	\N
f8988cd4-ba7a-46f0-a8d9-d4d7ac7b3cf6	2025-04-08 13:16:22.961954+00	eJzTd9cP8Yh08TEFAAuOAmA%3D	NCE4D31SB	f7ca04aa-906e-403c-a742-17151ebfaf1e	{"{\\"segments\\": [{\\"id\\": \\"35\\", \\"number\\": \\"25\\", \\"arrival\\": {\\"at\\": \\"2025-04-09T09:05:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"A\\"}, \\"aircraft\\": {\\"code\\": \\"320\\"}, \\"duration\\": \\"PT1H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-09T07:20:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"SA\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 157, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"36\\", \\"number\\": \\"555\\", \\"arrival\\": {\\"at\\": \\"2025-04-09T14:50:00\\", \\"iataCode\\": \\"DUR\\"}, \\"aircraft\\": {\\"code\\": \\"320\\"}, \\"duration\\": \\"PT1H10M\\", \\"departure\\": {\\"at\\": \\"2025-04-09T13:40:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"SA\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 69, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"70\\", \\"number\\": \\"578\\", \\"arrival\\": {\\"at\\": \\"2025-04-16T19:50:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"aircraft\\": {\\"code\\": \\"320\\"}, \\"duration\\": \\"PT1H10M\\", \\"departure\\": {\\"at\\": \\"2025-04-16T18:40:00\\", \\"iataCode\\": \\"DUR\\"}, \\"carrierCode\\": \\"SA\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 69, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"71\\", \\"number\\": \\"770\\", \\"arrival\\": {\\"at\\": \\"2025-04-17T08:40:00\\", \\"iataCode\\": \\"HRE\\"}, \\"aircraft\\": {\\"code\\": \\"CR1\\"}, \\"duration\\": \\"PT1H40M\\", \\"departure\\": {\\"at\\": \\"2025-04-17T07:00:00\\", \\"iataCode\\": \\"JNB\\"}, \\"carrierCode\\": \\"5Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 159, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"TEST\\", \\"firstName\\": \\"TEST\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"12345\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"test@test.com\\"}, \\"dateOfBirth\\": \\"1983-04-12\\"}"}	\N	\N
8fa2a2f2-fa3a-441f-8f7a-94f6eedb8983	2025-04-10 12:20:33.306752+00	eJzTd9cPCTENCzMBAAuDAmM%3D	NCE4D31SB	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	{"{\\"segments\\": [{\\"id\\": \\"19\\", \\"number\\": \\"305\\", \\"arrival\\": {\\"at\\": \\"2025-04-24T11:10:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"aircraft\\": {\\"code\\": \\"73H\\"}, \\"duration\\": \\"PT5H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T06:55:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 240, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"20\\", \\"number\\": \\"706\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T11:05:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"73H\\"}, \\"duration\\": \\"PT4H40M\\", \\"departure\\": {\\"at\\": \\"2025-04-25T07:25:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 255, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}]}","{\\"segments\\": [{\\"id\\": \\"95\\", \\"number\\": \\"706\\", \\"arrival\\": {\\"at\\": \\"2025-05-08T15:45:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"aircraft\\": {\\"code\\": \\"73H\\"}, \\"duration\\": \\"PT2H50M\\", \\"departure\\": {\\"at\\": \\"2025-05-08T11:55:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 199, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"96\\", \\"number\\": \\"310\\", \\"arrival\\": {\\"at\\": \\"2025-05-08T23:25:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"788\\"}, \\"duration\\": \\"PT5H15M\\", \\"departure\\": {\\"at\\": \\"2025-05-08T17:10:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 240, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"JACKSON\\", \\"firstName\\": \\"CHRIS\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"987654321\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"cjackson@gmail.com\\"}, \\"dateOfBirth\\": \\"2000-03-08\\"}"}	{"base": "201.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "573.90", "currency": "USD", "grandTotal": "573.90", "billingCurrency": "USD"}	\N
4c4d6fc9-acce-4090-931d-1dc345c6ac88	2025-04-10 12:15:21.910634+00	eJzTd9cPCTEO9gsAAAt%2BAnI%3D	NCE4D31SB	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	{"{\\"segments\\": [{\\"id\\": \\"38\\", \\"number\\": \\"113\\", \\"arrival\\": {\\"at\\": \\"2025-04-17T20:20:00\\", \\"iataCode\\": \\"KGL\\"}, \\"aircraft\\": {\\"code\\": \\"CRJ\\"}, \\"duration\\": \\"PT2H40M\\", \\"departure\\": {\\"at\\": \\"2025-04-17T17:40:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"WB\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 151, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"39\\", \\"number\\": \\"304\\", \\"arrival\\": {\\"at\\": \\"2025-04-18T08:30:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"2\\"}, \\"aircraft\\": {\\"code\\": \\"738\\"}, \\"duration\\": \\"PT6H\\", \\"departure\\": {\\"at\\": \\"2025-04-18T00:30:00\\", \\"iataCode\\": \\"KGL\\"}, \\"carrierCode\\": \\"WB\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 277, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"64\\", \\"number\\": \\"305\\", \\"arrival\\": {\\"at\\": \\"2025-04-24T05:50:00\\", \\"iataCode\\": \\"KGL\\"}, \\"aircraft\\": {\\"code\\": \\"738\\"}, \\"duration\\": \\"PT6H\\", \\"departure\\": {\\"at\\": \\"2025-04-24T01:50:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"2\\"}, \\"carrierCode\\": \\"WB\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 277, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"65\\", \\"number\\": \\"112\\", \\"arrival\\": {\\"at\\": \\"2025-04-24T13:10:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"CRJ\\"}, \\"duration\\": \\"PT2H40M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T10:30:00\\", \\"iataCode\\": \\"KGL\\"}, \\"carrierCode\\": \\"WB\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 151, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"JACKSON\\", \\"firstName\\": \\"AMANDA\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0719663225\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"ajax@gmail.com\\"}, \\"dateOfBirth\\": \\"1999-06-15\\"}"}	{"base": "208.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "652.90", "currency": "USD", "grandTotal": "652.90", "billingCurrency": "USD"}	\N
e4ff1d6a-d89d-493b-87de-b87ecc4f0ce4	2025-04-10 11:03:43.455198+00	eJzTd9cPCQ6KcHICAAveAns%3D	NCE4D31SB	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	{"{\\"segments\\": [{\\"id\\": \\"4\\", \\"number\\": \\"921\\", \\"arrival\\": {\\"at\\": \\"2025-04-24T09:45:00\\", \\"iataCode\\": \\"CPT\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT2H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T07:30:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"4Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 144, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"5\\", \\"number\\": \\"904\\", \\"arrival\\": {\\"at\\": \\"2025-04-24T13:35:00\\", \\"iataCode\\": \\"DUR\\"}, \\"aircraft\\": {\\"code\\": \\"CR1\\"}, \\"duration\\": \\"PT2H\\", \\"departure\\": {\\"at\\": \\"2025-04-24T11:35:00\\", \\"iataCode\\": \\"CPT\\"}, \\"carrierCode\\": \\"5Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 154, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"TEST\\", \\"firstName\\": \\"TEST\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"654321\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"test@test.com\\"}, \\"dateOfBirth\\": \\"1980-04-01\\"}"}	{"base": "93.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "175.20", "currency": "USD", "grandTotal": "175.20", "billingCurrency": "USD"}	\N
4c592f96-d9d5-4414-9e7c-3d7e50dc3083	2025-04-10 13:43:04.956787+00	eJzTd9cPCXEPMPEFAAuOAmY%3D	NCE4D31SB	8eeb97b5-f931-4e2b-83de-efddbddf8815	{"{\\"segments\\": [{\\"id\\": \\"7\\", \\"number\\": \\"23\\", \\"arrival\\": {\\"at\\": \\"2025-06-11T14:15:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"A\\"}, \\"aircraft\\": {\\"code\\": \\"320\\"}, \\"duration\\": \\"PT1H45M\\", \\"departure\\": {\\"at\\": \\"2025-06-11T12:30:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"SA\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 157, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"8\\", \\"number\\": \\"581\\", \\"arrival\\": {\\"at\\": \\"2025-06-11T21:45:00\\", \\"iataCode\\": \\"DUR\\"}, \\"aircraft\\": {\\"code\\": \\"320\\"}, \\"duration\\": \\"PT1H10M\\", \\"departure\\": {\\"at\\": \\"2025-06-11T20:35:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"SA\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 69, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"85\\", \\"number\\": \\"534\\", \\"arrival\\": {\\"at\\": \\"2025-06-18T09:20:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"aircraft\\": {\\"code\\": \\"320\\"}, \\"duration\\": \\"PT1H10M\\", \\"departure\\": {\\"at\\": \\"2025-06-18T08:10:00\\", \\"iataCode\\": \\"DUR\\"}, \\"carrierCode\\": \\"SA\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 69, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"86\\", \\"number\\": \\"24\\", \\"arrival\\": {\\"at\\": \\"2025-06-18T21:50:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"320\\"}, \\"duration\\": \\"PT1H40M\\", \\"departure\\": {\\"at\\": \\"2025-06-18T20:10:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"SA\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 159, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"MALOPE\\", \\"firstName\\": \\"LESEGO\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"123456789\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"lmalope@gmail.com\\"}, \\"dateOfBirth\\": \\"2002-08-15\\"}"}	{"base": "88.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "348.90", "currency": "USD", "grandTotal": "348.90", "billingCurrency": "USD"}	\N
b8b19f4f-48fa-4a61-b83f-02a785bdc38c	2025-04-10 13:34:32.549637+00	eJzTd9cPCXH1c3EEAAuUAmY%3D	NCE4D31SB	8eeb97b5-f931-4e2b-83de-efddbddf8815	{"{\\"segments\\": [{\\"id\\": \\"72\\", \\"number\\": \\"4199\\", \\"arrival\\": {\\"at\\": \\"2025-04-24T21:55:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT4H35M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T16:20:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"operating\\": {\\"carrierCode\\": \\"KQ\\"}, \\"carrierCode\\": \\"KL\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 257, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}, {\\"id\\": \\"73\\", \\"number\\": \\"566\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T07:55:00\\", \\"iataCode\\": \\"AMS\\"}, \\"aircraft\\": {\\"code\\": \\"781\\"}, \\"duration\\": \\"PT8H56M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T23:59:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"carrierCode\\": \\"KL\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 358, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"74\\", \\"number\\": \\"2007\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T11:55:00\\", \\"iataCode\\": \\"CDG\\", \\"terminal\\": \\"2F\\"}, \\"aircraft\\": {\\"code\\": \\"32A\\"}, \\"duration\\": \\"PT1H20M\\", \\"departure\\": {\\"at\\": \\"2025-04-25T10:35:00\\", \\"iataCode\\": \\"AMS\\"}, \\"operating\\": {\\"carrierCode\\": \\"AF\\"}, \\"carrierCode\\": \\"KL\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 51, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"119\\", \\"number\\": \\"990\\", \\"arrival\\": {\\"at\\": \\"2025-05-03T08:30:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"A\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT11H15M\\", \\"departure\\": {\\"at\\": \\"2025-05-02T21:15:00\\", \\"iataCode\\": \\"CDG\\", \\"terminal\\": \\"2E\\"}, \\"carrierCode\\": \\"AF\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 507, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"120\\", \\"number\\": \\"22\\", \\"arrival\\": {\\"at\\": \\"2025-05-03T11:40:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"320\\"}, \\"duration\\": \\"PT1H40M\\", \\"departure\\": {\\"at\\": \\"2025-05-03T10:00:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"SA\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 159, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"LAST\\", \\"firstName\\": \\"FIRST\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"123456789\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"fl@gmail.com\\"}, \\"dateOfBirth\\": \\"2004-04-10\\"}"}	{"base": "1074.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1747.70", "currency": "USD", "grandTotal": "1747.70", "billingCurrency": "USD"}	\N
4435fc32-a22f-4e18-890b-384792d787c2	2025-04-10 13:06:56.62723+00	eJzTd9cPCXHydHEDAAt%2BAmM%3D	NCE4D31SB	11e13082-156f-44e3-9bd2-ee64cfd36af3	{"{\\"segments\\": [{\\"id\\": \\"17\\", \\"number\\": \\"4190\\", \\"arrival\\": {\\"at\\": \\"2025-04-18T20:25:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"A\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT1H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-18T18:40:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"operating\\": {\\"carrierCode\\": \\"4Z\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 157, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"18\\", \\"number\\": \\"766\\", \\"arrival\\": {\\"at\\": \\"2025-04-19T08:20:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT8H\\", \\"departure\\": {\\"at\\": \\"2025-04-18T22:20:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 419, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"19\\", \\"number\\": \\"380\\", \\"arrival\\": {\\"at\\": \\"2025-04-19T21:15:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"388\\"}, \\"duration\\": \\"PT7H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-19T10:00:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 350, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"113\\", \\"number\\": \\"383\\", \\"arrival\\": {\\"at\\": \\"2025-04-22T23:10:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT8H55M\\", \\"departure\\": {\\"at\\": \\"2025-04-22T18:15:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 350, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"114\\", \\"number\\": \\"761\\", \\"arrival\\": {\\"at\\": \\"2025-04-23T10:15:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"A\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT8H10M\\", \\"departure\\": {\\"at\\": \\"2025-04-23T04:05:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 419, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"115\\", \\"number\\": \\"4141\\", \\"arrival\\": {\\"at\\": \\"2025-04-23T17:55:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT1H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-23T16:10:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"operating\\": {\\"carrierCode\\": \\"4Z\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 159, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"MAHACHI\\", \\"firstName\\": \\"VIMBAI\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"987654321\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"vmamachi@gmail.com\\"}, \\"dateOfBirth\\": \\"1993-06-15\\"}"}	{"base": "863.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1376.00", "currency": "USD", "grandTotal": "1376.00", "billingCurrency": "USD"}	\N
d6198180-27c7-4fb5-b9d1-f5e614f09448	2025-04-11 13:11:25.765116+00	eJzTd9cPiYwKCAoAAAwyAp8%3D	NCE4D31SB	95645fa0-84c2-492c-972e-e6feab30454e	{"{\\"segments\\": [{\\"id\\": \\"35\\", \\"number\\": \\"5577\\", \\"arrival\\": {\\"at\\": \\"2025-04-18T22:45:00\\", \\"iataCode\\": \\"DOH\\"}, \\"aircraft\\": {\\"code\\": \\"789\\"}, \\"duration\\": \\"PT9H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-18T18:30:00\\", \\"iataCode\\": \\"PKX\\"}, \\"operating\\": {\\"carrierCode\\": \\"MF\\"}, \\"carrierCode\\": \\"QR\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 332, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"36\\", \\"number\\": \\"1002\\", \\"arrival\\": {\\"at\\": \\"2025-04-19T03:25:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"359\\"}, \\"duration\\": \\"PT1H20M\\", \\"departure\\": {\\"at\\": \\"2025-04-19T01:05:00\\", \\"iataCode\\": \\"DOH\\"}, \\"carrierCode\\": \\"QR\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 32, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"63\\", \\"number\\": \\"1019\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T23:40:00\\", \\"iataCode\\": \\"DOH\\"}, \\"aircraft\\": {\\"code\\": \\"359\\"}, \\"duration\\": \\"PT1H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-25T23:25:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"QR\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 32, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"64\\", \\"number\\": \\"892\\", \\"arrival\\": {\\"at\\": \\"2025-04-26T15:00:00\\", \\"iataCode\\": \\"PKX\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT7H50M\\", \\"departure\\": {\\"at\\": \\"2025-04-26T02:10:00\\", \\"iataCode\\": \\"DOH\\"}, \\"carrierCode\\": \\"QR\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 337, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"BANKS\\", \\"firstName\\": \\"ASHLEY\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"1\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"abanks@gmail.com\\"}, \\"dateOfBirth\\": \\"2013-02-14\\"}"}	{"base": "550.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1053.70", "currency": "USD", "grandTotal": "1053.70", "billingCurrency": "USD"}	\N
c232a699-1158-4c50-a961-6ca61add7f6a	2025-04-11 13:02:36.406077+00	eJzTd9cPiYxycgsFAAv1Aoo%3D	NCE4D31SB	95645fa0-84c2-492c-972e-e6feab30454e	{"{\\"segments\\": [{\\"id\\": \\"35\\", \\"number\\": \\"5577\\", \\"arrival\\": {\\"at\\": \\"2025-04-18T22:45:00\\", \\"iataCode\\": \\"DOH\\"}, \\"aircraft\\": {\\"code\\": \\"789\\"}, \\"duration\\": \\"PT9H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-18T18:30:00\\", \\"iataCode\\": \\"PKX\\"}, \\"operating\\": {\\"carrierCode\\": \\"MF\\"}, \\"carrierCode\\": \\"QR\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 332, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"36\\", \\"number\\": \\"1002\\", \\"arrival\\": {\\"at\\": \\"2025-04-19T03:25:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"359\\"}, \\"duration\\": \\"PT1H20M\\", \\"departure\\": {\\"at\\": \\"2025-04-19T01:05:00\\", \\"iataCode\\": \\"DOH\\"}, \\"carrierCode\\": \\"QR\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 32, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"63\\", \\"number\\": \\"1019\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T23:40:00\\", \\"iataCode\\": \\"DOH\\"}, \\"aircraft\\": {\\"code\\": \\"359\\"}, \\"duration\\": \\"PT1H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-25T23:25:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"QR\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 32, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"64\\", \\"number\\": \\"892\\", \\"arrival\\": {\\"at\\": \\"2025-04-26T15:00:00\\", \\"iataCode\\": \\"PKX\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT7H50M\\", \\"departure\\": {\\"at\\": \\"2025-04-26T02:10:00\\", \\"iataCode\\": \\"DOH\\"}, \\"carrierCode\\": \\"QR\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 337, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"CAPE\\", \\"firstName\\": \\"ASHLEY\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"acape@gmail.com\\"}, \\"dateOfBirth\\": \\"1980-04-25\\"}"}	{"base": "550.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1053.70", "currency": "USD", "grandTotal": "1053.70", "billingCurrency": "USD"}	\N
e1057f52-8dcc-4855-8f1e-025002b43892	2025-04-10 14:41:49.156789+00	eJzTd9cPCfF3DA0CAAvIAoU%3D	NCE4D31SB	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	{"{\\"segments\\": [{\\"id\\": \\"13\\", \\"number\\": \\"704\\", \\"arrival\\": {\\"at\\": \\"2025-06-10T21:55:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"aircraft\\": {\\"code\\": \\"73H\\"}, \\"duration\\": \\"PT4H35M\\", \\"departure\\": {\\"at\\": \\"2025-06-10T16:20:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 257, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}, {\\"id\\": \\"14\\", \\"number\\": \\"116\\", \\"arrival\\": {\\"at\\": \\"2025-06-11T16:40:00\\", \\"iataCode\\": \\"AMS\\"}, \\"aircraft\\": {\\"code\\": \\"788\\"}, \\"duration\\": \\"PT9H\\", \\"departure\\": {\\"at\\": \\"2025-06-11T08:40:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 358, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"15\\", \\"number\\": \\"1015\\", \\"arrival\\": {\\"at\\": \\"2025-06-11T19:25:00\\", \\"iataCode\\": \\"LHR\\", \\"terminal\\": \\"4\\"}, \\"aircraft\\": {\\"code\\": \\"295\\"}, \\"duration\\": \\"PT1H20M\\", \\"departure\\": {\\"at\\": \\"2025-06-11T19:05:00\\", \\"iataCode\\": \\"AMS\\"}, \\"operating\\": {\\"carrierCode\\": \\"KL\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 51, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"199\\", \\"number\\": \\"1012\\", \\"arrival\\": {\\"at\\": \\"2025-06-17T19:30:00\\", \\"iataCode\\": \\"AMS\\"}, \\"aircraft\\": {\\"code\\": \\"295\\"}, \\"duration\\": \\"PT1H20M\\", \\"departure\\": {\\"at\\": \\"2025-06-17T17:10:00\\", \\"iataCode\\": \\"LHR\\", \\"terminal\\": \\"4\\"}, \\"operating\\": {\\"carrierCode\\": \\"KL\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 51, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"200\\", \\"number\\": \\"117\\", \\"arrival\\": {\\"at\\": \\"2025-06-18T06:10:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"aircraft\\": {\\"code\\": \\"788\\"}, \\"duration\\": \\"PT8H35M\\", \\"departure\\": {\\"at\\": \\"2025-06-17T20:35:00\\", \\"iataCode\\": \\"AMS\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 358, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"201\\", \\"number\\": \\"706\\", \\"arrival\\": {\\"at\\": \\"2025-06-18T11:05:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"73H\\"}, \\"duration\\": \\"PT4H40M\\", \\"departure\\": {\\"at\\": \\"2025-06-18T07:25:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 255, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"DUMBA\\", \\"firstName\\": \\"GREG\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"987654321\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"gdumba@gmail.com\\"}, \\"dateOfBirth\\": \\"1995-04-01\\"}"}	{"base": "458.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1058.10", "currency": "USD", "grandTotal": "1058.10", "billingCurrency": "USD"}	\N
ba85de70-5a41-48b0-8293-93da8f1a9d0f	2025-04-10 14:39:24.034974+00	eJzTd9cPCfHzcPEAAAutAnA%3D	NCE4D31SB	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	{"{\\"segments\\": [{\\"id\\": \\"92\\", \\"number\\": \\"704\\", \\"arrival\\": {\\"at\\": \\"2025-06-10T21:55:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"aircraft\\": {\\"code\\": \\"73H\\"}, \\"duration\\": \\"PT4H35M\\", \\"departure\\": {\\"at\\": \\"2025-06-10T16:20:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 257, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}, {\\"id\\": \\"93\\", \\"number\\": \\"100\\", \\"arrival\\": {\\"at\\": \\"2025-06-11T16:15:00\\", \\"iataCode\\": \\"LHR\\", \\"terminal\\": \\"4\\"}, \\"aircraft\\": {\\"code\\": \\"788\\"}, \\"duration\\": \\"PT9H10M\\", \\"departure\\": {\\"at\\": \\"2025-06-11T09:05:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 383, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"171\\", \\"number\\": \\"101\\", \\"arrival\\": {\\"at\\": \\"2025-06-18T05:00:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"aircraft\\": {\\"code\\": \\"788\\"}, \\"duration\\": \\"PT8H35M\\", \\"departure\\": {\\"at\\": \\"2025-06-17T18:25:00\\", \\"iataCode\\": \\"LHR\\", \\"terminal\\": \\"4\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 383, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"172\\", \\"number\\": \\"706\\", \\"arrival\\": {\\"at\\": \\"2025-06-18T11:05:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"73H\\"}, \\"duration\\": \\"PT4H40M\\", \\"departure\\": {\\"at\\": \\"2025-06-18T07:25:00\\", \\"iataCode\\": \\"NBO\\", \\"terminal\\": \\"1A\\"}, \\"carrierCode\\": \\"KQ\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 255, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"GUCHU\\", \\"firstName\\": \\"WESLEY\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"987654321\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"wguchu@gmail.com\\"}, \\"dateOfBirth\\": \\"2005-01-12\\"}"}	{"base": "458.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1013.80", "currency": "USD", "grandTotal": "1013.80", "billingCurrency": "USD"}	\N
89ca827e-ac61-4e8b-95d5-cb35a90dd085	2025-04-10 13:24:57.529358+00	eJzTd9cPCXFxDncHAAubAnM%3D	NCE4D31SB	11e13082-156f-44e3-9bd2-ee64cfd36af3	{"{\\"segments\\": [{\\"id\\": \\"21\\", \\"number\\": \\"8483\\", \\"arrival\\": {\\"at\\": \\"2025-04-24T14:06:00\\", \\"iataCode\\": \\"YYZ\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"CR9\\"}, \\"duration\\": \\"PT2H51M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T12:15:00\\", \\"iataCode\\": \\"YQY\\"}, \\"carrierCode\\": \\"AC\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 186, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"22\\", \\"number\\": \\"7962\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T13:42:00\\", \\"iataCode\\": \\"YUL\\"}, \\"aircraft\\": {\\"code\\": \\"DH4\\"}, \\"duration\\": \\"PT1H17M\\", \\"departure\\": {\\"at\\": \\"2025-04-25T12:25:00\\", \\"iataCode\\": \\"YTZ\\"}, \\"carrierCode\\": \\"AC\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 66, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"23\\", \\"number\\": \\"8898\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T21:47:00\\", \\"iataCode\\": \\"JFK\\", \\"terminal\\": \\"7\\"}, \\"aircraft\\": {\\"code\\": \\"E75\\"}, \\"duration\\": \\"PT1H47M\\", \\"departure\\": {\\"at\\": \\"2025-04-25T20:00:00\\", \\"iataCode\\": \\"YUL\\"}, \\"carrierCode\\": \\"AC\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 97, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"LAST\\", \\"firstName\\": \\"FIRST\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"321654\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"fl@gmail.com\\"}, \\"dateOfBirth\\": \\"1977-04-12\\"}"}	{"base": "371.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "526.31", "currency": "USD", "grandTotal": "526.31", "billingCurrency": "USD"}	\N
23e37f15-6d0e-4160-a688-ff466c3f3b9b	2025-04-10 12:27:07.047221+00	eJzTd9cPCTH18nIFAAtYAlw%3D	NCE4D31SB	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	{"{\\"segments\\": [{\\"id\\": \\"12\\", \\"number\\": \\"385\\", \\"arrival\\": {\\"at\\": \\"2025-04-17T23:45:00\\", \\"iataCode\\": \\"BKK\\"}, \\"aircraft\\": {\\"code\\": \\"388\\"}, \\"duration\\": \\"PT3H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-17T21:30:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 127, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"13\\", \\"number\\": \\"377\\", \\"arrival\\": {\\"at\\": \\"2025-04-18T06:00:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"aircraft\\": {\\"code\\": \\"388\\"}, \\"duration\\": \\"PT6H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-18T02:15:00\\", \\"iataCode\\": \\"BKK\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 317, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"14\\", \\"number\\": \\"713\\", \\"arrival\\": {\\"at\\": \\"2025-04-18T17:10:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT9H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-18T09:25:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 416, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}]}","{\\"segments\\": [{\\"id\\": \\"36\\", \\"number\\": \\"714\\", \\"arrival\\": {\\"at\\": \\"2025-04-23T06:30:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT9H40M\\", \\"departure\\": {\\"at\\": \\"2025-04-22T18:50:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 412, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}, {\\"id\\": \\"37\\", \\"number\\": \\"380\\", \\"arrival\\": {\\"at\\": \\"2025-04-23T21:15:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"388\\"}, \\"duration\\": \\"PT7H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-23T10:00:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 350, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"JACKSON\\", \\"firstName\\": \\"VANNESSA\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"123456789\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"vjackson@gmail.com\\"}, \\"dateOfBirth\\": \\"2013-07-10\\"}"}	{"base": "917.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1388.60", "currency": "USD", "grandTotal": "1388.60", "billingCurrency": "USD"}	\N
2beeb4ee-06cd-4598-be38-ef4c2b721a5f	2025-04-10 11:38:55.278186+00	eJzTd9cPCY5wNfMFAAuwAm0%3D	NCE4D31SB	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	{"{\\"segments\\": [{\\"id\\": \\"28\\", \\"number\\": \\"714\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T06:30:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT9H40M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T18:50:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 412, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}, {\\"id\\": \\"29\\", \\"number\\": \\"380\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T21:15:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"388\\"}, \\"duration\\": \\"PT7H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-25T10:00:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 350, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"129\\", \\"number\\": \\"385\\", \\"arrival\\": {\\"at\\": \\"2025-04-30T23:45:00\\", \\"iataCode\\": \\"BKK\\"}, \\"aircraft\\": {\\"code\\": \\"388\\"}, \\"duration\\": \\"PT3H15M\\", \\"departure\\": {\\"at\\": \\"2025-04-30T21:30:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 127, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"130\\", \\"number\\": \\"371\\", \\"arrival\\": {\\"at\\": \\"2025-05-01T06:50:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT6H35M\\", \\"departure\\": {\\"at\\": \\"2025-05-01T03:15:00\\", \\"iataCode\\": \\"BKK\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 317, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"131\\", \\"number\\": \\"713\\", \\"arrival\\": {\\"at\\": \\"2025-05-01T17:10:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT9H45M\\", \\"departure\\": {\\"at\\": \\"2025-05-01T09:25:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"3\\"}, \\"carrierCode\\": \\"EK\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 416, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"TEST\\", \\"firstName\\": \\"TESTONE\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"987654\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"testone@test.com\\"}, \\"dateOfBirth\\": \\"1998-04-14\\"}","{\\"id\\": \\"2\\", \\"name\\": {\\"lastName\\": \\"TEST\\", \\"firstName\\": \\"TESTTWO\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"321654\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"testtwo@test.com\\"}, \\"dateOfBirth\\": \\"1996-04-10\\"}","{\\"id\\": \\"3\\", \\"name\\": {\\"lastName\\": \\"TEST\\", \\"firstName\\": \\"TESTTHREE\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0123\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"testthree@test.com\\"}, \\"dateOfBirth\\": \\"1998-05-14\\"}"}	{"base": "2826.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "4224.60", "currency": "USD", "grandTotal": "4224.60", "billingCurrency": "USD"}	\N
f7559b22-6963-4607-9e40-b1f326b6a2ee	2025-04-10 08:27:30.766774+00	eJzTd9cPCbZwMXYHAAshAkM%3D	NCE4D31SB	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	{"{\\"segments\\": [{\\"id\\": \\"1\\", \\"number\\": \\"872\\", \\"arrival\\": {\\"at\\": \\"2025-04-24T20:15:00\\", \\"iataCode\\": \\"ADD\\", \\"terminal\\": \\"2\\"}, \\"aircraft\\": {\\"code\\": \\"350\\"}, \\"duration\\": \\"PT4H10M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T15:05:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"ET\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 211, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"2\\", \\"number\\": \\"612\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T04:10:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"77L\\"}, \\"duration\\": \\"PT4H20M\\", \\"departure\\": {\\"at\\": \\"2025-04-24T22:50:00\\", \\"iataCode\\": \\"ADD\\", \\"terminal\\": \\"2\\"}, \\"carrierCode\\": \\"ET\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 186, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"70\\", \\"number\\": \\"603\\", \\"arrival\\": {\\"at\\": \\"2025-04-29T20:35:00\\", \\"iataCode\\": \\"ADD\\", \\"terminal\\": \\"2\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT4H25M\\", \\"departure\\": {\\"at\\": \\"2025-04-29T17:10:00\\", \\"iataCode\\": \\"DXB\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"ET\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 186, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"71\\", \\"number\\": \\"893\\", \\"arrival\\": {\\"at\\": \\"2025-04-30T01:30:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"73W\\"}, \\"duration\\": \\"PT4H30M\\", \\"departure\\": {\\"at\\": \\"2025-04-29T22:00:00\\", \\"iataCode\\": \\"ADD\\", \\"terminal\\": \\"2\\"}, \\"carrierCode\\": \\"ET\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 211, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"ABDULLAH\\", \\"firstName\\": \\"KABUL\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0123\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"263\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"kabdullah@test.com\\"}, \\"dateOfBirth\\": \\"1980-04-09\\"}"}	{"base": "276.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "636.90", "currency": "USD", "grandTotal": "636.90", "billingCurrency": "USD"}	\N
92bf5b9c-19d8-4559-80cd-eb09bc930264	2025-04-11 13:42:11.22627+00	eJzTd9cPiTILNPMHAAtxAmA%3D	NCE4D31SB	95645fa0-84c2-492c-972e-e6feab30454e	{"{\\"segments\\": [{\\"id\\": \\"148\\", \\"number\\": \\"1351\\", \\"arrival\\": {\\"at\\": \\"2025-04-17T10:45:00\\", \\"iataCode\\": \\"LIS\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"32Q\\"}, \\"duration\\": \\"PT2H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-17T08:00:00\\", \\"iataCode\\": \\"LHR\\", \\"terminal\\": \\"2\\"}, \\"carrierCode\\": \\"TP\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 113, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"149\\", \\"number\\": \\"201\\", \\"arrival\\": {\\"at\\": \\"2025-04-17T15:20:00\\", \\"iataCode\\": \\"EWR\\", \\"terminal\\": \\"B\\"}, \\"aircraft\\": {\\"code\\": \\"32Q\\"}, \\"duration\\": \\"PT8H5M\\", \\"departure\\": {\\"at\\": \\"2025-04-17T12:15:00\\", \\"iataCode\\": \\"LIS\\", \\"terminal\\": \\"1\\"}, \\"carrierCode\\": \\"TP\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 252, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"150\\", \\"number\\": \\"8520\\", \\"arrival\\": {\\"at\\": \\"2025-04-17T23:44:00\\", \\"iataCode\\": \\"ATL\\", \\"terminal\\": \\"N\\"}, \\"aircraft\\": {\\"code\\": \\"739\\"}, \\"duration\\": \\"PT2H34M\\", \\"departure\\": {\\"at\\": \\"2025-04-17T21:10:00\\", \\"iataCode\\": \\"EWR\\", \\"terminal\\": \\"A\\"}, \\"operating\\": {\\"carrierCode\\": \\"UA\\"}, \\"carrierCode\\": \\"TP\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 120, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"LAST\\", \\"firstName\\": \\"FIRST\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"1\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"firstlast@gmail.com\\"}, \\"dateOfBirth\\": \\"1986-07-10\\"}"}	{"base": "770.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1089.21", "currency": "USD", "grandTotal": "1089.21", "billingCurrency": "USD"}	\N
08abc820-4888-4178-b950-17b524b0fb57	2025-04-11 14:07:14.945564+00	eJzTd9cPibKM8vEDAAvDAoE%3D	NCE4D31SB	95645fa0-84c2-492c-972e-e6feab30454e	{"{\\"segments\\": [{\\"id\\": \\"33\\", \\"number\\": \\"109\\", \\"arrival\\": {\\"at\\": \\"2025-04-22T08:55:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"A\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT1H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-22T07:10:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"4Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 157, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"123\\", \\"number\\": \\"104\\", \\"arrival\\": {\\"at\\": \\"2025-04-28T12:40:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT1H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-28T10:55:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"4Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 159, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"LAST\\", \\"firstName\\": \\"FIRST\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"27\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"flast@gmail.com\\"}, \\"dateOfBirth\\": \\"2010-04-01\\"}"}	{"base": "70.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "275.70", "currency": "USD", "grandTotal": "275.70", "billingCurrency": "USD"}	2025-04-22
b5003ac1-8c82-42bf-8e01-faea5217b037	2025-04-11 14:28:05.815138+00	eJzTd9cPiXIxC%2FACAAuHAmg%3D	NCE4D31SB	95645fa0-84c2-492c-972e-e6feab30454e	{"{\\"segments\\": [{\\"id\\": \\"74\\", \\"number\\": \\"9370\\", \\"arrival\\": {\\"at\\": \\"2025-04-25T23:35:00\\", \\"iataCode\\": \\"DOH\\"}, \\"aircraft\\": {\\"code\\": \\"788\\"}, \\"duration\\": \\"PT10H\\", \\"departure\\": {\\"at\\": \\"2025-04-25T12:35:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"operating\\": {\\"carrierCode\\": \\"QR\\"}, \\"carrierCode\\": \\"CX\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 370, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 1}, {\\"id\\": \\"75\\", \\"number\\": \\"9202\\", \\"arrival\\": {\\"at\\": \\"2025-04-26T15:10:00\\", \\"iataCode\\": \\"HKG\\", \\"terminal\\": \\"1\\"}, \\"aircraft\\": {\\"code\\": \\"77W\\"}, \\"duration\\": \\"PT8H25M\\", \\"departure\\": {\\"at\\": \\"2025-04-26T01:45:00\\", \\"iataCode\\": \\"DOH\\"}, \\"operating\\": {\\"carrierCode\\": \\"QR\\"}, \\"carrierCode\\": \\"CX\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 369, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"LAST\\", \\"firstName\\": \\"FIRST\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"27\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"flast@gmail.com\\"}, \\"dateOfBirth\\": \\"1991-07-24\\"}"}	{"base": "4700.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "4901.20", "currency": "USD", "grandTotal": "4901.20", "billingCurrency": "USD"}	2025-04-25
c9798945-e21f-4e4c-ac52-4d406fc4633c	2025-04-14 08:20:17.028799+00	eJzTd9cPdQ8J8ggGAAu7AoM%3D	NCE4D31SB	95645fa0-84c2-492c-972e-e6feab30454e	{"{\\"segments\\": [{\\"id\\": \\"6\\", \\"number\\": \\"107\\", \\"arrival\\": {\\"at\\": \\"2025-04-21T18:50:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"A\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT1H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-21T17:05:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"carrierCode\\": \\"4Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 157, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"7\\", \\"number\\": \\"276\\", \\"arrival\\": {\\"at\\": \\"2025-04-22T09:15:00\\", \\"iataCode\\": \\"MPM\\", \\"terminal\\": \\"B\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT1H10M\\", \\"departure\\": {\\"at\\": \\"2025-04-22T08:05:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"4Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 77, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}","{\\"segments\\": [{\\"id\\": \\"61\\", \\"number\\": \\"273\\", \\"arrival\\": {\\"at\\": \\"2025-04-28T16:50:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"A\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT1H5M\\", \\"departure\\": {\\"at\\": \\"2025-04-28T15:45:00\\", \\"iataCode\\": \\"MPM\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"4Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 76, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}, {\\"id\\": \\"62\\", \\"number\\": \\"100\\", \\"arrival\\": {\\"at\\": \\"2025-04-29T08:05:00\\", \\"iataCode\\": \\"HRE\\", \\"terminal\\": \\"I\\"}, \\"aircraft\\": {\\"code\\": \\"E90\\"}, \\"duration\\": \\"PT1H45M\\", \\"departure\\": {\\"at\\": \\"2025-04-29T06:20:00\\", \\"iataCode\\": \\"JNB\\", \\"terminal\\": \\"B\\"}, \\"carrierCode\\": \\"4Z\\", \\"co2Emissions\\": [{\\"cabin\\": \\"ECONOMY\\", \\"weight\\": 159, \\"weightUnit\\": \\"KG\\"}], \\"numberOfStops\\": 0}]}"}	{"{\\"id\\": \\"1\\", \\"name\\": {\\"lastName\\": \\"LASTONE\\", \\"firstName\\": \\"FIRSTONE\\"}, \\"gender\\": \\"MALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"012345678\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"258\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"firstone@gmail.com\\"}, \\"dateOfBirth\\": \\"1992-04-15\\"}","{\\"id\\": \\"2\\", \\"name\\": {\\"lastName\\": \\"LASTTWO\\", \\"firstName\\": \\"FIRSTTWO\\"}, \\"gender\\": \\"FEMALE\\", \\"contact\\": {\\"phones\\": [{\\"number\\": \\"0987654321\\", \\"deviceType\\": \\"MOBILE\\", \\"countryCallingCode\\": \\"258\\"}], \\"purpose\\": \\"STANDARD\\", \\"emailAddress\\": \\"firsttwo@gmail.com\\"}, \\"dateOfBirth\\": \\"2002-04-11\\"}"}	{"base": "282.00", "fees": [{"type": "TICKETING", "amount": "0.00"}, {"type": "SUPPLIER", "amount": "0.00"}, {"type": "FORM_OF_PAYMENT", "amount": "0.00"}], "total": "1227.80", "currency": "USD", "grandTotal": "1227.80", "billingCurrency": "USD"}	2025-04-21
\.


--
-- Data for Name: FlightInterest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FlightInterest" (flight_interest_id, created_at, origin, destination, departure_date, one_way, adults, user_id, return_date) FROM stdin;
42366363-bf59-41ce-ad40-7741873cd3a0	2025-04-08 07:05:59.788612+00	Paris	Dubai	2025-04-09	f	2	f7ca04aa-906e-403c-a742-17151ebfaf1e	2025-04-16
855f872f-05e4-4572-a927-bee68b31a824	2025-04-08 07:26:00.756901+00	Sydney	Amsterdam	2025-04-09	t	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
e56b5e4c-3d92-4d0a-bd5c-8b25e30d350c	2025-04-08 07:15:46.550558+00	Paris	London	2025-04-09	t	3	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
fc6b6b30-a84d-4f8f-9d0f-853402eebfb0	2025-04-08 07:37:51.350286+00	Sydney	Mumbai	2025-04-09	f	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	2025-04-16
58066502-ef8b-442a-904d-07ac68cf1219	2025-04-08 07:42:43.050742+00	Sydney	Beijing	2025-04-09	t	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
0e1ca591-53be-47ab-8d20-09fca31fa392	2025-04-08 07:48:33.547823+00	Sydney	Munich	2025-04-09	t	2	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
906149f3-c403-468f-8e72-e554e098ee78	2025-04-08 07:49:26.397139+00	Sydney	Munich	2025-04-09	t	2	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
94972308-a71f-4b12-b36e-aebb9dfa2602	2025-04-08 07:54:15.299843+00	Sydney	Munich	2025-04-12	t	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
635e0dc5-248f-496c-9462-03b0edea1627	2025-04-08 09:01:12.512486+00	Mumbai	Toronto	2025-04-09	t	2	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
b1285030-d976-4b04-86df-08749f9fec49	2025-04-08 09:15:49.328831+00	Mumbai	Toronto	2025-04-09	t	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
001787dd-77b5-46d9-8c50-16adf902716e	2025-04-08 10:22:42.618282+00	London	Johannesburg	2025-04-15	t	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
43b4057a-8b87-4216-aee4-a08f41b0440d	2025-04-08 10:25:01.900605+00	London	Johannesburg	2025-04-15	t	2	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
e06436f2-0efa-47d2-b1cf-546e1709ea11	2025-04-08 12:23:36.953013+00	Mumbai	New York	2025-04-10	t	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
001695b5-5718-4ff4-a0ef-86756988682f	2025-04-08 12:33:29.308603+00	Mumbai	Los Angeles	2025-04-09	t	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
fd28ad4a-2a9d-4294-a03f-708703d6eda5	2025-04-08 12:57:31.6844+00	Harare	Durban	2025-04-09	f	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	2025-04-16
be1aaea3-7633-4d08-98d6-a865077da85c	2025-04-08 14:09:42.506712+00	Mumbai	Sydney	2025-04-09	f	2	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-12
2ed5885a-1364-4671-980e-580a4800b444	2025-04-09 04:57:06.936471+00	Mumbai	London	2025-04-11	f	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	2025-04-16
877fcef2-59cb-4cae-8002-f6f7e334f0f6	2025-04-09 11:06:39.584001+00	Sydney	Amsterdam	2025-04-23	t	2	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
7fa58354-ee3e-449b-ae01-5e90bc0e65e4	2025-04-09 11:32:57.710863+00	Sydney	Mumbai	2025-04-23	t	1	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
7cee5023-1e06-4ce9-b2f3-20a3746ccc6f	2025-04-09 11:35:43.56238+00	Paris	London	2025-04-23	t	4	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
70aea30e-645d-4009-997e-647411a2eda8	2025-04-09 11:40:23.463604+00	Mumbai	Los Angeles	2025-04-23	t	3	f7ca04aa-906e-403c-a742-17151ebfaf1e	\N
a34ba0da-dbd2-432b-a40f-86fd8413e886	2025-04-10 04:54:56.274696+00	Hong Kong	New York	2025-04-11	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-18
b21d7d99-e2fd-4d18-a902-ca78a0f3af62	2025-04-10 06:29:43.597427+00	Hong Kong	Sydney	2025-04-11	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-18
de6373f5-d1e2-4c05-956d-da11d9eb0f77	2025-04-10 07:53:13.573862+00	Harare	Cape Town	2025-04-16	t	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	\N
47a61a9f-6f67-4abb-8de1-ea2230e8e70b	2025-04-10 07:56:18.628081+00	Harare	Cape Town	2025-04-24	t	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	\N
6a0be701-0700-4f2c-a260-3728dc434752	2025-04-10 08:25:55.427265+00	Harare	Dubai	2025-04-24	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-29
96648e61-10a5-4352-b2ac-13b04e1515fa	2025-04-10 09:59:44.914242+00	Paris	Mumbai	2025-04-18	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-25
3e5e08db-5b2a-44b1-9dba-2ffcdd6943b5	2025-04-10 10:19:48.626101+00	Johannesburg	Durban	2025-04-11	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-12
47845aa4-17f9-4f50-90f1-934f4e9ecf8f	2025-04-10 10:23:42.21387+00	Johannesburg	Durban	2025-04-11	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-12
ee625a39-d3ad-4b4a-8aeb-12164cb5a3ad	2025-04-10 10:24:48.363739+00	Johannesburg	Durban	2025-04-11	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-12
9d2e5bf7-5fc5-4d1c-88a0-87e95dd70857	2025-04-10 10:25:47.353899+00	Johannesburg	Durban	2025-04-11	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-12
17ece367-5ef0-48ec-bd82-d85737913921	2025-04-10 10:26:24.550066+00	Johannesburg	Durban	2025-04-11	f	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-12
7d465ee1-01f6-47f1-8c56-8ed565a88df2	2025-04-10 10:36:40.904169+00	Johannesburg	Durban	2025-04-12	t	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	\N
193285d8-a295-4ca0-af7b-e8851c62b783	2025-04-10 10:40:22.039652+00	Johannesburg	Durban	2025-04-12	t	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	\N
b8006fac-95f3-44b2-9948-a3850d55eff5	2025-04-10 10:59:00.587905+00	Johannesburg	Durban	2025-04-24	t	1	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	\N
5a7dc9e3-8d64-47b7-af4a-1a742db1ced2	2025-04-10 11:36:11.81103+00	Harare	Hong Kong	2025-04-24	f	3	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-04-30
830ae8ba-d095-45aa-9694-aba618a1f0ae	2025-04-10 12:13:34.56115+00	Harare	Dubai	2025-04-17	f	1	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	2025-04-24
84339e78-c737-45f9-8cb2-031729f54316	2025-04-10 12:19:22.436986+00	Dubai	Harare	2025-04-24	f	1	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	2025-05-08
b56d53a4-d5b1-4843-818e-d0d765918ba2	2025-04-10 13:05:42.545191+00	Harare	Hong Kong	2025-04-18	f	1	11e13082-156f-44e3-9bd2-ee64cfd36af3	2025-04-22
6a25b98c-9177-4809-a3c8-bc5ef3496a5c	2025-04-10 13:15:42.084043+00	Sydney	New York	2025-04-16	t	1	11e13082-156f-44e3-9bd2-ee64cfd36af3	\N
3b36f77e-d94d-484d-99c8-af124dd812c6	2025-04-10 13:20:20.112266+00	Sydney	New York	2025-04-24	t	1	11e13082-156f-44e3-9bd2-ee64cfd36af3	\N
8fb584e2-ee56-4639-9d34-64a951fefb4c	2025-04-10 13:28:29.360005+00	Harare	Paris	2025-04-24	f	1	8eeb97b5-f931-4e2b-83de-efddbddf8815	2025-05-02
d132d9b8-54b7-436c-aa59-248daf257359	2025-04-10 13:38:09.623335+00	Harare	Dubai	2025-04-30	t	1	8eeb97b5-f931-4e2b-83de-efddbddf8815	\N
dc5fb9dc-07eb-451b-b4ba-4678814abb29	2025-04-10 13:41:44.154486+00	Harare	Durban	2025-06-11	f	1	8eeb97b5-f931-4e2b-83de-efddbddf8815	2025-06-18
e528b029-1cfe-4e78-bbff-032a2a978945	2025-04-10 13:45:44.596296+00	Harare	Cape Town	2025-06-04	f	3	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	2025-06-18
ac1c7434-a4cd-4213-a2ae-ad7c30e0c214	2025-04-10 14:37:48.735906+00	Harare	London	2025-06-10	f	1	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	2025-06-17
59b1ae7b-69df-4bdc-85ce-eb5030aa8cf5	2025-04-10 14:40:24.224932+00	Harare	London	2025-06-10	f	1	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	2025-06-17
2b256a0f-b858-4991-b7c1-5e6b612ee3cb	2025-04-11 08:08:27.338927+00	Harare	Dubai	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
d2240eff-7261-4aeb-8eaa-bdf6063e8e43	2025-04-11 08:11:19.48809+00	Harare	Dubai	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
08adc6ba-41e5-4e23-875b-b44abcf60395	2025-04-11 08:14:54.237961+00	Harare	Dubai	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
de72d0c3-1756-4ae6-9ddd-8beff667b30e	2025-04-11 08:16:19.472365+00	Harare	Dubai	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
564d8ce6-1a8e-47cd-b08d-776bd37d3b98	2025-04-11 08:16:53.893179+00	Harare	Dubai	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
0be0d527-61dc-448e-817d-c8d91658026f	2025-04-11 08:17:31.822306+00	Harare	Dubai	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
5bbf2d4a-e0b7-4c93-b661-3c0da46ed3f9	2025-04-11 08:20:06.766875+00	Harare	Tokyo	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
f0bd8c23-7964-4cf7-89da-2617f5ff9a71	2025-04-11 08:22:06.868295+00	Harare	New York	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
8f765e87-0e12-4c18-8c35-5aed3baf6818	2025-04-11 08:23:35.267855+00	Harare	New York	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
d1d18c4d-296d-4ef7-b7e4-70bc8ba367b0	2025-04-11 08:24:01.849176+00	Harare	New York	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
97f498fe-456a-4843-a1ce-cc8174405b7d	2025-04-11 08:25:41.748941+00	Harare	New York	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
c963763f-a3b7-406a-9a56-fce3872756b6	2025-04-11 08:26:22.653002+00	Harare	Hong Kong	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
c321f32c-dd2f-43d9-99bb-c9304f360a8e	2025-04-11 08:27:56.309722+00	Harare	Hong Kong	2025-04-11	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
b0f740b7-388c-4bc4-a543-c5a89171e0c8	2025-04-11 08:34:30.785062+00	Harare	Hong Kong	2025-04-11	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-12
ac6ab489-a378-4883-bc04-97ae29ad70ae	2025-04-11 09:22:24.382916+00	Beijing	London	2025-04-25	f	3	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-29
adf8be91-58f7-4a38-8e6e-d5c2f8415fe5	2025-04-11 10:35:25.478937+00	Johannesburg	Dubai	2025-04-16	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-21
e27df9cc-cec9-45c1-bef0-17f9d5026539	2025-04-11 12:20:43.306939+00	Beijing	London	2025-05-15	f	2	95645fa0-84c2-492c-972e-e6feab30454e	2025-05-30
a348372e-12c0-46ad-a014-05a99407eb0c	2025-04-11 12:23:15.899982+00	Beijing	London	2025-05-15	f	2	95645fa0-84c2-492c-972e-e6feab30454e	2025-05-30
bbd29bdf-eefb-415b-b8e6-07d49e5829a3	2025-04-11 12:24:45.498731+00	Beijing	London	2025-04-18	f	2	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-25
5ddad8d9-6e1c-4556-8065-7c5cdc54154b	2025-04-11 12:37:07.419489+00	Beijing	Dubai	2025-04-18	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-25
cefd2d8f-61c6-4e94-a377-dbdb2b9637d2	2025-04-11 13:12:37.766936+00	Dubai	Sydney	2025-04-12	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-14
e6aafd51-562c-4fff-94bb-855445a6341b	2025-04-11 13:20:49.897515+00	Sydney	Buenos Aires	2025-04-12	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-14
f4d7426d-fb5c-428e-8311-c1af27028cbd	2025-04-11 13:21:07.358515+00	Sydney	Buenos Aires	2025-04-14	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-18
7f83ea1d-4bea-4ae7-b1f6-1d98b687332b	2025-04-11 13:21:34.279401+00	Sydney	Buenos Aires	2025-05-14	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-05-21
4c8a5d31-f50a-4ca1-b490-700bc532898b	2025-04-11 13:22:30.645795+00	Sydney	London	2025-05-14	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-05-21
12853ffe-533c-4e92-a53d-a7fc953b2616	2025-04-11 13:23:38.872433+00	Sydney	London	2025-04-14	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-21
8e2289d0-365e-4b02-86a8-af4f16b4788c	2025-04-11 13:24:59.310141+00	Buenos Aires	Seoul	2025-04-14	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-21
41b59f95-1729-43c6-96c8-dbca5f2bce89	2025-04-11 13:25:11.990259+00	London	Seoul	2025-04-14	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-21
80f4db36-75c8-4f5c-9cd8-043ea578db7f	2025-04-11 13:30:00.999299+00	London	Hong Kong	2025-04-14	f	4	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-21
f1825579-a4e8-4854-85da-ba3b166b4562	2025-04-11 13:40:48.297031+00	London	Atlanta	2025-04-17	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
ce9f4878-ebc7-44fb-a4ca-58f2cab99c97	2025-04-11 13:46:53.779951+00	Beijing	Sydney	2025-04-22	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-28
de622a99-b2b9-480a-ae10-8449ea3d8272	2025-04-11 14:03:52.000687+00	Harare	Johannesburg	2025-04-22	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-28
dd8abdba-a36d-450b-b026-347ea9ecbdc6	2025-04-11 14:12:59.640067+00	Beijing	Hong Kong	2025-04-12	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
2edd1e43-641e-458a-a2e1-99771ec71c12	2025-04-11 14:23:55.700323+00	Beijing	Hong Kong	2025-04-25	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
c395b194-d5ba-4896-8ef7-c1d25b662626	2025-04-11 14:26:41.883044+00	Harare	Hong Kong	2025-04-25	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
89b8ff42-be37-487b-9dc0-06967a143522	2025-04-11 14:28:27.291034+00	Harare	Durban	2025-04-12	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
f0e10630-851c-4a51-b0e1-8291d94eba90	2025-04-13 17:14:23.414049+00	Harare	Cape Town	2025-04-16	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-18
aab68e01-2e0a-4c3a-ab53-5edf468c8d10	2025-04-13 17:16:39.954054+00	Harare	Bulawayo	2025-04-16	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-18
01572f5b-0f0b-41be-acc9-b98c2a08ea40	2025-04-13 17:26:55.521397+00	Harare	Beijing	2025-04-16	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-18
33ce3259-f961-457b-932a-54c07ab72e90	2025-04-13 17:29:03.935102+00	London	Beijing	2025-04-16	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-18
d851eff2-27c9-4dea-b15b-430ab84689c3	2025-04-13 17:32:19.319797+00	London	Sydney	2025-04-16	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-18
11e52eb0-7b66-45ef-8190-ed6a99a5ea5d	2025-04-13 18:35:14.652783+00	Harare	Johannesburg	2025-04-15	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
a806499a-4f7c-448f-b5a5-d4d2dfd2fc66	2025-04-14 08:15:43.487396+00	Harare	Maputo	2025-04-21	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-28
2c1b039e-e095-49c0-96f4-d9f6a0d1b3fd	2025-04-14 08:16:04.49358+00	Harare	Maputo	2025-04-21	f	2	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-28
aeeac7d5-9d1c-40e5-b07c-cc4c57e937db	2025-04-14 14:51:22.411562+00	Tokyo	Seoul	2025-05-15	f	4	95645fa0-84c2-492c-972e-e6feab30454e	2025-05-22
f34c1b1f-58a8-4100-a4d9-a7fa17a4709b	2025-04-14 15:08:59.969643+00	Tokyo	Seoul	2025-05-15	f	3	95645fa0-84c2-492c-972e-e6feab30454e	2025-05-22
cd1d39dc-799d-424d-a083-9710f7cfb307	2025-04-15 06:05:59.662951+00		Beijing	2025-04-22	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
41cd920b-399f-4328-be95-54d500e283f6	2025-04-15 06:12:07.124426+00	Beijing	Beijing	2025-04-22	t	1	95645fa0-84c2-492c-972e-e6feab30454e	\N
d0036747-3557-46db-a7f7-0674719a7f96	2025-04-15 06:13:56.204282+00	Beijing		2025-04-22	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-24
822e8fe6-5a8d-4cf2-94fa-ad2051d49136	2025-04-15 06:17:30.681367+00	Beijing		2025-04-22	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-24
2314629d-cb48-4f62-8d82-a14d82075da3	2025-04-15 06:18:32.393162+00	Beijing	Addis Ababa	2025-04-22	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-24
c5d2732d-d5ab-4bd3-85a8-4329c96c42e2	2025-04-15 06:35:15.919932+00	Buenos Aires	Lilongwe	2025-04-24	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-28
725f48d1-c761-40f7-98a6-1d621dd0a456	2025-04-15 06:35:32.065297+00	Buenos Aires	Lilongwe	2025-04-24	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-28
e7246be5-fd5f-4e5d-b921-36a298b600f8	2025-04-15 06:37:46.516015+00	London	Lilongwe	2025-04-24	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-28
38f3c41c-182a-4bec-ae5e-d1ec4ec8042a	2025-04-15 07:18:19.047814+00	New York	Singapore	2025-04-23	f	3	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-25
cc592acb-a1f7-4f3f-bbc2-82b25c6c6564	2025-04-15 07:49:19.574611+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-17
a06fd36e-ca18-4dcd-b0d5-bddec12b6c50	2025-04-15 08:12:01.154813+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-16
c8adcc1e-d909-43a4-96d0-65b6b40cf755	2025-04-15 08:14:30.442751+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-16
f171293d-83ea-4a6c-834b-65824e723637	2025-04-15 08:16:00.382415+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
63baa4a7-d126-42eb-87ae-cb8494429e0c	2025-04-15 08:17:41.648528+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
9e212407-efc4-47e4-a895-25ebf67450d2	2025-04-15 08:24:11.547429+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
e1618038-94f9-4b4c-90b1-a4a0c6acc1ed	2025-04-15 08:25:06.979737+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
d93deecd-94da-4410-88e9-03b6bf38069e	2025-04-15 08:25:40.746634+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
3f3ff85d-5236-45f7-a642-a12db437932a	2025-04-15 08:26:43.71279+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
2c026fac-a512-46e6-a72a-b25933de982a	2025-04-15 08:30:24.233931+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
8fe23b8c-88a2-40be-a5c0-8a71d3cde399	2025-04-15 08:31:30.035512+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
fec41f3c-75a0-4758-91b5-ad93d4c8e017	2025-04-15 08:32:13.924714+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
02fbbe23-4e21-498b-9152-a630a5467b34	2025-04-15 08:33:18.550313+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
74b39fe2-74f0-4fd0-b6cc-237f695cb42a	2025-04-15 08:47:49.973931+00	New York	London	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
72b384f9-ab6f-4c2b-b18f-519823226529	2025-04-15 08:51:00.106403+00	Harare	Dubai	2025-04-15	f	1	95645fa0-84c2-492c-972e-e6feab30454e	2025-04-22
\.


--
-- Data for Name: Profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Profiles" (created_at, first_name, last_name, email, phone, id, role) FROM stdin;
2025-04-08 06:04:33.42597+00	first	last	test@test.com	12345	f7ca04aa-906e-403c-a742-17151ebfaf1e	tourist
2025-04-08 14:08:29.954304+00	simon	moyo	simon@gmail.com	987654	fe6632be-8ed7-4528-9cf2-9ab1ca27707c	tourist
2025-04-10 12:12:47.567532+00	Andrew	Jackson	ajackson@gmail.com	0781996558	f38ce1fd-27f1-4534-92e1-e613d5a9a9ee	tourist
2025-04-10 12:29:41.414835+00	Simbarashe	Mahachi	smahachi@gmail.com	123456789	11e13082-156f-44e3-9bd2-ee64cfd36af3	tourist
2025-04-10 13:27:57.373285+00	Geoffrey	Madamombe	gmadamombe@gmail.com	9876543210	8eeb97b5-f931-4e2b-83de-efddbddf8815	tourist
2025-04-11 08:07:43.896006+00	Simbarashe	Motsi	smotsi@gmail.com	+263782456123	95645fa0-84c2-492c-972e-e6feab30454e	tourist
2025-04-14 15:05:07.507774+00	Innocent	Greats	igreats@gmail.com	+263012345678	3da4b9e3-3d6f-4c3d-a1ae-2ae181ec9223	tourist
\.


--
-- Data for Name: ShuttleBooking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ShuttleBooking" (booking_id, created_at, user_id, first_name, last_name, departure_date, phone_number, email, amount_paid, company_id, route_id) FROM stdin;
62e09deb-40eb-4c11-af6b-f8f0c3f00075	2025-04-14 07:37:18.746093+00	95645fa0-84c2-492c-972e-e6feab30454e	firstone	lastone	2025-04-14	123456789	firstlast@gmail.com	25	d7c38129-7279-4a37-a1c8-e0cc90d84d24	77f06f33-86d8-4fc5-8eb1-8cb48221165d
990a2fd5-ddbc-4e17-9ce4-d3ed37935389	2025-04-14 08:14:35.766142+00	95645fa0-84c2-492c-972e-e6feab30454e	firsttwo	lasttwo	2025-04-14	147852369	firsttwolasttwo@test.com	25	d7c38129-7279-4a37-a1c8-e0cc90d84d24	77f06f33-86d8-4fc5-8eb1-8cb48221165d
802cd0e4-b5d8-4b2a-a9c9-5b8a1a71af20	2025-04-14 11:31:15.688043+00	95645fa0-84c2-492c-972e-e6feab30454e	firstthree	lastthree	2025-04-14	+263987654321	firstlast3@test.com	25	d7c38129-7279-4a37-a1c8-e0cc90d84d24	77f06f33-86d8-4fc5-8eb1-8cb48221165d
ea47e820-1e26-4cbe-9b86-b1c1d2720e23	2025-04-14 11:55:27.603755+00	95645fa0-84c2-492c-972e-e6feab30454e	firstfour	lastfour	2025-04-14	+263123456789	flfour@gmail.com	25	d7c38129-7279-4a37-a1c8-e0cc90d84d24	77f06f33-86d8-4fc5-8eb1-8cb48221165d
bf0b899a-576a-4d28-8996-3fa4e5191ec7	2025-04-14 11:56:07.314264+00	95645fa0-84c2-492c-972e-e6feab30454e	firstfive	lastfive	2025-04-14	+263123456789	flfive@gmail.com	25	d7c38129-7279-4a37-a1c8-e0cc90d84d24	77f06f33-86d8-4fc5-8eb1-8cb48221165d
240586bf-baa6-4854-8647-5e0c3068dc21	2025-04-14 12:05:58.462478+00	95645fa0-84c2-492c-972e-e6feab30454e	firstsix	lastsix	2025-04-16	+263312450791	flsix@test.com	25	d7c38129-7279-4a37-a1c8-e0cc90d84d24	77f06f33-86d8-4fc5-8eb1-8cb48221165d
16b5451d-9120-419f-90bb-7d9e37020db0	2025-04-14 14:59:57.496059+00	95645fa0-84c2-492c-972e-e6feab30454e	Innocent	Greats	2025-04-14	+263012345678	igreats@gmail.com	25	d7c38129-7279-4a37-a1c8-e0cc90d84d24	77f06f33-86d8-4fc5-8eb1-8cb48221165d
\.


--
-- Data for Name: ShuttleInterest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ShuttleInterest" (shttle_interest_id, created_at, origin, destination, departure_date, user_id) FROM stdin;
dd4a2c79-5495-4997-9e80-d07592342161	2025-04-13 19:12:31.650459+00	Harare	Bulawayo	2025-04-18	95645fa0-84c2-492c-972e-e6feab30454e
21351ee7-7a69-4bec-becc-cea5b6eeb7d8	2025-04-13 19:14:18.461407+00	Harare	Bulawayo	2025-04-22	95645fa0-84c2-492c-972e-e6feab30454e
9303ebc5-7f1a-4f52-9cdd-9aa945fa3afe	2025-04-14 04:48:36.505073+00	Harare	Bulawayo	2025-04-15	95645fa0-84c2-492c-972e-e6feab30454e
a5fcb8d2-0ff6-4761-a26f-565f8be85bf2	2025-04-14 04:49:11.838101+00	Harare	Bulawayo	2025-04-15	95645fa0-84c2-492c-972e-e6feab30454e
d98f64b1-a434-410b-822b-41e8edcaee36	2025-04-14 04:50:05.790868+00	Harare	Bulawayo	2025-04-15	95645fa0-84c2-492c-972e-e6feab30454e
78076e41-c9c3-4f55-bb6e-050867e7543d	2025-04-14 04:52:47.117906+00	Harare	Bulawayo	2025-04-16	95645fa0-84c2-492c-972e-e6feab30454e
2cb14ea9-09b6-4937-945a-441bd9a7bb2e	2025-04-14 04:54:53.431788+00	Harare	Bulawayo	2025-04-16	95645fa0-84c2-492c-972e-e6feab30454e
127b897c-6c15-492a-b1f0-77a9661b5852	2025-04-14 05:13:39.002463+00	Harare	Bulawayo	2025-04-15	95645fa0-84c2-492c-972e-e6feab30454e
d7abd07e-ee03-4884-aed9-a4bc54dd5365	2025-04-14 05:14:45.13294+00	Harare	Bulawayo	2025-04-15	95645fa0-84c2-492c-972e-e6feab30454e
db417dcd-3c72-498a-b086-9ba05c2b999e	2025-04-14 05:18:49.346017+00	Harare	Bulawayo	2025-04-15	95645fa0-84c2-492c-972e-e6feab30454e
e95dabc6-dff7-4c6f-8eb8-e79be8ad7b19	2025-04-14 05:23:22.314353+00	Harare	Bulawayo	2025-04-22	95645fa0-84c2-492c-972e-e6feab30454e
7eaed70a-c28c-4167-b3c1-c46921951103	2025-04-14 06:42:55.613201+00	Harare	Bulawayo	2025-04-15	95645fa0-84c2-492c-972e-e6feab30454e
ecaa41f8-2019-424c-9688-b3a77059d9e3	2025-04-14 06:45:09.889013+00	harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
794ce064-a425-4a8a-b2a8-009d2a1c0980	2025-04-14 06:45:24.043053+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
de3d2187-81e6-45a6-accf-36ad8d7d0c35	2025-04-14 06:49:49.646831+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
58df6f0a-f3c3-4000-af60-2cbb906decb9	2025-04-14 07:27:42.163972+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
2e9dd094-0cf0-4f41-ab4c-9b8bff8686ea	2025-04-14 07:34:59.376514+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
b7d464bc-8d3c-4eca-910e-32216727294d	2025-04-14 07:46:07.467455+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
13bf17b7-f3f7-4877-b725-0f332bf9b024	2025-04-14 07:47:30.412281+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
91fdc91d-a4b1-49e0-b6fc-978d07620e84	2025-04-14 07:48:20.178275+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
b59c4f99-0ff7-4de7-b9e8-e11d5ebf2079	2025-04-14 07:50:23.02657+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
bf995381-1502-4912-be42-74cf64f63458	2025-04-14 07:51:05.359702+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
c2065483-c8ac-4251-b58e-a5517a9fcc04	2025-04-14 07:53:23.76925+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
30c68cc0-8016-48dc-9d7b-44db7369324c	2025-04-14 07:54:35.713673+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
cdd9784b-80e0-4cd5-b4b9-75810bdde0f6	2025-04-14 07:55:04.64021+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
0ad2aae0-e590-4f6b-a139-be4294880525	2025-04-14 08:05:03.152776+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
217e22cb-d0dd-4473-a2fb-dddb2891fe06	2025-04-14 08:12:47.832422+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
dae68240-b0e0-4842-bbf6-2ec07856b32c	2025-04-14 11:13:28.259864+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
12fcc29d-ba7b-4eec-9eb9-52e1348b31a4	2025-04-14 11:17:18.585463+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
0e0be28f-0e1d-41aa-9bde-81798b9f105c	2025-04-14 11:29:46.662298+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
0007818d-debb-4bd4-a38e-94c739f318b0	2025-04-14 11:40:52.505678+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
9055017b-3f2a-4bc2-9616-fb80d99090af	2025-04-14 11:45:51.02271+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
b1949a70-ad69-4db2-9dd0-d2b601272196	2025-04-14 11:51:09.07341+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
132927a8-1cb4-42eb-adb6-0fc3e879df47	2025-04-14 11:55:01.187758+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
7f5b2a75-865f-4d0e-82a9-8e0431241c2a	2025-04-14 12:05:34.278985+00	Harare	Bulawayo	2025-04-16	95645fa0-84c2-492c-972e-e6feab30454e
5bd1a2b5-b9e6-4217-84d3-eab7efe6bef4	2025-04-14 14:59:27.611714+00	Harare	Bulawayo	2025-04-14	95645fa0-84c2-492c-972e-e6feab30454e
\.


--
-- Data for Name: ShuttleRoutes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ShuttleRoutes" (route_id, created_at, company_id, origin, destination, departure_time, arrival_time, bus_stops, price) FROM stdin;
77f06f33-86d8-4fc5-8eb1-8cb48221165d	2025-04-11 07:01:03.756734+00	d7c38129-7279-4a37-a1c8-e0cc90d84d24	Harare	Bulawayo	08:00	14:00	{"{\\"Stop 1\\": \\"Chicken Slice Gweru\\", \\"Stop 2\\": \\"Bluetech Service Station Kwekwe\\", \\"Stop 3\\": \\"Eat 'n Lick Kadoma\\", \\"Stop 4\\": \\"Bakers King Chegutu\\"}"}	25
\.


--
-- Data for Name: ShuttleServiceCompany; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ShuttleServiceCompany" (company_id, created_at, name, address, contact_phone, contact_email) FROM stdin;
d7c38129-7279-4a37-a1c8-e0cc90d84d24	2025-04-11 06:53:01.046905+00	Galaxy Coaches	Between 10th & 11th Avenue, 106B Jason Moyo St, Bulawayo	0719409099	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-04-08 05:43:43
20211116045059	2025-04-08 05:43:43
20211116050929	2025-04-08 05:43:43
20211116051442	2025-04-08 05:43:43
20211116212300	2025-04-08 05:43:43
20211116213355	2025-04-08 05:43:43
20211116213934	2025-04-08 05:43:43
20211116214523	2025-04-08 05:43:43
20211122062447	2025-04-08 05:43:43
20211124070109	2025-04-08 05:43:43
20211202204204	2025-04-08 05:43:43
20211202204605	2025-04-08 05:43:43
20211210212804	2025-04-08 05:43:43
20211228014915	2025-04-08 05:43:43
20220107221237	2025-04-08 05:43:43
20220228202821	2025-04-08 05:43:43
20220312004840	2025-04-08 05:43:43
20220603231003	2025-04-08 05:43:43
20220603232444	2025-04-08 05:43:43
20220615214548	2025-04-08 05:43:43
20220712093339	2025-04-08 05:43:43
20220908172859	2025-04-08 05:43:43
20220916233421	2025-04-08 05:43:43
20230119133233	2025-04-08 05:43:43
20230128025114	2025-04-08 05:43:43
20230128025212	2025-04-08 05:43:43
20230227211149	2025-04-08 05:43:43
20230228184745	2025-04-08 05:43:43
20230308225145	2025-04-08 05:43:43
20230328144023	2025-04-08 05:43:43
20231018144023	2025-04-08 05:43:43
20231204144023	2025-04-08 05:43:43
20231204144024	2025-04-08 05:43:43
20231204144025	2025-04-08 05:43:43
20240108234812	2025-04-08 05:43:43
20240109165339	2025-04-08 05:43:43
20240227174441	2025-04-08 05:43:44
20240311171622	2025-04-08 05:43:44
20240321100241	2025-04-08 05:43:44
20240401105812	2025-04-08 05:43:44
20240418121054	2025-04-08 05:43:44
20240523004032	2025-04-08 05:43:44
20240618124746	2025-04-08 05:43:44
20240801235015	2025-04-08 05:43:44
20240805133720	2025-04-08 05:43:44
20240827160934	2025-04-08 05:43:44
20240919163303	2025-04-08 05:43:44
20240919163305	2025-04-08 05:43:44
20241019105805	2025-04-08 05:43:44
20241030150047	2025-04-08 05:43:44
20241108114728	2025-04-08 05:43:44
20241121104152	2025-04-08 05:43:44
20241130184212	2025-04-08 05:43:44
20241220035512	2025-04-08 05:43:44
20241220123912	2025-04-08 05:43:44
20241224161212	2025-04-08 05:43:44
20250107150512	2025-04-08 05:43:44
20250110162412	2025-04-08 05:43:44
20250123174212	2025-04-08 05:43:44
20250128220012	2025-04-08 05:43:44
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-04-08 05:43:45.899139
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-04-08 05:43:45.901821
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-04-08 05:43:45.904048
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-04-08 05:43:45.90935
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-04-08 05:43:45.926741
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-04-08 05:43:45.929404
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-04-08 05:43:45.932912
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-04-08 05:43:45.93625
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-04-08 05:43:45.938752
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-04-08 05:43:45.941331
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-04-08 05:43:45.944238
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-04-08 05:43:45.947692
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-04-08 05:43:45.951653
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-04-08 05:43:45.954382
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-04-08 05:43:45.956929
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-04-08 05:43:45.976212
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-04-08 05:43:45.978944
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-04-08 05:43:45.981361
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-04-08 05:43:45.983948
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-04-08 05:43:45.986685
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-04-08 05:43:45.989209
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-04-08 05:43:45.996229
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-04-08 05:43:46.018997
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-04-08 05:43:46.04337
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-04-08 05:43:46.046713
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-04-08 05:43:46.049372
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-04-08 05:43:46.051932
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-04-08 05:43:46.065693
28	object-bucket-name-sorting	8f385d71c72f7b9f6388e22f6e393e3b78bf8617	2025-04-08 05:43:46.076643
29	create-prefixes	8416491709bbd2b9f849405d5a9584b4f78509fb	2025-04-08 05:43:46.07977
30	update-object-levels	f5899485e3c9d05891d177787d10c8cb47bae08a	2025-04-08 05:43:46.082726
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-04-08 05:43:46.093822
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-04-08 05:43:46.106489
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-04-08 05:43:46.119392
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-04-08 05:43:46.122175
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-04-08 05:43:46.12895
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2025-04-08 05:43:34.02228+00
20210809183423_update_grants	2025-04-08 05:43:34.02228+00
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 136, true);


--
-- Name: jobid_seq; Type: SEQUENCE SET; Schema: cron; Owner: supabase_admin
--

SELECT pg_catalog.setval('cron.jobid_seq', 2, true);


--
-- Name: runid_seq; Type: SEQUENCE SET; Schema: cron; Owner: supabase_admin
--

SELECT pg_catalog.setval('cron.runid_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: FlightInterest FlightBooking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlightInterest"
    ADD CONSTRAINT "FlightBooking_pkey" PRIMARY KEY (flight_interest_id);


--
-- Name: FlightBooking FlightBooking_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlightBooking"
    ADD CONSTRAINT "FlightBooking_pkey1" PRIMARY KEY (booking_id);


--
-- Name: Profiles Profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Profiles"
    ADD CONSTRAINT "Profiles_pkey" PRIMARY KEY (id);


--
-- Name: ShuttleBooking ShuttleBooking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleBooking"
    ADD CONSTRAINT "ShuttleBooking_pkey" PRIMARY KEY (booking_id);


--
-- Name: ShuttleInterest ShuttleInterest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleInterest"
    ADD CONSTRAINT "ShuttleInterest_pkey" PRIMARY KEY (shttle_interest_id);


--
-- Name: ShuttleRoutes ShuttleRoutes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleRoutes"
    ADD CONSTRAINT "ShuttleRoutes_pkey" PRIMARY KEY (route_id);


--
-- Name: ShuttleServiceCompany ShuttleServiceCompanies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleServiceCompany"
    ADD CONSTRAINT "ShuttleServiceCompanies_pkey" PRIMARY KEY (company_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


--
-- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


--
-- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_unique ON storage.objects USING btree (name COLLATE "C", bucket_id);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: FlightBooking auto_delete_expired_itineraries; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_delete_expired_itineraries AFTER INSERT OR UPDATE ON public."FlightBooking" FOR EACH STATEMENT EXECUTE FUNCTION public.delete_expired_itineraries();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN ((new.name <> old.name)) EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: FlightInterest FlightBooking_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlightInterest"
    ADD CONSTRAINT "FlightBooking_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."Profiles"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FlightBooking FlightBooking_user_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FlightBooking"
    ADD CONSTRAINT "FlightBooking_user_id_fkey1" FOREIGN KEY (user_id) REFERENCES public."Profiles"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ShuttleBooking ShuttleBooking_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleBooking"
    ADD CONSTRAINT "ShuttleBooking_company_id_fkey" FOREIGN KEY (company_id) REFERENCES public."ShuttleServiceCompany"(company_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ShuttleBooking ShuttleBooking_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleBooking"
    ADD CONSTRAINT "ShuttleBooking_route_id_fkey" FOREIGN KEY (route_id) REFERENCES public."ShuttleRoutes"(route_id);


--
-- Name: ShuttleBooking ShuttleBooking_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleBooking"
    ADD CONSTRAINT "ShuttleBooking_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."Profiles"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ShuttleInterest ShuttleInterest_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleInterest"
    ADD CONSTRAINT "ShuttleInterest_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."Profiles"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ShuttleRoutes ShuttleRoutes_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShuttleRoutes"
    ADD CONSTRAINT "ShuttleRoutes_company_id_fkey" FOREIGN KEY (company_id) REFERENCES public."ShuttleServiceCompany"(company_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: FlightInterest Allow public read access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public read access" ON public."FlightInterest" FOR SELECT USING (true);


--
-- Name: Profiles Allow public read access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public read access" ON public."Profiles" FOR SELECT USING (true);


--
-- Name: FlightBooking; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."FlightBooking" ENABLE ROW LEVEL SECURITY;

--
-- Name: FlightInterest; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."FlightInterest" ENABLE ROW LEVEL SECURITY;

--
-- Name: Profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."Profiles" ENABLE ROW LEVEL SECURITY;

--
-- Name: ShuttleBooking; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."ShuttleBooking" ENABLE ROW LEVEL SECURITY;

--
-- Name: ShuttleInterest; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."ShuttleInterest" ENABLE ROW LEVEL SECURITY;

--
-- Name: ShuttleRoutes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."ShuttleRoutes" ENABLE ROW LEVEL SECURITY;

--
-- Name: ShuttleServiceCompany; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."ShuttleServiceCompany" ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime FlightBooking; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public."FlightBooking";


--
-- Name: supabase_realtime FlightInterest; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public."FlightInterest";


--
-- Name: supabase_realtime Profiles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public."Profiles";


--
-- Name: supabase_realtime ShuttleBooking; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public."ShuttleBooking";


--
-- Name: supabase_realtime ShuttleRoutes; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public."ShuttleRoutes";


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA cron; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA cron TO postgres WITH GRANT OPTION;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA supabase_functions; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA supabase_functions TO postgres;
GRANT USAGE ON SCHEMA supabase_functions TO anon;
GRANT USAGE ON SCHEMA supabase_functions TO authenticated;
GRANT USAGE ON SCHEMA supabase_functions TO service_role;
GRANT ALL ON SCHEMA supabase_functions TO supabase_functions_admin;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION job_cache_invalidate(); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.job_cache_invalidate() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION schedule(schedule text, command text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule(schedule text, command text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION schedule(job_name text, schedule text, command text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule(job_name text, schedule text, command text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION unschedule(job_id bigint); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.unschedule(job_id bigint) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION unschedule(job_name text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.unschedule(job_name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION clean_expired_itineraries(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.clean_expired_itineraries() TO anon;
GRANT ALL ON FUNCTION public.clean_expired_itineraries() TO authenticated;
GRANT ALL ON FUNCTION public.clean_expired_itineraries() TO service_role;


--
-- Name: FUNCTION delete_expired_itineraries(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete_expired_itineraries() TO anon;
GRANT ALL ON FUNCTION public.delete_expired_itineraries() TO authenticated;
GRANT ALL ON FUNCTION public.delete_expired_itineraries() TO service_role;


--
-- Name: FUNCTION group_flight_interests(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.group_flight_interests() TO anon;
GRANT ALL ON FUNCTION public.group_flight_interests() TO authenticated;
GRANT ALL ON FUNCTION public.group_flight_interests() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION http_request(); Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

REVOKE ALL ON FUNCTION supabase_functions.http_request() FROM PUBLIC;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO postgres;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO anon;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO authenticated;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO service_role;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE job; Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT SELECT ON TABLE cron.job TO postgres WITH GRANT OPTION;


--
-- Name: TABLE job_run_details; Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE cron.job_run_details TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- Name: TABLE "FlightBooking"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."FlightBooking" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."FlightBooking" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."FlightBooking" TO service_role;


--
-- Name: TABLE "FlightInterest"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."FlightInterest" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."FlightInterest" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."FlightInterest" TO service_role;


--
-- Name: TABLE "Profiles"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Profiles" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Profiles" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."Profiles" TO service_role;


--
-- Name: TABLE "ShuttleBooking"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleBooking" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleBooking" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleBooking" TO service_role;


--
-- Name: TABLE "ShuttleInterest"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleInterest" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleInterest" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleInterest" TO service_role;


--
-- Name: TABLE "ShuttleRoutes"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleRoutes" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleRoutes" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleRoutes" TO service_role;


--
-- Name: TABLE "ShuttleServiceCompany"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleServiceCompany" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleServiceCompany" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."ShuttleServiceCompany" TO service_role;


--
-- Name: TABLE flight_interest_stats; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.flight_interest_stats TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.flight_interest_stats TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.flight_interest_stats TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO postgres;


--
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.prefixes TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.prefixes TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.prefixes TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE hooks; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE supabase_functions.hooks TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE supabase_functions.hooks TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE supabase_functions.hooks TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE supabase_functions.hooks TO service_role;


--
-- Name: SEQUENCE hooks_id_seq; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO postgres;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO anon;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO service_role;


--
-- Name: TABLE migrations; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE supabase_functions.migrations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE supabase_functions.migrations TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE supabase_functions.migrations TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE supabase_functions.migrations TO service_role;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,DELETE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

