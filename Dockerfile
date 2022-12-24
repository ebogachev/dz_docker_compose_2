FROM maven:3-jdk-7-alpine as build
RUN apk add git && \
    git clone https://github.com/ebogachev/App42PaaS-Java-MySQL-Sample.git
WORKDIR App42PaaS-Java-MySQL-Sample
RUN mvn package
#
FROM tomcat:8.0-jre7-alpine
COPY --from=build /App42PaaS-Java-MySQL-Sample/target/*.war /usr/local/tomcat/webapps/
COPY --from=build /App42PaaS-Java-MySQL-Sample/WebContent/Config.properties /usr/local/tomcat/ROOT/
EXPOSE 8080
