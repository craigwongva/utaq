--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: utap; Type: SCHEMA; Schema: -; Owner: utap
--

CREATE SCHEMA utap;


ALTER SCHEMA utap OWNER TO utap;

--
-- Name: utapdev; Type: SCHEMA; Schema: -; Owner: utap
--

CREATE SCHEMA utapdev;


ALTER SCHEMA utapdev OWNER TO utap;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA utap;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- Name: delete_framework_cascade(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.delete_framework_cascade(my_framework_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  node_ids int array;
  collection_concept_ids int array;
begin

  select array(
    select node_id from framework_nodes where framework_id = my_framework_id
  )
    into node_ids;
  
  row_cnt = delete_nodes_cascade(node_ids);

  with a as (delete from framework where id = my_framework_id returning id) 
    select count(*) into row_cnt from a;
  return row_cnt;
end; $$;


ALTER FUNCTION utap.delete_framework_cascade(my_framework_id integer) OWNER TO utap;

--
-- Name: delete_node_cascade(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.delete_node_cascade(my_node_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  _node_id_arr int array;
begin
  select array(
    select my_node_id 
  ) into _node_id_arr;

  row_cnt = delete_nodes_cascade(_node_id_arr);

  return row_cnt;
end; $$;


ALTER FUNCTION utap.delete_node_cascade(my_node_id integer) OWNER TO utap;

--
-- Name: delete_nodes_cascade(integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.delete_nodes_cascade(_node_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  vsa_ids int array;
  row_cnt int;
begin

  delete 
    from node_processes
   where node_id = ANY(_node_ids); 
  delete 
    from node_locations
   where node_id = ANY(_node_ids);
  delete 
    from related_nodes
   where node_id = ANY(_node_ids);
  delete 
    from node_collection_reqs
   where node_id = ANY(_node_ids);
  delete 
    from node_sources
   where node_id = ANY(_node_ids);
  delete 
    from node_types
   where node_id = ANY(_node_ids);

  -- delete vsa
  select array(
    select v.id
      from node_vsa nv,
           vsa v
     where nv.node_id = ANY(_node_ids)
       and v.id = nv.vsa_id
  ) into vsa_ids;

  delete 
    from node_vsa
   where node_id = ANY(_node_ids);

  delete
    from vsa
   where id = ANY(vsa_ids);

  delete 
    from node_collection_concepts
   where node_id = ANY(_node_ids);
  delete 
    from node_tags
   where node_id = ANY(_node_ids);
  delete 
    from node_selectors
   where node_id = ANY(_node_ids);
  delete 
    from framework_nodes
   where node_id = ANY(_node_ids);

  with a as(
  delete 
    from node 
   where id = ANY(_node_ids)
   returning id
  ) select count(*) into row_cnt from a;

  return row_cnt;

end; $$;


ALTER FUNCTION utap.delete_nodes_cascade(_node_ids integer[]) OWNER TO utap;

--
-- Name: get_accesses(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_accesses(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$

declare
  mycurs refcursor;
begin
  open mycurs for 
    select * 
      from access_v av
     where av.node_id = my_node_id;
  return mycurs;
end; 
$$;


ALTER FUNCTION utap.get_accesses(my_node_id integer) OWNER TO utap;

--
-- Name: get_children(utap.ltree, integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_children(mypath utap.ltree, mylevel integer, my_framework_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select * 
      from node_v nv
    where nv.path <@ mypath
      and nv.level = mylevel
      and nv.framework_id = my_framework_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_children(mypath utap.ltree, mylevel integer, my_framework_id integer) OWNER TO utap;

--
-- Name: get_collection_reqs(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_collection_reqs(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select * 
      from collection_req_v crv
     where crv.node_id = my_node_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_collection_reqs(my_node_id integer) OWNER TO utap;

--
-- Name: get_framework_nodes(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_framework_nodes(_framework_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select *
      from node_v nv
    where nv.framework_id = _framework_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_framework_nodes(_framework_id integer) OWNER TO utap;

--
-- Name: get_node(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_node(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select *
      from node_v nv
    where nv.id = my_node_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_node(my_node_id integer) OWNER TO utap;

--
-- Name: get_node_ids(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_node_ids(_framework_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select node_id 
      from framework_nodes
     where framework_id = _framework_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_node_ids(_framework_id integer) OWNER TO utap;

--
-- Name: get_node_selectors(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_node_selectors(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select * 
      from node_selectors ns
    where ns.node_id = my_node_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_node_selectors(my_node_id integer) OWNER TO utap;

--
-- Name: get_node_sources(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_node_sources(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select ns.link,
           ns.comments,
           s.id as source_id,
           s.name as source_name
      from sources s,
           node_sources ns
     where ns.node_id = my_node_id
       and s.id = ns.source_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_node_sources(my_node_id integer) OWNER TO utap;

--
-- Name: get_node_tags(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_node_tags(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select t.id,
           t.name
      from tags t,
           node_tags nt
     where nt.node_id = my_node_id
       and t.id = nt.tag_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_node_tags(my_node_id integer) OWNER TO utap;

--
-- Name: get_process(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_process(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select * 
      from node_processes np
     where np.node_id = my_node_id;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_process(my_node_id integer) OWNER TO utap;

--
-- Name: get_root_node(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_root_node(fw_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
declare
  mycurs refcursor;
begin
  open mycurs for 
    select *
      from node_v nv
    where nv.framework_id = fw_id
    order by nv.path
    limit 1;
  return mycurs;
end; $$;


ALTER FUNCTION utap.get_root_node(fw_id integer) OWNER TO utap;

--
-- Name: get_signatures(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_signatures(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$

declare
  mycurs refcursor;
begin
  open mycurs for 
    select * 
      from signature_v sv
     where sv.node_id = my_node_id;
  return mycurs;
end; 
$$;


ALTER FUNCTION utap.get_signatures(my_node_id integer) OWNER TO utap;

--
-- Name: get_vulnerabilities(integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.get_vulnerabilities(my_node_id integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$

declare
  mycurs refcursor;
begin
  open mycurs for 
    select * 
      from vulnerability_v nv
     where nv.node_id = my_node_id;
  return mycurs;
end; 
$$;


ALTER FUNCTION utap.get_vulnerabilities(my_node_id integer) OWNER TO utap;

--
-- Name: node_acc_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_acc_exists(_node_id integer, _acc_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select na.id
     from node_accesses na
    where na.id = _acc_id
      and na.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_acc_exists(_node_id integer, _acc_id integer) OWNER TO utap;

--
-- Name: node_collection_concept_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_collection_concept_exists(_node_id integer, _cc_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select ncc.collection_concept_id
     from node_collection_concepts ncc
    where ncc.collection_concept_id = _cc_id
      and ncc.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_collection_concept_exists(_node_id integer, _cc_id integer) OWNER TO utap;

--
-- Name: node_collection_req_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_collection_req_exists(_node_id integer, _req_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select ncr.id
     from node_collection_reqs ncr
    where ncr.id = _req_id
      and ncr.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_collection_req_exists(_node_id integer, _req_id integer) OWNER TO utap;

--
-- Name: node_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_exists(_framework_id integer, _node_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select fn.node_id 
     from framework_nodes fn
    where fn.framework_id = _framework_id
      and fn.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_exists(_framework_id integer, _node_id integer) OWNER TO utap;

--
-- Name: node_location_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_location_exists(_node_id integer, _location_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select nl.id
     from node_locations nl
    where nl.id = _location_id
      and nl.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_location_exists(_node_id integer, _location_id integer) OWNER TO utap;

--
-- Name: node_name_exists(integer, text); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_name_exists(my_framework_id integer, my_node_name text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(select n.name 
                  from node n,
                       framework_nodes fn
                 where fn.framework_id = my_framework_id 
                   and n.id = fn.node_id
                   and n.name = my_node_name
                  )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_name_exists(my_framework_id integer, my_node_name text) OWNER TO utap;

--
-- Name: node_path_exists(integer, utap.ltree); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_path_exists(_framework_id integer, _path utap.ltree) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select n.path
     from node n,
          framework_nodes fn
    where fn.framework_id = _framework_id
      and n.id = fn.node_id
      and n.path = _path
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_path_exists(_framework_id integer, _path utap.ltree) OWNER TO utap;

--
-- Name: node_process_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_process_exists(_node_id integer, _proc_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select np.id
     from node_processes np
    where np.id = _proc_id
      and np.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_process_exists(_node_id integer, _proc_id integer) OWNER TO utap;

--
-- Name: node_selector_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_selector_exists(_node_id integer, _selector_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select ns.id
     from node_selectors ns 
    where ns.id = _selector_id
      and ns.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_selector_exists(_node_id integer, _selector_id integer) OWNER TO utap;

--
-- Name: node_sig_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_sig_exists(_node_id integer, _sig_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select ns.id
     from node_signatures ns
    where ns.id = _sig_id
      and ns.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_sig_exists(_node_id integer, _sig_id integer) OWNER TO utap;

--
-- Name: node_source_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_source_exists(_node_id integer, _source_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select ns.source_id
     from node_sources ns 
    where ns.source_id = _source_id
      and ns.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_source_exists(_node_id integer, _source_id integer) OWNER TO utap;

--
-- Name: node_tag_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_tag_exists(_node_id integer, _tag_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select nt.tag_id
     from node_tags nt 
    where nt.tag_id = _tag_id
      and nt.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_tag_exists(_node_id integer, _tag_id integer) OWNER TO utap;

--
-- Name: node_vul_exists(integer, integer); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.node_vul_exists(_node_id integer, _vul_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
  flag boolean;
begin
  select exists(
   select nv.id
     from node_vulnerabilities nv
    where nv.id = _vul_id
      and nv.node_id = _node_id
      )
    into flag;
  return flag;
end; $$;


ALTER FUNCTION utap.node_vul_exists(_node_id integer, _vul_id integer) OWNER TO utap;

--
-- Name: prune_concept_carver_scores(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_concept_carver_scores(_collection_concept_id integer, _carver_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select carver_id
      from concept_carver_scores
     where collection_concept_id = _collection_concept_id
       and not (carver_id = ANY(_carver_ids))
  ) into prune_arr;

  with a as(
  delete 
    from concept_carver_scores
   where carver_id = ANY(prune_arr)
     and collection_concept_id = _collection_concept_id
   returning carver_id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_concept_carver_scores(_collection_concept_id integer, _carver_ids integer[]) OWNER TO utap;

--
-- Name: prune_framework(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_framework(_framework_id integer, _node_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select node_id 
      from framework_nodes
     where framework_id = _framework_id
       and not (node_id = ANY(_node_ids))
  ) into prune_arr;

  row_cnt = delete_nodes_cascade(prune_arr);

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_framework(_framework_id integer, _node_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_acc(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_acc(_node_id integer, _vsa_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select id
      from node_accesses
     where node_id = _node_id
       and not (id = ANY(_vsa_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_accesses
   where id = ANY(prune_arr)
     and node_id = _node_id
   returning id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_acc(_node_id integer, _vsa_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_collection_concepts(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_collection_concepts(_node_id integer, _cc_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select collection_concept_id
      from node_collection_concepts
     where node_id = _node_id
       and not (collection_concept_id = ANY(_cc_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_collection_concepts
   where collection_concept_id = ANY(prune_arr)
     and node_id = _node_id
   returning collection_concept_id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_collection_concepts(_node_id integer, _cc_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_collection_reqs(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_collection_reqs(_node_id integer, _req_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select id 
      from node_collection_reqs
     where node_id = _node_id
       and not (id = ANY(_req_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_collection_reqs
   where id = ANY(prune_arr)
     and node_id = _node_id
   returning id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_collection_reqs(_node_id integer, _req_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_locations(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_locations(_node_id integer, _loc_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select id 
      from node_locations
     where node_id = _node_id
       and not (id = ANY(_loc_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_locations
   where id = ANY(prune_arr)
     and node_id = _node_id
   returning id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_locations(_node_id integer, _loc_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_processes(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_processes(_node_id integer, _proc_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select id 
      from node_processes
     where node_id = _node_id
       and not (id = ANY(_proc_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_processes
   where id = ANY(prune_arr)
     and node_id = _node_id
   returning id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_processes(_node_id integer, _proc_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_selectors(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_selectors(_node_id integer, _selector_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select id 
      from node_selectors
     where node_id = _node_id
       and not (id = ANY(_selector_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_selectors
   where id = ANY(prune_arr)
   returning id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_selectors(_node_id integer, _selector_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_sig(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_sig(_node_id integer, _vsa_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select id
      from node_signatures
     where node_id = _node_id
       and not (id = ANY(_vsa_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_signatures
   where id = ANY(prune_arr)
     and node_id = _node_id
   returning id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_sig(_node_id integer, _vsa_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_sources(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_sources(_node_id integer, _source_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select source_id 
      from node_sources
     where node_id = _node_id
       and not (source_id = ANY(_source_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_sources
   where source_id = ANY(prune_arr)
     and node_id = _node_id
   returning source_id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_sources(_node_id integer, _source_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_tags(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_tags(_node_id integer, _tag_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select tag_id 
      from node_tags
     where node_id = _node_id
       and not (tag_id = ANY(_tag_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_tags
   where tag_id = ANY(prune_arr)
     and node_id = _node_id
   returning tag_id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_tags(_node_id integer, _tag_ids integer[]) OWNER TO utap;

--
-- Name: prune_node_vul(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_node_vul(_node_id integer, _vsa_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin

  select array(
    select id
      from node_vulnerabilities
     where node_id = _node_id
       and not (id = ANY(_vsa_ids))
  ) into prune_arr;

  with a as(
  delete 
    from node_vulnerabilities
   where id = ANY(prune_arr)
     and node_id = _node_id
   returning id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_node_vul(_node_id integer, _vsa_ids integer[]) OWNER TO utap;

--
-- Name: prune_related_nodes(integer, integer[]); Type: FUNCTION; Schema: utap; Owner: utap
--

CREATE FUNCTION utap.prune_related_nodes(_node_id integer, _rel_ids integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  row_cnt int;
  prune_arr int array;
begin
  select array(
    select related_node_id
      from related_nodes
     where node_id = _node_id
       and not (related_node_id = ANY(_rel_ids))
  ) into prune_arr;

  with a as(
  delete 
    from related_nodes
   where related_node_id = ANY(prune_arr)
     and node_id = _node_id
   returning related_node_id
  ) select count(*) into row_cnt from a;

  return row_cnt;
end; $$;


ALTER FUNCTION utap.prune_related_nodes(_node_id integer, _rel_ids integer[]) OWNER TO utap;

--
-- Name: carver_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.carver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.carver_id_seq OWNER TO utap;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: carver; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.carver (
    id integer DEFAULT nextval('utap.carver_id_seq'::regclass) NOT NULL,
    value text,
    score integer,
    description text
);


ALTER TABLE utap.carver OWNER TO utap;

--
-- Name: concept_carver_scores_carver_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.concept_carver_scores_carver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.concept_carver_scores_carver_id_seq OWNER TO utap;

--
-- Name: concept_carver_scores_collection_concept_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.concept_carver_scores_collection_concept_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.concept_carver_scores_collection_concept_id_seq OWNER TO utap;

--
-- Name: concept_carver_scores; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.concept_carver_scores (
    collection_concept_id integer DEFAULT nextval('utap.concept_carver_scores_collection_concept_id_seq'::regclass) NOT NULL,
    carver_id integer DEFAULT nextval('utap.concept_carver_scores_carver_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.concept_carver_scores OWNER TO utap;

--
-- Name: carver_scores_v; Type: VIEW; Schema: utap; Owner: utap
--

CREATE VIEW utap.carver_scores_v AS
 SELECT ccs.collection_concept_id,
    c.id AS carver_id,
    c.value,
    c.score
   FROM utap.concept_carver_scores ccs,
    utap.carver c
  WHERE (ccs.carver_id = c.id);


ALTER TABLE utap.carver_scores_v OWNER TO utap;

--
-- Name: collection_concepts_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.collection_concepts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.collection_concepts_id_seq OWNER TO utap;

--
-- Name: collection_concepts; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.collection_concepts (
    id integer DEFAULT nextval('utap.collection_concepts_id_seq'::regclass) NOT NULL,
    name text
);


ALTER TABLE utap.collection_concepts OWNER TO utap;

--
-- Name: collection_concept_v; Type: VIEW; Schema: utap; Owner: utap
--

CREATE VIEW utap.collection_concept_v AS
 SELECT cc.id AS collection_concept_id,
    cc.name AS collection_concept_name,
    array_to_json(array_agg(row_to_json(csv.*))) AS carver_scores
   FROM utap.collection_concepts cc,
    utap.carver_scores_v csv
  WHERE (csv.collection_concept_id = cc.id)
  GROUP BY cc.id, cc.name;


ALTER TABLE utap.collection_concept_v OWNER TO utap;

--
-- Name: collection_req_type_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.collection_req_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.collection_req_type_id_seq OWNER TO utap;

--
-- Name: collection_req_type; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.collection_req_type (
    id integer DEFAULT nextval('utap.collection_req_type_id_seq'::regclass) NOT NULL,
    name text
);


ALTER TABLE utap.collection_req_type OWNER TO utap;

--
-- Name: node_collection_reqs_collection_req_type_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_collection_reqs_collection_req_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_collection_reqs_collection_req_type_id_seq OWNER TO utap;

--
-- Name: node_collection_reqs_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_collection_reqs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_collection_reqs_id_seq OWNER TO utap;

--
-- Name: node_collection_reqs_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_collection_reqs_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_collection_reqs_node_id_seq OWNER TO utap;

--
-- Name: node_collection_reqs; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_collection_reqs (
    id integer DEFAULT nextval('utap.node_collection_reqs_id_seq'::regclass) NOT NULL,
    node_id integer DEFAULT nextval('utap.node_collection_reqs_node_id_seq'::regclass) NOT NULL,
    collection_req_type_id integer DEFAULT nextval('utap.node_collection_reqs_collection_req_type_id_seq'::regclass) NOT NULL,
    link text,
    user_comments text,
    collection_flag boolean
);


ALTER TABLE utap.node_collection_reqs OWNER TO utap;

--
-- Name: collection_req_v; Type: VIEW; Schema: utap; Owner: utap
--

CREATE VIEW utap.collection_req_v AS
 SELECT ncr.id,
    ncr.node_id,
    ncr.link,
    ncr.user_comments,
    ncr.collection_flag,
    crt.id AS collection_req_type_id,
    crt.name AS collection_req_type_name
   FROM utap.collection_req_type crt,
    utap.node_collection_reqs ncr
  WHERE (crt.id = ncr.collection_req_type_id);


ALTER TABLE utap.collection_req_v OWNER TO utap;

--
-- Name: countries; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.countries (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE utap.countries OWNER TO utap;

--
-- Name: framework_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.framework_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.framework_id_seq OWNER TO utap;

--
-- Name: framework; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.framework (
    id integer DEFAULT nextval('utap.framework_id_seq'::regclass) NOT NULL,
    name text,
    description text,
    created_by text,
    updated_by text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


ALTER TABLE utap.framework OWNER TO utap;

--
-- Name: framework_nodes_framework_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.framework_nodes_framework_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.framework_nodes_framework_id_seq OWNER TO utap;

--
-- Name: framework_nodes_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.framework_nodes_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.framework_nodes_node_id_seq OWNER TO utap;

--
-- Name: framework_nodes; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.framework_nodes (
    framework_id integer DEFAULT nextval('utap.framework_nodes_framework_id_seq'::regclass) NOT NULL,
    node_id integer DEFAULT nextval('utap.framework_nodes_node_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.framework_nodes OWNER TO utap;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.permissions_id_seq OWNER TO utap;

--
-- Name: permissions; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.permissions (
    id integer DEFAULT nextval('utap.permissions_id_seq'::regclass) NOT NULL,
    name text
);


ALTER TABLE utap.permissions OWNER TO utap;

--
-- Name: user_permissions_framework_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.user_permissions_framework_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.user_permissions_framework_id_seq OWNER TO utap;

--
-- Name: user_permissions_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.user_permissions_id_seq OWNER TO utap;

--
-- Name: user_permissions_permissions_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.user_permissions_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.user_permissions_permissions_id_seq OWNER TO utap;

--
-- Name: user_permissions_users_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.user_permissions_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.user_permissions_users_id_seq OWNER TO utap;

--
-- Name: user_permissions_bak; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.user_permissions_bak (
    id integer DEFAULT nextval('utap.user_permissions_id_seq'::regclass) NOT NULL,
    user_id integer DEFAULT nextval('utap.user_permissions_users_id_seq'::regclass) NOT NULL,
    permissions_id integer DEFAULT nextval('utap.user_permissions_permissions_id_seq'::regclass) NOT NULL,
    framework_id integer DEFAULT nextval('utap.user_permissions_framework_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.user_permissions_bak OWNER TO utap;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.users_id_seq OWNER TO utap;

--
-- Name: users; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.users (
    id integer DEFAULT nextval('utap.users_id_seq'::regclass) NOT NULL,
    dn text
);


ALTER TABLE utap.users OWNER TO utap;

--
-- Name: framework_permissions_v; Type: VIEW; Schema: utap; Owner: utap
--

CREATE VIEW utap.framework_permissions_v AS
 SELECT u.dn,
    up.framework_id,
    array_agg(p.name) AS permissions
   FROM ((utap.user_permissions_bak up
     JOIN utap.permissions p ON ((p.id = up.permissions_id)))
     JOIN utap.users u ON ((u.id = up.user_id)))
  GROUP BY u.dn, up.framework_id;


ALTER TABLE utap.framework_permissions_v OWNER TO utap;

--
-- Name: node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_id_seq OWNER TO utap;

--
-- Name: node_image_blob_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_image_blob_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_image_blob_seq OWNER TO utap;

--
-- Name: node; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node (
    id integer DEFAULT nextval('utap.node_id_seq'::regclass) NOT NULL,
    name text NOT NULL,
    path utap.ltree NOT NULL,
    created_date timestamp without time zone,
    created_by text,
    updated_date timestamp without time zone,
    updated_by text,
    be_number text,
    be_link text,
    classification text,
    country text,
    description text,
    image_blob integer DEFAULT nextval('utap.node_image_blob_seq'::regclass) NOT NULL,
    has_rfi boolean,
    speculated boolean
);


ALTER TABLE utap.node OWNER TO utap;

--
-- Name: node_accesses_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_accesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_accesses_id_seq OWNER TO utap;

--
-- Name: node_accesses_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_accesses_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_accesses_node_id_seq OWNER TO utap;

--
-- Name: node_accesses_vsa_type_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_accesses_vsa_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_accesses_vsa_type_id_seq OWNER TO utap;

--
-- Name: node_collection_concepts_collection_concept_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_collection_concepts_collection_concept_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_collection_concepts_collection_concept_id_seq OWNER TO utap;

--
-- Name: node_collection_concepts_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_collection_concepts_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_collection_concepts_node_id_seq OWNER TO utap;

--
-- Name: node_collection_concepts; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_collection_concepts (
    node_id integer DEFAULT nextval('utap.node_collection_concepts_node_id_seq'::regclass) NOT NULL,
    collection_concept_id integer DEFAULT nextval('utap.node_collection_concepts_collection_concept_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.node_collection_concepts OWNER TO utap;

--
-- Name: node_collection_concept_v; Type: VIEW; Schema: utap; Owner: utap
--

CREATE VIEW utap.node_collection_concept_v AS
 SELECT ncc.node_id,
    ccv.collection_concept_id,
    ccv.collection_concept_name,
    ccv.carver_scores
   FROM utap.node_collection_concepts ncc,
    utap.collection_concept_v ccv
  WHERE (ccv.collection_concept_id = ncc.collection_concept_id);


ALTER TABLE utap.node_collection_concept_v OWNER TO utap;

--
-- Name: node_locations_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_locations_id_seq OWNER TO utap;

--
-- Name: node_locations_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_locations_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_locations_node_id_seq OWNER TO utap;

--
-- Name: node_locations; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_locations (
    id integer DEFAULT nextval('utap.node_locations_id_seq'::regclass) NOT NULL,
    node_id integer DEFAULT nextval('utap.node_locations_node_id_seq'::regclass) NOT NULL,
    name text,
    lat text,
    lon text,
    comments text
);


ALTER TABLE utap.node_locations OWNER TO utap;

--
-- Name: node_processes_duration_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_processes_duration_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_processes_duration_seq OWNER TO utap;

--
-- Name: node_processes_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_processes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_processes_id_seq OWNER TO utap;

--
-- Name: node_processes_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_processes_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_processes_node_id_seq OWNER TO utap;

--
-- Name: node_processes; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_processes (
    id integer DEFAULT nextval('utap.node_processes_id_seq'::regclass) NOT NULL,
    node_id integer DEFAULT nextval('utap.node_processes_node_id_seq'::regclass) NOT NULL,
    name text,
    sequence_num integer,
    duration integer DEFAULT nextval('utap.node_processes_duration_seq'::regclass) NOT NULL,
    comments text,
    has_rfi boolean
);


ALTER TABLE utap.node_processes OWNER TO utap;

--
-- Name: node_selectors_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_selectors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_selectors_id_seq OWNER TO utap;

--
-- Name: node_selectors_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_selectors_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_selectors_node_id_seq OWNER TO utap;

--
-- Name: node_selectors; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_selectors (
    id integer DEFAULT nextval('utap.node_selectors_id_seq'::regclass) NOT NULL,
    node_id integer DEFAULT nextval('utap.node_selectors_node_id_seq'::regclass) NOT NULL,
    selector text,
    has_rfi boolean
);


ALTER TABLE utap.node_selectors OWNER TO utap;

--
-- Name: node_signatures_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_signatures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_signatures_id_seq OWNER TO utap;

--
-- Name: node_signatures_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_signatures_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_signatures_node_id_seq OWNER TO utap;

--
-- Name: node_signatures_vsa_type_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_signatures_vsa_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_signatures_vsa_type_id_seq OWNER TO utap;

--
-- Name: node_sources_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_sources_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_sources_node_id_seq OWNER TO utap;

--
-- Name: node_sources_source_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_sources_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_sources_source_id_seq OWNER TO utap;

--
-- Name: node_sources; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_sources (
    node_id integer DEFAULT nextval('utap.node_sources_node_id_seq'::regclass) NOT NULL,
    source_id integer DEFAULT nextval('utap.node_sources_source_id_seq'::regclass) NOT NULL,
    link text,
    doc_blob text,
    comments text
);


ALTER TABLE utap.node_sources OWNER TO utap;

--
-- Name: node_tags_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_tags_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_tags_node_id_seq OWNER TO utap;

--
-- Name: node_tags_tag_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_tags_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_tags_tag_id_seq OWNER TO utap;

--
-- Name: node_tags; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_tags (
    node_id integer DEFAULT nextval('utap.node_tags_node_id_seq'::regclass) NOT NULL,
    tag_id integer DEFAULT nextval('utap.node_tags_tag_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.node_tags OWNER TO utap;

--
-- Name: node_types_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_types_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_types_node_id_seq OWNER TO utap;

--
-- Name: node_types_node_type_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_types_node_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_types_node_type_id_seq OWNER TO utap;

--
-- Name: node_types; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_types (
    node_id integer DEFAULT nextval('utap.node_types_node_id_seq'::regclass) NOT NULL,
    node_type_id integer DEFAULT nextval('utap.node_types_node_type_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.node_types OWNER TO utap;

--
-- Name: node_vsa; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.node_vsa (
    node_id integer NOT NULL,
    vsa_id integer
);


ALTER TABLE utap.node_vsa OWNER TO utap;

--
-- Name: node_vsa_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_vsa_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE utap.node_vsa_node_id_seq OWNER TO utap;

--
-- Name: node_vsa_node_id_seq; Type: SEQUENCE OWNED BY; Schema: utap; Owner: utap
--

ALTER SEQUENCE utap.node_vsa_node_id_seq OWNED BY utap.node_vsa.node_id;


--
-- Name: node_vulnerabilities_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_vulnerabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_vulnerabilities_id_seq OWNER TO utap;

--
-- Name: node_vulnerabilities_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_vulnerabilities_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_vulnerabilities_node_id_seq OWNER TO utap;

--
-- Name: node_vulnerabilities_vsa_type_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.node_vulnerabilities_vsa_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.node_vulnerabilities_vsa_type_id_seq OWNER TO utap;

--
-- Name: related_nodes_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.related_nodes_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.related_nodes_node_id_seq OWNER TO utap;

--
-- Name: related_nodes_related_node_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.related_nodes_related_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.related_nodes_related_node_id_seq OWNER TO utap;

--
-- Name: related_nodes; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.related_nodes (
    node_id integer DEFAULT nextval('utap.related_nodes_node_id_seq'::regclass) NOT NULL,
    related_node_id integer DEFAULT nextval('utap.related_nodes_related_node_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.related_nodes OWNER TO utap;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.roles_id_seq OWNER TO utap;

--
-- Name: roles; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.roles (
    id integer DEFAULT nextval('utap.roles_id_seq'::regclass) NOT NULL,
    name text
);


ALTER TABLE utap.roles OWNER TO utap;

--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.sources_id_seq OWNER TO utap;

--
-- Name: sources; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.sources (
    id integer DEFAULT nextval('utap.sources_id_seq'::regclass) NOT NULL,
    name text
);


ALTER TABLE utap.sources OWNER TO utap;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.tags_id_seq OWNER TO utap;

--
-- Name: tags; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.tags (
    id integer DEFAULT nextval('utap.tags_id_seq'::regclass) NOT NULL,
    name text
);


ALTER TABLE utap.tags OWNER TO utap;

--
-- Name: template_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.template_id_seq OWNER TO utap;

--
-- Name: template; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.template (
    id integer DEFAULT nextval('utap.template_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.template OWNER TO utap;

--
-- Name: template_nodes_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.template_nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.template_nodes_id_seq OWNER TO utap;

--
-- Name: template_nodes_name_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.template_nodes_name_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.template_nodes_name_seq OWNER TO utap;

--
-- Name: template_nodes_template_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.template_nodes_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.template_nodes_template_id_seq OWNER TO utap;

--
-- Name: template_nodes; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.template_nodes (
    id integer DEFAULT nextval('utap.template_nodes_id_seq'::regclass) NOT NULL,
    template_id integer DEFAULT nextval('utap.template_nodes_template_id_seq'::regclass) NOT NULL,
    name integer DEFAULT nextval('utap.template_nodes_name_seq'::regclass) NOT NULL,
    path utap.ltree NOT NULL
);


ALTER TABLE utap.template_nodes OWNER TO utap;

--
-- Name: type_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.type_id_seq OWNER TO utap;

--
-- Name: type; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.type (
    id integer DEFAULT nextval('utap.type_id_seq'::regclass) NOT NULL,
    name text
);


ALTER TABLE utap.type OWNER TO utap;

--
-- Name: user_permissions; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.user_permissions (
    user_id integer DEFAULT nextval('utap.user_permissions_users_id_seq'::regclass) NOT NULL,
    permissions_id integer DEFAULT nextval('utap.user_permissions_permissions_id_seq'::regclass) NOT NULL,
    framework_id integer DEFAULT nextval('utap.user_permissions_framework_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.user_permissions OWNER TO utap;

--
-- Name: user_roles_roles_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.user_roles_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.user_roles_roles_id_seq OWNER TO utap;

--
-- Name: user_roles_users_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.user_roles_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.user_roles_users_id_seq OWNER TO utap;

--
-- Name: user_roles; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.user_roles (
    roles_id integer DEFAULT nextval('utap.user_roles_roles_id_seq'::regclass) NOT NULL,
    user_id integer DEFAULT nextval('utap.user_roles_users_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.user_roles OWNER TO utap;

--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.user_roles_id_seq OWNER TO utap;

--
-- Name: user_roles_bak; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.user_roles_bak (
    id integer DEFAULT nextval('utap.user_roles_id_seq'::regclass) NOT NULL,
    roles_id integer DEFAULT nextval('utap.user_roles_roles_id_seq'::regclass) NOT NULL,
    user_id integer DEFAULT nextval('utap.user_roles_users_id_seq'::regclass) NOT NULL
);


ALTER TABLE utap.user_roles_bak OWNER TO utap;

--
-- Name: users_v; Type: VIEW; Schema: utap; Owner: utap
--

CREATE VIEW utap.users_v AS
 SELECT u.dn,
    r.name AS role
   FROM ((utap.user_roles_bak ur
     JOIN utap.roles r ON ((r.id = ur.roles_id)))
     JOIN utap.users u ON ((u.id = ur.user_id)));


ALTER TABLE utap.users_v OWNER TO utap;

--
-- Name: vsa; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.vsa (
    id integer NOT NULL,
    vsa_type_id integer,
    vsa_category_id integer,
    description text
);


ALTER TABLE utap.vsa OWNER TO utap;

--
-- Name: vsa_category; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.vsa_category (
    id integer NOT NULL,
    value text
);


ALTER TABLE utap.vsa_category OWNER TO utap;

--
-- Name: vsa_category_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.vsa_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE utap.vsa_category_id_seq OWNER TO utap;

--
-- Name: vsa_category_id_seq; Type: SEQUENCE OWNED BY; Schema: utap; Owner: utap
--

ALTER SEQUENCE utap.vsa_category_id_seq OWNED BY utap.vsa_category.id;


--
-- Name: vsa_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.vsa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE utap.vsa_id_seq OWNER TO utap;

--
-- Name: vsa_id_seq; Type: SEQUENCE OWNED BY; Schema: utap; Owner: utap
--

ALTER SEQUENCE utap.vsa_id_seq OWNED BY utap.vsa.id;


--
-- Name: vsa_type_id_seq; Type: SEQUENCE; Schema: utap; Owner: utap
--

CREATE SEQUENCE utap.vsa_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE utap.vsa_type_id_seq OWNER TO utap;

--
-- Name: vsa_type; Type: TABLE; Schema: utap; Owner: utap
--

CREATE TABLE utap.vsa_type (
    id integer DEFAULT nextval('utap.vsa_type_id_seq'::regclass) NOT NULL,
    value text
);


ALTER TABLE utap.vsa_type OWNER TO utap;

--
-- Name: node_vsa node_id; Type: DEFAULT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_vsa ALTER COLUMN node_id SET DEFAULT nextval('utap.node_vsa_node_id_seq'::regclass);


--
-- Name: vsa id; Type: DEFAULT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.vsa ALTER COLUMN id SET DEFAULT nextval('utap.vsa_id_seq'::regclass);


--
-- Name: vsa_category id; Type: DEFAULT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.vsa_category ALTER COLUMN id SET DEFAULT nextval('utap.vsa_category_id_seq'::regclass);


--
-- Name: carver carver_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.carver
    ADD CONSTRAINT carver_pk PRIMARY KEY (id);


--
-- Name: collection_concepts collection_concepts_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.collection_concepts
    ADD CONSTRAINT collection_concepts_pk PRIMARY KEY (id);


--
-- Name: collection_req_type collection_req_type_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.collection_req_type
    ADD CONSTRAINT collection_req_type_pk PRIMARY KEY (id);


--
-- Name: concept_carver_scores concept_carver_scores_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.concept_carver_scores
    ADD CONSTRAINT concept_carver_scores_pk PRIMARY KEY (collection_concept_id, carver_id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: framework_nodes framework_nodes_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.framework_nodes
    ADD CONSTRAINT framework_nodes_pk PRIMARY KEY (framework_id, node_id);


--
-- Name: framework framework_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.framework
    ADD CONSTRAINT framework_pk PRIMARY KEY (id);


--
-- Name: node_collection_concepts node_collection_concepts_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_collection_concepts
    ADD CONSTRAINT node_collection_concepts_pk PRIMARY KEY (node_id, collection_concept_id);


--
-- Name: node_collection_reqs node_collection_reqs_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_collection_reqs
    ADD CONSTRAINT node_collection_reqs_pk PRIMARY KEY (id);


--
-- Name: node_locations node_locations_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_locations
    ADD CONSTRAINT node_locations_pk PRIMARY KEY (id);


--
-- Name: node node_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node
    ADD CONSTRAINT node_pk PRIMARY KEY (id);


--
-- Name: node_processes node_process_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_processes
    ADD CONSTRAINT node_process_pk PRIMARY KEY (id);


--
-- Name: node_selectors node_selectors_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_selectors
    ADD CONSTRAINT node_selectors_pk PRIMARY KEY (id);


--
-- Name: node_sources node_sources_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_sources
    ADD CONSTRAINT node_sources_pk PRIMARY KEY (node_id, source_id);


--
-- Name: node_tags node_tags_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_tags
    ADD CONSTRAINT node_tags_pk PRIMARY KEY (node_id, tag_id);


--
-- Name: type node_type_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.type
    ADD CONSTRAINT node_type_pk PRIMARY KEY (id);


--
-- Name: node_types node_types_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_types
    ADD CONSTRAINT node_types_pk PRIMARY KEY (node_id, node_type_id);


--
-- Name: permissions permissions_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.permissions
    ADD CONSTRAINT permissions_pk PRIMARY KEY (id);


--
-- Name: related_nodes related_nodes_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.related_nodes
    ADD CONSTRAINT related_nodes_pk PRIMARY KEY (node_id, related_node_id);


--
-- Name: roles roles_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.roles
    ADD CONSTRAINT roles_pk PRIMARY KEY (id);


--
-- Name: sources sources_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.sources
    ADD CONSTRAINT sources_pk PRIMARY KEY (id);


--
-- Name: tags tags_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.tags
    ADD CONSTRAINT tags_pk PRIMARY KEY (id);


--
-- Name: template_nodes template_nodes_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.template_nodes
    ADD CONSTRAINT template_nodes_pk PRIMARY KEY (id);


--
-- Name: template template_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.template
    ADD CONSTRAINT template_pk PRIMARY KEY (id);


--
-- Name: users user_id_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.users
    ADD CONSTRAINT user_id_pk PRIMARY KEY (id);


--
-- Name: user_permissions user_permissions_new_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_permissions
    ADD CONSTRAINT user_permissions_new_pk PRIMARY KEY (user_id, permissions_id, framework_id);


--
-- Name: user_permissions_bak user_permissions_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_permissions_bak
    ADD CONSTRAINT user_permissions_pk PRIMARY KEY (id);


--
-- Name: user_roles user_roles_new_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_roles
    ADD CONSTRAINT user_roles_new_pk PRIMARY KEY (roles_id, user_id);


--
-- Name: user_roles_bak user_roles_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_roles_bak
    ADD CONSTRAINT user_roles_pk PRIMARY KEY (id);


--
-- Name: vsa_category vsa_category_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.vsa_category
    ADD CONSTRAINT vsa_category_pk PRIMARY KEY (id);


--
-- Name: vsa vsa_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.vsa
    ADD CONSTRAINT vsa_pk PRIMARY KEY (id);


--
-- Name: vsa_type vsa_type_pk; Type: CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.vsa_type
    ADD CONSTRAINT vsa_type_pk PRIMARY KEY (id);


--
-- Name: concept_carver_scores con_carv_sc_node_coll_cons_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.concept_carver_scores
    ADD CONSTRAINT con_carv_sc_node_coll_cons_fk FOREIGN KEY (carver_id) REFERENCES utap.carver(id);


--
-- Name: concept_carver_scores con_carver_scores_coll_con_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.concept_carver_scores
    ADD CONSTRAINT con_carver_scores_coll_con_fk FOREIGN KEY (collection_concept_id) REFERENCES utap.collection_concepts(id) ON DELETE CASCADE;


--
-- Name: framework_nodes framework_nodes_framework_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.framework_nodes
    ADD CONSTRAINT framework_nodes_framework_fk FOREIGN KEY (framework_id) REFERENCES utap.framework(id) ON DELETE CASCADE;


--
-- Name: framework_nodes framework_nodes_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.framework_nodes
    ADD CONSTRAINT framework_nodes_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) ON DELETE CASCADE;


--
-- Name: node_vsa n_id_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_vsa
    ADD CONSTRAINT n_id_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) MATCH FULL;


--
-- Name: node_types n_types_n_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_types
    ADD CONSTRAINT n_types_n_fk FOREIGN KEY (node_id) REFERENCES utap.node(id);


--
-- Name: node_vsa n_vsa_vsa_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_vsa
    ADD CONSTRAINT n_vsa_vsa_fk FOREIGN KEY (vsa_id) REFERENCES utap.vsa(id) MATCH FULL;


--
-- Name: node_collection_reqs node_col_reqs_col_req_type_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_collection_reqs
    ADD CONSTRAINT node_col_reqs_col_req_type_fk FOREIGN KEY (collection_req_type_id) REFERENCES utap.collection_req_type(id);


--
-- Name: node_collection_concepts node_coll_con_coll_con_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_collection_concepts
    ADD CONSTRAINT node_coll_con_coll_con_fk FOREIGN KEY (collection_concept_id) REFERENCES utap.collection_concepts(id) ON DELETE CASCADE;


--
-- Name: node_collection_concepts node_coll_con_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_collection_concepts
    ADD CONSTRAINT node_coll_con_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) ON DELETE CASCADE;


--
-- Name: node_collection_reqs node_collection_reqs_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_collection_reqs
    ADD CONSTRAINT node_collection_reqs_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) ON DELETE CASCADE;


--
-- Name: node_locations node_locations_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_locations
    ADD CONSTRAINT node_locations_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) ON DELETE CASCADE;


--
-- Name: node_processes node_process_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_processes
    ADD CONSTRAINT node_process_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) ON DELETE CASCADE;


--
-- Name: node_selectors node_selectors_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_selectors
    ADD CONSTRAINT node_selectors_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) ON DELETE CASCADE;


--
-- Name: node_sources node_sources_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_sources
    ADD CONSTRAINT node_sources_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) ON DELETE CASCADE;


--
-- Name: node_sources node_sources_sources_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_sources
    ADD CONSTRAINT node_sources_sources_fk FOREIGN KEY (source_id) REFERENCES utap.sources(id);


--
-- Name: node_tags node_tags_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_tags
    ADD CONSTRAINT node_tags_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id) ON DELETE CASCADE;


--
-- Name: node_tags node_tags_tags_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_tags
    ADD CONSTRAINT node_tags_tags_fk FOREIGN KEY (tag_id) REFERENCES utap.tags(id);


--
-- Name: node_types node_types_type_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.node_types
    ADD CONSTRAINT node_types_type_fk FOREIGN KEY (node_type_id) REFERENCES utap.type(id);


--
-- Name: related_nodes related_nodes_node_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.related_nodes
    ADD CONSTRAINT related_nodes_node_fk FOREIGN KEY (node_id) REFERENCES utap.node(id);


--
-- Name: related_nodes related_nodes_node_fkv1; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.related_nodes
    ADD CONSTRAINT related_nodes_node_fkv1 FOREIGN KEY (related_node_id) REFERENCES utap.node(id);


--
-- Name: template_nodes template_nodes_template_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.template_nodes
    ADD CONSTRAINT template_nodes_template_fk FOREIGN KEY (template_id) REFERENCES utap.template(id);


--
-- Name: user_permissions_bak user_permissions_framework_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_permissions_bak
    ADD CONSTRAINT user_permissions_framework_fk FOREIGN KEY (framework_id) REFERENCES utap.framework(id) ON DELETE CASCADE;


--
-- Name: user_permissions user_permissions_new_framework_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_permissions
    ADD CONSTRAINT user_permissions_new_framework_fk FOREIGN KEY (framework_id) REFERENCES utap.framework(id) ON DELETE CASCADE;


--
-- Name: user_permissions user_permissions_new_permissions_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_permissions
    ADD CONSTRAINT user_permissions_new_permissions_fk FOREIGN KEY (permissions_id) REFERENCES utap.permissions(id);


--
-- Name: user_permissions user_permissions_new_users_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_permissions
    ADD CONSTRAINT user_permissions_new_users_fk FOREIGN KEY (user_id) REFERENCES utap.users(id) ON DELETE CASCADE;


--
-- Name: user_permissions_bak user_permissions_permissions_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_permissions_bak
    ADD CONSTRAINT user_permissions_permissions_fk FOREIGN KEY (permissions_id) REFERENCES utap.permissions(id);


--
-- Name: user_permissions_bak user_permissions_users_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_permissions_bak
    ADD CONSTRAINT user_permissions_users_fk FOREIGN KEY (user_id) REFERENCES utap.users(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_new_roles_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_roles
    ADD CONSTRAINT user_roles_new_roles_fk FOREIGN KEY (roles_id) REFERENCES utap.roles(id);


--
-- Name: user_roles user_roles_new_users_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_roles
    ADD CONSTRAINT user_roles_new_users_fk FOREIGN KEY (user_id) REFERENCES utap.users(id);


--
-- Name: user_roles_bak user_roles_roles_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_roles_bak
    ADD CONSTRAINT user_roles_roles_fk FOREIGN KEY (roles_id) REFERENCES utap.roles(id);


--
-- Name: user_roles_bak user_roles_users_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.user_roles_bak
    ADD CONSTRAINT user_roles_users_fk FOREIGN KEY (user_id) REFERENCES utap.users(id);


--
-- Name: vsa vsa_vsa_cat_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.vsa
    ADD CONSTRAINT vsa_vsa_cat_fk FOREIGN KEY (vsa_category_id) REFERENCES utap.vsa_category(id) MATCH FULL;


--
-- Name: vsa vsa_vsa_type_fk; Type: FK CONSTRAINT; Schema: utap; Owner: utap
--

ALTER TABLE ONLY utap.vsa
    ADD CONSTRAINT vsa_vsa_type_fk FOREIGN KEY (vsa_type_id) REFERENCES utap.vsa_type(id) MATCH FULL;


--
-- PostgreSQL database dump complete
--

