# OMOPonFHIR SQLRender server deployment
This repository is a server deployment package that lock down the version of included components. Please use the following step to compile and deploy the server. You may need to customize some of the environment parameters. 

This package is tested with Google Big Query instance. And, the server supports mapping for FHIR DSTU2 and OMOP v5.2

```
**Note:** This repository contains submodules of anoter repositories that are needed. If you want to participate in 
development and contribute, please use the repositories directly as this submodule points to a certain commit point. 
Refer the follow repositories and use the latest to work on the code.

- path = omoponfhir-omopv5-sql
- url = https://github.com/omoponfhir/omoponfhir-omopv5-sql.git
- branch = 5.2

- path = omoponfhir-omopv5-dstu2-mapping
- url = https://github.com/omoponfhir/omoponfhir-omopv5-dstu2-mapping.git
- branch = sqlRender

- path = omoponfhir-dstu2-server
- url = https://github.com/omoponfhir/omoponfhir-dstu2-server.git
- branch = sqlRender
```
        
## Download the package
```
git clone --recurse https://github.com/omoponfhir/omoponfhir-main-dstu2-sql.git
cd omoponfhir-main-dstu2-sql/
mvn clean install
cd omoponfhir-dstu2-server/target/
scp omoponfhir-dstu2-server.war <vm url>:omoponfhir-dstu2-server.war
```

## Deploy to tomcat ##
```
cp omoponfhir-dstu2-server.war <tomcat_directory>/webapps/
cd <tomcat_directory>/bin
vi setenv.sh
```

## Configuration of webapp
In setenv.sh file, add the following environment variables. Change the values for your environment 
```
export JDBC_USERNAME="<your username of JDBC DB instance>"
export JDBC_PASSWORD="<your password of JDBC DB instance>"
export PG_HOST="<your Postgres Host URL. eg: localhost>"
export PG_PORT="<your Postgres Host Port. eg: 5432>"
export PG_DATABASE="<name of the database. eg: postgres>"
export PG_CURRENTSCHEMA="<name of schema in the database>"
export SMART_INTROSPECTURL="<your_omoponfhir_root_server_NOT_a_fhir_url_base, eg: localhost:8080/omoponfhir-dstu2-server/>/smart/introspect"
export SMART_AUTHSERVERURL="<your_omoponfhir_root_server_NOT_a_fhir_url_base>/smart/authorize"
export SMART_TOKENSERVERURL="<your_omoponfhir_root_server_NOT_a_fhir_url_base>/smart/token"
export AUTH_BEARER="<any value>"
export AUTH_BASIC="<username_you_want>:<password_you_want>"
export FHIR_READONLY="<True or False>"
export SERVERBASE_URL="<your fhir base url, eg: http://localhost:8080/omoponfhir-dstu2-server/fhir/>"
export LOCAL_CODEMAPPING_FILE_PATH="<whatever the path you want to put your local mapping file. eg: /temp/my_local_code"
export MEDICATION_TYPE="code"
export TARGETDATABASE="<SqlRenderTargetDialect value such as bigquery or postgresql. If you leave this empty, it will be postgresql. Use string from sqlRender>"
export BIGQUERYDATASET="<BigQuery Dataset Name. It will be ignored if TARGETDATABASE is not bigquery>"
export BIGQUERYPROJECT="<BigQuery Project Name. It will be ignored if TARGETDATABASE is not bigquery>"
```

## Docker deployment
This is not yet tested and validated. The same environment variables are applied here. The environment variable must be defined either using Dockerfile or docker command line when the docker image is instantiated to start running.
