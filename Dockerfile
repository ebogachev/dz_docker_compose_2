FROM maven:3.8.6-eclipse-temurin-8-alpine as build
RUN apk add git && \
    git clone https://github.com/ebogachev/App42PaaS-Java-MySQL-Sample.git
WORKDIR App42PaaS-Java-MySQL-Sample
RUN mvn package
#
FROM tomcat:9.0.20-jre8-alpine
COPY --from=build /App42PaaS-Java-MySQL-Sample/target/*.war /usr/local/tomcat/webapps/
COPY --from=build /App42PaaS-Java-MySQL-Sample/WebContent/Config.properties /usr/local/tomcat/ROOT/
EXPOSE 8080
