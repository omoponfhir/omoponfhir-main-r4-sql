DROP VIEW IF EXISTS omop.f_observation_view CASCADE;
drop table if exists omop.allergy_observation_concepts cascade;

create table omop.allergy_observation_concepts
as
select concept_id
from omop.concept
where ( upper(concept_name) like '%ALLERG% or upper(concept_name) like '%REACTION%' )
and ( domain_id = 'Observation' or domain_id = 'Condition' )
and invaid_reason <> 'D';

create index idx_all_obs_con on omop.allergy_observation_concepts(concept_id);

CREATE OR REPLACE VIEW omop.f_observation_view
(
  observation_id,
  person_id,
  observation_concept_id,
  observation_date,
  observation_time,
  observation_type_concept_id,
  observation_operator_concept_id,
  value_as_number,
  value_as_string,
  value_as_concept_id,
  qualifier_concept_id,
  unit_concept_id,
  range_low,
  range_high,
  provider_id,
  visit_occurrence_id,
  source_value,
  source_concept_id,
  unit_source_value,
  value_source_value,
  qualifier_source_value
)
AS 
 SELECT measurement.measurement_id AS observation_id,
    measurement.person_id,
    measurement.measurement_concept_id AS observation_concept_id,
    measurement.measurement_date AS observation_date,
    measurement.measurement_time AS observation_time,
    measurement.measurement_type_concept_id AS observation_type_concept_id,
    measurement.operator_concept_id AS observation_operator_concept_id,
    measurement.value_as_number,
    NULL::character varying AS value_as_string,
    measurement.value_as_concept_id,
    NULL::integer AS qualifier_concept_id,
    measurement.unit_concept_id,
    measurement.range_low,
    measurement.range_high,
    measurement.provider_id,
    measurement.visit_occurrence_id,
    measurement.measurement_source_value AS source_value,
    measurement.measurement_source_concept_id AS source_concept_id,
    measurement.unit_source_value,
    measurement.value_source_value,
    NULL::character varying AS qualifier_source_value
   FROM omop.measurement
UNION ALL
 SELECT observation.observation_id,
    observation.person_id,
    observation.observation_concept_id,
    observation.observation_date,
    observation.observation_time,
    observation.observation_type_concept_id,
    NULL::integer AS observation_operator_concept_id,
    observation.value_as_number,
    observation.value_as_string,
    observation.value_as_concept_id,
    observation.qualifier_concept_id,
    observation.unit_concept_id,
    NULL::numeric AS range_low,
    NULL::numeric AS range_high,
    observation.provider_id,
    observation.visit_occurrence_id,
    observation.observation_source_value AS source_value,
    observation.observation_source_concept_id AS source_concept_id,
    observation.unit_source_value,
    NULL::character varying AS value_source_value,
    observation.qualifier_source_value
   FROM omop.observation
     LEFT JOIN omop.allergy_observation_concepts c ON observation.observation_concept_id = c.concept_id
  WHERE c.concept_id IS NULL;


GRANT TRUNCATE, SELECT, UPDATE, REFERENCES, INSERT, DELETE, TRIGGER ON omop.f_observation_view TO ohdsi_admin;
GRANT TRUNCATE, UPDATE, TRIGGER, SELECT, INSERT, REFERENCES, DELETE ON omop.f_observation_view TO rstarr;


COMMIT;
