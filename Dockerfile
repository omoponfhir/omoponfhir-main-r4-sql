#Build the Maven project
FROM maven:3.8.3-openjdk-17 as builder
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean install

#Build the Tomcat container
FROM tomcat:9.0.65-jre17
#set environment variables below and uncomment the line. Or, you can manually set your environment on your server.
#ENV JDBC_URL=jdbc:postgresql://<host>:<port>/<database> JDBC_USERNAME=<username> JDBC_PASSWORD=<password>
RUN apk update
RUN apk add zip postgresql-client

# Copy GT-FHIR war file to webapps.
COPY --from=builder /usr/src/app/omoponfhir-r4-server/target/omoponfhir-r4-server.war $CATALINA_HOME/webapps/omoponfhir4.war

EXPOSE 8080
