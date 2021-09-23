CREATE TABLE omop.f_person
(
   person_id           integer        NOT NULL,
   family_name         varchar(255),
   given1_name         varchar(255),
   given2_name         varchar(255),
   prefix_name         varchar(255),
   suffix_name         varchar(255),
   preferred_language  varchar(255),
   ssn                 varchar(12),
   active              smallint       DEFAULT 1,
   contact_point1      varchar(255),
   contact_point2      varchar(255),
   contact_point3      varchar(255),
   maritalstatus       varchar(255)
);

ALTER TABLE omop.f_person OWNER TO omop;

COMMENT ON TABLE omop.f_person IS ‘Extended one-to-one table with person table. This include person’‘s demographic information to support FHIR patient resource.‘;
GRANT INSERT, TRIGGER, TRUNCATE, DELETE, SELECT, REFERENCES, UPDATE ON omop.f_person TO omop;



COMMIT;
