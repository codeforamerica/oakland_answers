--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE articles (
    id integer NOT NULL,
    updated timestamp without time zone,
    title character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    content_type character varying(255),
    preview text,
    tags text,
    slug character varying(255),
    category_id integer,
    access_count integer DEFAULT 0,
    author_name character varying(255),
    author_link character varying(255),
    old_type character varying(255),
    render_markdown boolean DEFAULT true,
    content_main text,
    status character varying(255) DEFAULT 'Draft'::character varying,
    title_es character varying(255),
    preview_es text,
    content_main_es text,
    title_cn character varying(255),
    preview_cn text,
    content_main_cn text
);


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE articles_id_seq OWNED BY articles.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255),
    access_count integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    article_id integer,
    description text,
    slug character varying(255)
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE friendly_id_slugs (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(40),
    created_at timestamp without time zone
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles ALTER COLUMN id SET DEFAULT nextval('articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: index_articles_on_content_main; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_articles_on_content_main ON articles USING gin (to_tsvector('english'::regconfig, content_main));


--
-- Name: index_articles_on_content_main_es; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_articles_on_content_main_es ON articles USING gin (to_tsvector('spanish'::regconfig, content_main_es));


--
-- Name: index_articles_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_articles_on_slug ON articles USING btree (slug);


--
-- Name: index_articles_on_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_articles_on_title ON articles USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: index_articles_on_title_es; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_articles_on_title_es ON articles USING gin (to_tsvector('spanish'::regconfig, (title_es)::text));


--
-- Name: index_categories_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_categories_on_slug ON categories USING btree (slug);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON friendly_id_slugs USING btree (sluggable_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20120416181217');

INSERT INTO schema_migrations (version) VALUES ('20120424172229');

INSERT INTO schema_migrations (version) VALUES ('20120430224632');

INSERT INTO schema_migrations (version) VALUES ('20120430232605');

INSERT INTO schema_migrations (version) VALUES ('20120501181542');

INSERT INTO schema_migrations (version) VALUES ('20120501181544');

INSERT INTO schema_migrations (version) VALUES ('20120501191040');

INSERT INTO schema_migrations (version) VALUES ('20120628194351');

INSERT INTO schema_migrations (version) VALUES ('20120628200512');

INSERT INTO schema_migrations (version) VALUES ('20120628203747');

INSERT INTO schema_migrations (version) VALUES ('20120629070448');

INSERT INTO schema_migrations (version) VALUES ('20120629072846');

INSERT INTO schema_migrations (version) VALUES ('20120629140930');

INSERT INTO schema_migrations (version) VALUES ('20120629143105');

INSERT INTO schema_migrations (version) VALUES ('20120701155314');

INSERT INTO schema_migrations (version) VALUES ('20120702150748');

INSERT INTO schema_migrations (version) VALUES ('20120702150749');

INSERT INTO schema_migrations (version) VALUES ('20120702165334');

INSERT INTO schema_migrations (version) VALUES ('20120702171830');

INSERT INTO schema_migrations (version) VALUES ('20120706171506');

INSERT INTO schema_migrations (version) VALUES ('20120706172717');

INSERT INTO schema_migrations (version) VALUES ('20120706173031');

INSERT INTO schema_migrations (version) VALUES ('20120706193649');

INSERT INTO schema_migrations (version) VALUES ('20120707184743');

INSERT INTO schema_migrations (version) VALUES ('20120707190634');

INSERT INTO schema_migrations (version) VALUES ('20120714144317');

INSERT INTO schema_migrations (version) VALUES ('20120727004822');

INSERT INTO schema_migrations (version) VALUES ('20120727052215');

INSERT INTO schema_migrations (version) VALUES ('20120727124910');

INSERT INTO schema_migrations (version) VALUES ('20120730225526');

INSERT INTO schema_migrations (version) VALUES ('20120807200215');

INSERT INTO schema_migrations (version) VALUES ('20120807233918');

INSERT INTO schema_migrations (version) VALUES ('20120807235112');

INSERT INTO schema_migrations (version) VALUES ('20120817231009');

INSERT INTO schema_migrations (version) VALUES ('20121010140714');

INSERT INTO schema_migrations (version) VALUES ('20121026145929');

INSERT INTO schema_migrations (version) VALUES ('20121028193745');

INSERT INTO schema_migrations (version) VALUES ('20121106123303');

INSERT INTO schema_migrations (version) VALUES ('20121107003920');

INSERT INTO schema_migrations (version) VALUES ('20121107014855');

INSERT INTO schema_migrations (version) VALUES ('20121107020439');

INSERT INTO schema_migrations (version) VALUES ('20121108074632');

INSERT INTO schema_migrations (version) VALUES ('20130703215958');

INSERT INTO schema_migrations (version) VALUES ('20140527211609');

INSERT INTO schema_migrations (version) VALUES ('20140612000350');

INSERT INTO schema_migrations (version) VALUES ('20140612182223');

INSERT INTO schema_migrations (version) VALUES ('20140612215820');

INSERT INTO schema_migrations (version) VALUES ('20140613000708');

INSERT INTO schema_migrations (version) VALUES ('20140613213920');

INSERT INTO schema_migrations (version) VALUES ('20140617002215');

INSERT INTO schema_migrations (version) VALUES ('20140701170735');

INSERT INTO schema_migrations (version) VALUES ('20140702201454');

