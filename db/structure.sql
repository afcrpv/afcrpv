--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
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


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: arrondissements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE arrondissements (
    id integer NOT NULL,
    name character varying(255),
    number integer,
    refinery_crpv_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: arrondissements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE arrondissements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: arrondissements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE arrondissements_id_seq OWNED BY arrondissements.id;


--
-- Name: departements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE departements (
    id integer NOT NULL,
    name character varying(255),
    cp character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    refinery_crpv_id integer
);


--
-- Name: departements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE departements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE departements_id_seq OWNED BY departements.id;


--
-- Name: dossiers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dossiers (
    id integer NOT NULL,
    code_bnpv character varying,
    date_recueil date,
    doublon character varying,
    j_evenement integer,
    m_evenement integer,
    a_evenement integer,
    comm_evenement text,
    gravite character varying,
    evolution character varying,
    commentaire text,
    enquete_id integer,
    evenement_id integer,
    refinery_crpv_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: dossiers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dossiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dossiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dossiers_id_seq OWNED BY dossiers.id;


--
-- Name: enquetes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE enquetes (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: enquetes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE enquetes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enquetes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE enquetes_id_seq OWNED BY enquetes.id;


--
-- Name: evenement_choices; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE evenement_choices (
    id integer NOT NULL,
    enquete_id integer,
    evenement_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: evenement_choices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE evenement_choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evenement_choices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE evenement_choices_id_seq OWNED BY evenement_choices.id;


--
-- Name: evenements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE evenements (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: evenements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE evenements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evenements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE evenements_id_seq OWNED BY evenements.id;


--
-- Name: medicament_choices; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE medicament_choices (
    id integer NOT NULL,
    medicament_id integer,
    enquete_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: medicament_choices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE medicament_choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicament_choices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE medicament_choices_id_seq OWNED BY medicament_choices.id;


--
-- Name: medicaments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE medicaments (
    id integer NOT NULL,
    name character varying(255),
    classe character varying(255),
    forme character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: medicaments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE medicaments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicaments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE medicaments_id_seq OWNED BY medicaments.id;


--
-- Name: meta_type_members; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE meta_type_members (
    id integer NOT NULL,
    meta_type_id integer,
    meta_type_property_id integer,
    "position" integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: meta_type_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE meta_type_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meta_type_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE meta_type_members_id_seq OWNED BY meta_type_members.id;


--
-- Name: meta_type_properties; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE meta_type_properties (
    id integer NOT NULL,
    sid character varying,
    label character varying NOT NULL,
    property_type_sid character varying NOT NULL,
    required boolean DEFAULT false NOT NULL,
    system boolean DEFAULT false NOT NULL,
    dimension character varying,
    default_value character varying,
    choices character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: meta_type_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE meta_type_properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meta_type_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE meta_type_properties_id_seq OWNED BY meta_type_properties.id;


--
-- Name: meta_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE meta_types (
    id integer NOT NULL,
    sid character varying NOT NULL,
    type character varying,
    title character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: meta_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE meta_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meta_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE meta_types_id_seq OWNED BY meta_types.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE patients (
    id integer NOT NULL,
    age integer,
    poids integer,
    taille integer,
    imc integer,
    dossier_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE patients_id_seq OWNED BY patients.id;


--
-- Name: refinery_crpvs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_crpvs (
    id integer NOT NULL,
    name character varying(255),
    adresse text,
    city character varying(255),
    cp character varying(255),
    responsable character varying(255),
    tel character varying(255),
    fax character varying(255),
    email character varying(255),
    website character varying(255),
    bulletin character varying(255),
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    slug character varying(255)
);


--
-- Name: refinery_crpvs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_crpvs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_crpvs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_crpvs_id_seq OWNED BY refinery_crpvs.id;


--
-- Name: refinery_documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_documents (
    id integer NOT NULL,
    titre character varying(255),
    publication date,
    document_category_id integer,
    fichier_id integer,
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_documents_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_documents_categories (
    id integer NOT NULL,
    name character varying(255),
    parent_id integer,
    lft integer,
    rgt integer,
    depth integer,
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_documents_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_documents_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_documents_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_documents_categories_id_seq OWNED BY refinery_documents_categories.id;


--
-- Name: refinery_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_documents_id_seq OWNED BY refinery_documents.id;


--
-- Name: refinery_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_images (
    id integer NOT NULL,
    image_mime_type character varying(255),
    image_name character varying(255),
    image_size integer,
    image_width integer,
    image_height integer,
    image_uid character varying(255),
    image_ext character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_images_id_seq OWNED BY refinery_images.id;


--
-- Name: refinery_inquiries_inquiries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_inquiries_inquiries (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    phone character varying(255),
    message text,
    spam boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_inquiries_inquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_inquiries_inquiries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_inquiries_inquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_inquiries_inquiries_id_seq OWNED BY refinery_inquiries_inquiries.id;


--
-- Name: refinery_membership_email_part_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_membership_email_part_translations (
    id integer NOT NULL,
    refinery_membership_email_part_id integer,
    locale character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_membership_email_part_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_membership_email_part_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_membership_email_part_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_membership_email_part_translations_id_seq OWNED BY refinery_membership_email_part_translations.id;


--
-- Name: refinery_membership_email_parts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_membership_email_parts (
    id integer NOT NULL,
    title character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_membership_email_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_membership_email_parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_membership_email_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_membership_email_parts_id_seq OWNED BY refinery_membership_email_parts.id;


--
-- Name: refinery_membership_email_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_membership_email_translations (
    id integer NOT NULL,
    refinery_membership_email_id integer,
    locale character varying(255),
    subject character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_membership_email_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_membership_email_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_membership_email_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_membership_email_translations_id_seq OWNED BY refinery_membership_email_translations.id;


--
-- Name: refinery_membership_emails; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_membership_emails (
    id integer NOT NULL,
    title character varying(255),
    subject character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_membership_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_membership_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_membership_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_membership_emails_id_seq OWNED BY refinery_membership_emails.id;


--
-- Name: refinery_news_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_news_categories (
    id integer NOT NULL,
    title character varying(255),
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_news_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_news_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_news_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_news_categories_id_seq OWNED BY refinery_news_categories.id;


--
-- Name: refinery_news_item_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_news_item_translations (
    id integer NOT NULL,
    refinery_news_item_id integer,
    locale character varying(255),
    title character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    source character varying(255)
);


--
-- Name: refinery_news_item_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_news_item_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_news_item_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_news_item_translations_id_seq OWNED BY refinery_news_item_translations.id;


--
-- Name: refinery_news_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_news_items (
    id integer NOT NULL,
    title character varying(255),
    body text,
    publish_date timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_id integer,
    expiration_date timestamp without time zone,
    source character varying(255),
    slug character varying(255),
    news_category_id integer
);


--
-- Name: refinery_news_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_news_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_news_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_news_items_id_seq OWNED BY refinery_news_items.id;


--
-- Name: refinery_page_part_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_page_part_translations (
    id integer NOT NULL,
    refinery_page_part_id integer,
    locale character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_page_part_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_page_part_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_page_part_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_page_part_translations_id_seq OWNED BY refinery_page_part_translations.id;


--
-- Name: refinery_page_parts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_page_parts (
    id integer NOT NULL,
    refinery_page_id integer,
    title character varying(255),
    body text,
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_page_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_page_parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_page_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_page_parts_id_seq OWNED BY refinery_page_parts.id;


--
-- Name: refinery_page_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_page_translations (
    id integer NOT NULL,
    refinery_page_id integer,
    locale character varying(255),
    title character varying(255),
    custom_slug character varying(255),
    menu_title character varying(255),
    slug character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_page_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_page_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_page_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_page_translations_id_seq OWNED BY refinery_page_translations.id;


--
-- Name: refinery_pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_pages (
    id integer NOT NULL,
    parent_id integer,
    path character varying(255),
    slug character varying(255),
    show_in_menu boolean DEFAULT true,
    link_url character varying(255),
    menu_match character varying(255),
    deletable boolean DEFAULT true,
    draft boolean DEFAULT false,
    skip_to_first_child boolean DEFAULT false,
    lft integer,
    rgt integer,
    depth integer,
    view_template character varying(255),
    layout_template character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_pages_id_seq OWNED BY refinery_pages.id;


--
-- Name: refinery_pages_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_pages_roles (
    page_id integer,
    role_id integer
);


--
-- Name: refinery_projets_projets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_projets_projets (
    id integer NOT NULL,
    email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    titre character varying(255),
    refinery_crpv_id integer,
    but character varying(255),
    responsable character varying(255),
    exploitant character varying(255),
    date_requete date,
    effet text,
    medicament text,
    contexte text,
    design character varying(255),
    objectif text,
    objectif_sec text,
    champs text,
    debut_inclusion date,
    fin_inclusion date,
    type_inclusion character varying(255),
    criteres_inclusion text,
    criteres_non_inclusion text,
    retombees text,
    slug character varying(255),
    workflow_state character varying(255)
);


--
-- Name: refinery_projets_projets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_projets_projets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_projets_projets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_projets_projets_id_seq OWNED BY refinery_projets_projets.id;


--
-- Name: refinery_resources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_resources (
    id integer NOT NULL,
    file_mime_type character varying(255),
    file_name character varying(255),
    file_size integer,
    file_uid character varying(255),
    file_ext character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_resources_id_seq OWNED BY refinery_resources.id;


--
-- Name: refinery_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_roles (
    id integer NOT NULL,
    title character varying(255)
);


--
-- Name: refinery_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_roles_id_seq OWNED BY refinery_roles.id;


--
-- Name: refinery_roles_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_roles_users (
    user_id integer,
    role_id integer
);


--
-- Name: refinery_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_settings (
    id integer NOT NULL,
    name character varying(255),
    value text,
    destroyable boolean DEFAULT true,
    scoping character varying(255),
    restricted boolean DEFAULT false,
    form_value_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: refinery_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_settings_id_seq OWNED BY refinery_settings.id;


--
-- Name: refinery_user_plugins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_user_plugins (
    id integer NOT NULL,
    user_id integer,
    name character varying(255),
    "position" integer
);


--
-- Name: refinery_user_plugins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_user_plugins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_user_plugins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_user_plugins_id_seq OWNED BY refinery_user_plugins.id;


--
-- Name: refinery_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE refinery_users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    encrypted_password character varying(255) NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    sign_in_count integer,
    remember_created_at timestamp without time zone,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    title character varying(255),
    phone character varying(255),
    fax character varying(255),
    website character varying(255),
    organization character varying(255),
    street_address character varying(255),
    city character varying(255),
    postal_code character varying(255),
    member_until timestamp without time zone,
    membership_level character varying(255) DEFAULT 'Refinery::User'::character varying,
    enabled boolean DEFAULT false,
    seen boolean DEFAULT false,
    rejected character varying(255) DEFAULT 'UNDECIDED'::character varying,
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    province character varying(255),
    refinery_crpv_id integer
);


--
-- Name: refinery_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE refinery_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refinery_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE refinery_users_id_seq OWNED BY refinery_users.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: seo_meta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE seo_meta (
    id integer NOT NULL,
    seo_meta_id integer,
    seo_meta_type character varying(255),
    browser_title character varying(255),
    meta_keywords character varying(255),
    meta_description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: seo_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seo_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seo_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE seo_meta_id_seq OWNED BY seo_meta.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(128),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: traitements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE traitements (
    id integer NOT NULL,
    dossier_id integer,
    medicament_id integer,
    j_debut integer,
    m_debut integer,
    a_debut integer,
    j_fin integer,
    m_fin integer,
    a_fin integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: traitements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE traitements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: traitements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE traitements_id_seq OWNED BY traitements.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY arrondissements ALTER COLUMN id SET DEFAULT nextval('arrondissements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY departements ALTER COLUMN id SET DEFAULT nextval('departements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dossiers ALTER COLUMN id SET DEFAULT nextval('dossiers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY enquetes ALTER COLUMN id SET DEFAULT nextval('enquetes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY evenement_choices ALTER COLUMN id SET DEFAULT nextval('evenement_choices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY evenements ALTER COLUMN id SET DEFAULT nextval('evenements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY medicament_choices ALTER COLUMN id SET DEFAULT nextval('medicament_choices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY medicaments ALTER COLUMN id SET DEFAULT nextval('medicaments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY meta_type_members ALTER COLUMN id SET DEFAULT nextval('meta_type_members_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY meta_type_properties ALTER COLUMN id SET DEFAULT nextval('meta_type_properties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY meta_types ALTER COLUMN id SET DEFAULT nextval('meta_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_crpvs ALTER COLUMN id SET DEFAULT nextval('refinery_crpvs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_documents ALTER COLUMN id SET DEFAULT nextval('refinery_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_documents_categories ALTER COLUMN id SET DEFAULT nextval('refinery_documents_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_images ALTER COLUMN id SET DEFAULT nextval('refinery_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_inquiries_inquiries ALTER COLUMN id SET DEFAULT nextval('refinery_inquiries_inquiries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_membership_email_part_translations ALTER COLUMN id SET DEFAULT nextval('refinery_membership_email_part_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_membership_email_parts ALTER COLUMN id SET DEFAULT nextval('refinery_membership_email_parts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_membership_email_translations ALTER COLUMN id SET DEFAULT nextval('refinery_membership_email_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_membership_emails ALTER COLUMN id SET DEFAULT nextval('refinery_membership_emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_news_categories ALTER COLUMN id SET DEFAULT nextval('refinery_news_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_news_item_translations ALTER COLUMN id SET DEFAULT nextval('refinery_news_item_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_news_items ALTER COLUMN id SET DEFAULT nextval('refinery_news_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_page_part_translations ALTER COLUMN id SET DEFAULT nextval('refinery_page_part_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_page_parts ALTER COLUMN id SET DEFAULT nextval('refinery_page_parts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_page_translations ALTER COLUMN id SET DEFAULT nextval('refinery_page_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_pages ALTER COLUMN id SET DEFAULT nextval('refinery_pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_projets_projets ALTER COLUMN id SET DEFAULT nextval('refinery_projets_projets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_resources ALTER COLUMN id SET DEFAULT nextval('refinery_resources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_roles ALTER COLUMN id SET DEFAULT nextval('refinery_roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_settings ALTER COLUMN id SET DEFAULT nextval('refinery_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_user_plugins ALTER COLUMN id SET DEFAULT nextval('refinery_user_plugins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY refinery_users ALTER COLUMN id SET DEFAULT nextval('refinery_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY seo_meta ALTER COLUMN id SET DEFAULT nextval('seo_meta_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY traitements ALTER COLUMN id SET DEFAULT nextval('traitements_id_seq'::regclass);


--
-- Name: arrondissements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY arrondissements
    ADD CONSTRAINT arrondissements_pkey PRIMARY KEY (id);


--
-- Name: departements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY departements
    ADD CONSTRAINT departements_pkey PRIMARY KEY (id);


--
-- Name: dossiers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dossiers
    ADD CONSTRAINT dossiers_pkey PRIMARY KEY (id);


--
-- Name: enquetes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY enquetes
    ADD CONSTRAINT enquetes_pkey PRIMARY KEY (id);


--
-- Name: evenement_choices_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY evenement_choices
    ADD CONSTRAINT evenement_choices_pkey PRIMARY KEY (id);


--
-- Name: evenements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY evenements
    ADD CONSTRAINT evenements_pkey PRIMARY KEY (id);


--
-- Name: medicament_choices_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicament_choices
    ADD CONSTRAINT medicament_choices_pkey PRIMARY KEY (id);


--
-- Name: medicaments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicaments
    ADD CONSTRAINT medicaments_pkey PRIMARY KEY (id);


--
-- Name: meta_type_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY meta_type_members
    ADD CONSTRAINT meta_type_members_pkey PRIMARY KEY (id);


--
-- Name: meta_type_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY meta_type_properties
    ADD CONSTRAINT meta_type_properties_pkey PRIMARY KEY (id);


--
-- Name: meta_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY meta_types
    ADD CONSTRAINT meta_types_pkey PRIMARY KEY (id);


--
-- Name: meta_types_sid_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY meta_types
    ADD CONSTRAINT meta_types_sid_key UNIQUE (sid);


--
-- Name: meta_types_title_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY meta_types
    ADD CONSTRAINT meta_types_title_key UNIQUE (title);


--
-- Name: patients_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: refinery_crpvs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_crpvs
    ADD CONSTRAINT refinery_crpvs_pkey PRIMARY KEY (id);


--
-- Name: refinery_documents_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_documents_categories
    ADD CONSTRAINT refinery_documents_categories_pkey PRIMARY KEY (id);


--
-- Name: refinery_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_documents
    ADD CONSTRAINT refinery_documents_pkey PRIMARY KEY (id);


--
-- Name: refinery_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_images
    ADD CONSTRAINT refinery_images_pkey PRIMARY KEY (id);


--
-- Name: refinery_inquiries_inquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_inquiries_inquiries
    ADD CONSTRAINT refinery_inquiries_inquiries_pkey PRIMARY KEY (id);


--
-- Name: refinery_membership_email_part_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_membership_email_part_translations
    ADD CONSTRAINT refinery_membership_email_part_translations_pkey PRIMARY KEY (id);


--
-- Name: refinery_membership_email_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_membership_email_parts
    ADD CONSTRAINT refinery_membership_email_parts_pkey PRIMARY KEY (id);


--
-- Name: refinery_membership_email_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_membership_email_translations
    ADD CONSTRAINT refinery_membership_email_translations_pkey PRIMARY KEY (id);


--
-- Name: refinery_membership_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_membership_emails
    ADD CONSTRAINT refinery_membership_emails_pkey PRIMARY KEY (id);


--
-- Name: refinery_news_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_news_categories
    ADD CONSTRAINT refinery_news_categories_pkey PRIMARY KEY (id);


--
-- Name: refinery_news_item_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_news_item_translations
    ADD CONSTRAINT refinery_news_item_translations_pkey PRIMARY KEY (id);


--
-- Name: refinery_news_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_news_items
    ADD CONSTRAINT refinery_news_items_pkey PRIMARY KEY (id);


--
-- Name: refinery_page_part_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_page_part_translations
    ADD CONSTRAINT refinery_page_part_translations_pkey PRIMARY KEY (id);


--
-- Name: refinery_page_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_page_parts
    ADD CONSTRAINT refinery_page_parts_pkey PRIMARY KEY (id);


--
-- Name: refinery_page_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_page_translations
    ADD CONSTRAINT refinery_page_translations_pkey PRIMARY KEY (id);


--
-- Name: refinery_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_pages
    ADD CONSTRAINT refinery_pages_pkey PRIMARY KEY (id);


--
-- Name: refinery_projets_projets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_projets_projets
    ADD CONSTRAINT refinery_projets_projets_pkey PRIMARY KEY (id);


--
-- Name: refinery_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_resources
    ADD CONSTRAINT refinery_resources_pkey PRIMARY KEY (id);


--
-- Name: refinery_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_roles
    ADD CONSTRAINT refinery_roles_pkey PRIMARY KEY (id);


--
-- Name: refinery_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_settings
    ADD CONSTRAINT refinery_settings_pkey PRIMARY KEY (id);


--
-- Name: refinery_user_plugins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_user_plugins
    ADD CONSTRAINT refinery_user_plugins_pkey PRIMARY KEY (id);


--
-- Name: refinery_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY refinery_users
    ADD CONSTRAINT refinery_users_pkey PRIMARY KEY (id);


--
-- Name: seo_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY seo_meta
    ADD CONSTRAINT seo_meta_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: traitements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY traitements
    ADD CONSTRAINT traitements_pkey PRIMARY KEY (id);


--
-- Name: index_2605064b986486e26049fef85d6ee6d5c6b78479; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_2605064b986486e26049fef85d6ee6d5c6b78479 ON refinery_membership_email_translations USING btree (refinery_membership_email_id);


--
-- Name: index_2fe5614a8b4e9a5c34c0f93f230e423e36d53bda; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_2fe5614a8b4e9a5c34c0f93f230e423e36d53bda ON refinery_news_item_translations USING btree (refinery_news_item_id);


--
-- Name: index_a67a470abc863aaf2d59f6b294eb9bb4414afa68; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_a67a470abc863aaf2d59f6b294eb9bb4414afa68 ON refinery_membership_email_part_translations USING btree (refinery_membership_email_part_id);


--
-- Name: index_d079468f88bff1c6ea81573a0d019ba8bf5c2902; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_d079468f88bff1c6ea81573a0d019ba8bf5c2902 ON refinery_page_translations USING btree (refinery_page_id);


--
-- Name: index_departements_on_cp; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_departements_on_cp ON departements USING btree (cp);


--
-- Name: index_departements_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_departements_on_name ON departements USING btree (name);


--
-- Name: index_evenement_choices_on_enquete_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_evenement_choices_on_enquete_id ON evenement_choices USING btree (enquete_id);


--
-- Name: index_evenement_choices_on_evenement_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_evenement_choices_on_evenement_id ON evenement_choices USING btree (evenement_id);


--
-- Name: index_evenements_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_evenements_on_name ON evenements USING btree (name);


--
-- Name: index_f9716c4215584edbca2557e32706a5ae084a15ef; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_f9716c4215584edbca2557e32706a5ae084a15ef ON refinery_page_part_translations USING btree (refinery_page_part_id);


--
-- Name: index_medicament_choices_on_enquete_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_medicament_choices_on_enquete_id ON medicament_choices USING btree (enquete_id);


--
-- Name: index_medicament_choices_on_medicament_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_medicament_choices_on_medicament_id ON medicament_choices USING btree (medicament_id);


--
-- Name: index_patients_on_dossier_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_patients_on_dossier_id ON patients USING btree (dossier_id);


--
-- Name: index_refinery_crpvs_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_crpvs_on_slug ON refinery_crpvs USING btree (slug);


--
-- Name: index_refinery_inquiries_inquiries_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_inquiries_inquiries_on_id ON refinery_inquiries_inquiries USING btree (id);


--
-- Name: index_refinery_membership_email_part_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_membership_email_part_translations_on_locale ON refinery_membership_email_part_translations USING btree (locale);


--
-- Name: index_refinery_membership_email_parts_on_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_refinery_membership_email_parts_on_title ON refinery_membership_email_parts USING btree (title);


--
-- Name: index_refinery_membership_email_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_membership_email_translations_on_locale ON refinery_membership_email_translations USING btree (locale);


--
-- Name: index_refinery_membership_emails_on_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_refinery_membership_emails_on_title ON refinery_membership_emails USING btree (title);


--
-- Name: index_refinery_news_item_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_news_item_translations_on_locale ON refinery_news_item_translations USING btree (locale);


--
-- Name: index_refinery_news_items_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_news_items_on_id ON refinery_news_items USING btree (id);


--
-- Name: index_refinery_news_items_on_news_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_news_items_on_news_category_id ON refinery_news_items USING btree (news_category_id);


--
-- Name: index_refinery_page_part_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_page_part_translations_on_locale ON refinery_page_part_translations USING btree (locale);


--
-- Name: index_refinery_page_parts_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_page_parts_on_id ON refinery_page_parts USING btree (id);


--
-- Name: index_refinery_page_parts_on_refinery_page_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_page_parts_on_refinery_page_id ON refinery_page_parts USING btree (refinery_page_id);


--
-- Name: index_refinery_page_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_page_translations_on_locale ON refinery_page_translations USING btree (locale);


--
-- Name: index_refinery_pages_on_depth; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_pages_on_depth ON refinery_pages USING btree (depth);


--
-- Name: index_refinery_pages_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_pages_on_id ON refinery_pages USING btree (id);


--
-- Name: index_refinery_pages_on_lft; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_pages_on_lft ON refinery_pages USING btree (lft);


--
-- Name: index_refinery_pages_on_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_pages_on_parent_id ON refinery_pages USING btree (parent_id);


--
-- Name: index_refinery_pages_on_rgt; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_pages_on_rgt ON refinery_pages USING btree (rgt);


--
-- Name: index_refinery_projets_projets_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_projets_projets_on_id ON refinery_projets_projets USING btree (id);


--
-- Name: index_refinery_projets_projets_on_refinery_crpv_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_projets_projets_on_refinery_crpv_id ON refinery_projets_projets USING btree (refinery_crpv_id);


--
-- Name: index_refinery_projets_projets_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_projets_projets_on_slug ON refinery_projets_projets USING btree (slug);


--
-- Name: index_refinery_projets_projets_on_titre; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_projets_projets_on_titre ON refinery_projets_projets USING btree (titre);


--
-- Name: index_refinery_projets_projets_on_workflow_state; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_projets_projets_on_workflow_state ON refinery_projets_projets USING btree (workflow_state);


--
-- Name: index_refinery_roles_users_on_role_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_roles_users_on_role_id_and_user_id ON refinery_roles_users USING btree (role_id, user_id);


--
-- Name: index_refinery_roles_users_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_roles_users_on_user_id_and_role_id ON refinery_roles_users USING btree (user_id, role_id);


--
-- Name: index_refinery_settings_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_settings_on_name ON refinery_settings USING btree (name);


--
-- Name: index_refinery_user_plugins_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_user_plugins_on_name ON refinery_user_plugins USING btree (name);


--
-- Name: index_refinery_user_plugins_on_user_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_refinery_user_plugins_on_user_id_and_name ON refinery_user_plugins USING btree (user_id, name);


--
-- Name: index_refinery_users_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_refinery_users_on_id ON refinery_users USING btree (id);


--
-- Name: index_seo_meta_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_seo_meta_on_id ON seo_meta USING btree (id);


--
-- Name: index_seo_meta_on_seo_meta_id_and_seo_meta_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_seo_meta_on_seo_meta_id_and_seo_meta_type ON seo_meta USING btree (seo_meta_id, seo_meta_type);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_traitements_on_dossier_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_traitements_on_dossier_id ON traitements USING btree (dossier_id);


--
-- Name: index_traitements_on_medicament_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_traitements_on_medicament_id ON traitements USING btree (medicament_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: dossiers_evenement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dossiers
    ADD CONSTRAINT dossiers_evenement_id_fkey FOREIGN KEY (evenement_id) REFERENCES evenements(id);


--
-- Name: dossiers_meta_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dossiers
    ADD CONSTRAINT dossiers_meta_type_id_fkey FOREIGN KEY (enquete_id) REFERENCES meta_types(id);


--
-- Name: dossiers_refinery_crpv_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dossiers
    ADD CONSTRAINT dossiers_refinery_crpv_id_fkey FOREIGN KEY (refinery_crpv_id) REFERENCES refinery_crpvs(id);


--
-- Name: meta_type_members_meta_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY meta_type_members
    ADD CONSTRAINT meta_type_members_meta_type_id_fkey FOREIGN KEY (meta_type_id) REFERENCES meta_types(id);


--
-- Name: meta_type_members_meta_type_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY meta_type_members
    ADD CONSTRAINT meta_type_members_meta_type_property_id_fkey FOREIGN KEY (meta_type_property_id) REFERENCES meta_type_properties(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120622083208');

INSERT INTO schema_migrations (version) VALUES ('20120622083209');

INSERT INTO schema_migrations (version) VALUES ('20120622083210');

INSERT INTO schema_migrations (version) VALUES ('20120622083211');

INSERT INTO schema_migrations (version) VALUES ('20120622083212');

INSERT INTO schema_migrations (version) VALUES ('20120914115705');

INSERT INTO schema_migrations (version) VALUES ('20120914115710');

INSERT INTO schema_migrations (version) VALUES ('20121218100007');

INSERT INTO schema_migrations (version) VALUES ('20121218100008');

INSERT INTO schema_migrations (version) VALUES ('20121218100009');

INSERT INTO schema_migrations (version) VALUES ('20121218100010');

INSERT INTO schema_migrations (version) VALUES ('20121218100011');

INSERT INTO schema_migrations (version) VALUES ('20121218100012');

INSERT INTO schema_migrations (version) VALUES ('20121218100849');

INSERT INTO schema_migrations (version) VALUES ('20121218101155');

INSERT INTO schema_migrations (version) VALUES ('20121218135828');

INSERT INTO schema_migrations (version) VALUES ('20121218162054');

INSERT INTO schema_migrations (version) VALUES ('20121220101307');

INSERT INTO schema_migrations (version) VALUES ('20121220102207');

INSERT INTO schema_migrations (version) VALUES ('20130104105446');

INSERT INTO schema_migrations (version) VALUES ('20130104105845');

INSERT INTO schema_migrations (version) VALUES ('20130118094655');

INSERT INTO schema_migrations (version) VALUES ('20130131084223');

INSERT INTO schema_migrations (version) VALUES ('20130131084856');

INSERT INTO schema_migrations (version) VALUES ('20130204133645');

INSERT INTO schema_migrations (version) VALUES ('20130204142326');

INSERT INTO schema_migrations (version) VALUES ('20130204142327');

INSERT INTO schema_migrations (version) VALUES ('20130204142328');

INSERT INTO schema_migrations (version) VALUES ('20130204142329');

INSERT INTO schema_migrations (version) VALUES ('20130204142330');

INSERT INTO schema_migrations (version) VALUES ('20130204142331');

INSERT INTO schema_migrations (version) VALUES ('20130204142332');

INSERT INTO schema_migrations (version) VALUES ('20130204142333');

INSERT INTO schema_migrations (version) VALUES ('20130204142334');

INSERT INTO schema_migrations (version) VALUES ('20130207134728');

INSERT INTO schema_migrations (version) VALUES ('20130208102345');

INSERT INTO schema_migrations (version) VALUES ('20130208121040');

INSERT INTO schema_migrations (version) VALUES ('20130208121327');

INSERT INTO schema_migrations (version) VALUES ('20130213131736');

INSERT INTO schema_migrations (version) VALUES ('20130225101259');

INSERT INTO schema_migrations (version) VALUES ('20130313131809');

INSERT INTO schema_migrations (version) VALUES ('20130318131757');

INSERT INTO schema_migrations (version) VALUES ('20130318133112');

INSERT INTO schema_migrations (version) VALUES ('20130319125118');

INSERT INTO schema_migrations (version) VALUES ('20130319125452');

INSERT INTO schema_migrations (version) VALUES ('20130319171419');

INSERT INTO schema_migrations (version) VALUES ('20130322091301');

INSERT INTO schema_migrations (version) VALUES ('20130322123823');

INSERT INTO schema_migrations (version) VALUES ('20130322131622');

INSERT INTO schema_migrations (version) VALUES ('20130322131623');

INSERT INTO schema_migrations (version) VALUES ('20130322131624');

INSERT INTO schema_migrations (version) VALUES ('20130322131831');

INSERT INTO schema_migrations (version) VALUES ('20130322150814');

INSERT INTO schema_migrations (version) VALUES ('20130322151538');

INSERT INTO schema_migrations (version) VALUES ('20130322152626');