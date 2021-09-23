To populate the f_person table:  
  1)  create the names schema and load the names data using the names.dmp file  ( NOTE: this assumes the postgres user and will give appropriate permissions to that user )  
    
      psql -d postgres < names.dmp  
        
  2) run the insert commands in insert_names_ti_f_person.sql script.  You will need to modify the schema name in this script to the correct schema for the omop_v5 schema prior to running.  
  
