# build
FROM maven:3-jdk-7-alpine as build
RUN apk add git && \
    git clone https://github.com/shephertz/App42PaaS-Java-MySQL-Sample.git
WORKDIR App42PaaS-Java-MySQL-Sample
RUN mvn package
#
FROM tomcat:8.0-jre7-alpine
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
