#Build the Maven project
FROM maven:3.6.1-alpine as builder
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean install

#Build the Tomcat container
FROM tomcat:alpine
#set environment variables below and uncomment the line. Or, you can manually set your environment on your server.
#ENV JDBC_URL=jdbc:postgresql://<host>:<port>/<database> JDBC_USERNAME=<username> JDBC_PASSWORD=<password>
RUN apk update
RUN apk add zip postgresql-client

# Copy GT-FHIR war file to webapps.
COPY --from=builder /usr/src/app/omoponfhir-dstu2-server/target/omoponfhir-dstu2-server.war $CATALINA_HOME/webapps/omoponfhir2.war

EXPOSE 8080
