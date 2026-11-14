-- TABLE STRUCTURE REFERENCE ONLY. No private rows or auth data.
-- Requires sequence/default/index setup from a proper schema migration before writes.

CREATE TABLE public.ward_works (
    id integer NOT NULL,
    title text NOT NULL,
    fiscal_year text NOT NULL,
    amount bigint DEFAULT 0 NOT NULL,
    status text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    department text DEFAULT ''::text NOT NULL,
    CONSTRAINT ward_works_amount_check CHECK ((amount >= 0))
);;

CREATE TABLE public.ward_content (
    key text NOT NULL,
    title text DEFAULT ''::text NOT NULL,
    body text DEFAULT ''::text NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);;

CREATE TABLE public.ward_services (
    id text NOT NULL,
    title text NOT NULL,
    subtitle text DEFAULT ''::text NOT NULL,
    body text DEFAULT ''::text NOT NULL,
    is_visible boolean DEFAULT true NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);;

CREATE TABLE public.ward_officers (
    id bigint NOT NULL,
    category text NOT NULL,
    name text NOT NULL,
    designation text NOT NULL,
    department text DEFAULT ''::text NOT NULL,
    phone text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    office_address text DEFAULT ''::text NOT NULL,
    photo_url text DEFAULT ''::text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    is_visible boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    ward_number integer,
    profile_key text DEFAULT ''::text NOT NULL,
    CONSTRAINT ward_officers_category_check CHECK ((category = ANY (ARRAY['municipal'::text, 'district'::text, 'leadership'::text, 'councillor'::text]))),
    CONSTRAINT ward_officers_designation_nonempty CHECK (((length(TRIM(BOTH FROM designation)) >= 2) AND (length(TRIM(BOTH FROM designation)) <= 180))),
    CONSTRAINT ward_officers_email_size CHECK ((length(email) <= 254)),
    CONSTRAINT ward_officers_name_nonempty CHECK (((length(TRIM(BOTH FROM name)) >= 2) AND (length(TRIM(BOTH FROM name)) <= 180))),
    CONSTRAINT ward_officers_phone_size CHECK ((length(phone) <= 20)),
    CONSTRAINT ward_officers_photo_size CHECK ((length(photo_url) <= 1500)),
    CONSTRAINT ward_officers_profile_key_check CHECK ((profile_key = ANY (ARRAY[''::text, 'councillor'::text, 'executive'::text, 'engineer'::text]))),
    CONSTRAINT ward_officers_ward_no_check CHECK (((ward_number IS NULL) OR ((ward_number >= 1) AND (ward_number <= 500))))
);;

CREATE TABLE public.ward_media (
    id bigint NOT NULL,
    kind text NOT NULL,
    title text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    url text NOT NULL,
    mime_type text DEFAULT ''::text NOT NULL,
    scheme_id integer,
    is_visible boolean DEFAULT true NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ward_media_kind_check CHECK ((kind = ANY (ARRAY['news'::text, 'gallery'::text, 'document'::text, 'banner'::text, 'achievement'::text, 'cleaning'::text, 'form'::text])))
);;

CREATE TABLE public.ward_contacts (
    id bigint NOT NULL,
    title text NOT NULL,
    value text NOT NULL,
    detail text DEFAULT ''::text NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    is_visible boolean DEFAULT true NOT NULL
);;

CREATE TABLE public.ward_site_visits (
    id integer NOT NULL,
    total bigint DEFAULT 0 NOT NULL,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ward_site_visits_id_check CHECK ((id = 1)),
    CONSTRAINT ward_site_visits_total_check CHECK ((total >= 0))
);;
