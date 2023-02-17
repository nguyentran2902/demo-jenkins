


# Docker Build Stage
FROM maven:3.8.3-openjdk-17

# Build Stage
WORKDIR /opt/app

COPY ./ /opt/app
RUN mvn clean install -DskipTests


# Docker Build Stage
FROM openjdk:17-alpine

COPY --from=build /opt/app/target/*.jar demo-jenkins.jar

ENV PORT 8181
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","demo-jenkins.jar"]

