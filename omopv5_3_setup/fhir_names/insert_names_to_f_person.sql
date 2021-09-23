insert into f_person
( person_id, given1_name, family_name )
select  person_id, firstname, lastname
from 
(
select * from 
(
  select (random()*9+1)/10 as rn, person_id
   from person
   where gender_concept_id = 8532
  ) p
  join 
  (
  select 
    row_number() over() as lastnum, name as lastname
  from names.lastname
  ) l on round(p.rn*88798)  = l.lastnum
  join 
  (
  select 
    row_number() over() as firstnum, name as firstname
  from names.female_first
  ) f on round(p.rn*4274)  = f.firstnum
  
 ) a
;


insert into f_person
( person_id, given1_name, family_name )

select  person_id, firstname, lastname
from 
(
select * from 
(
  select (random()*9+1)/10 as rn, person_id
   from person
   where coalesce(gender_concept_id, 0 ) <> 8532
  ) p
  join 
  (
  select 
    row_number() over() as lastnum, name as lastname
  from names.lastname
  ) l on round(p.rn*88798)  = l.lastnum
  join 
  (
  select 
    row_number() over() as firstnum, name as firstname
  from names.male_first
  ) m on round(p.rn*1218)  = m.firstnum
  
 ) a
;
