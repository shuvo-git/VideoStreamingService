FROM maven:3.6.3-openjdk-11-slim as BUILDER
ARG JAR_FILE=target/*.jar
WORKDIR /build/
copy pom.xml /build/
copy src /build/src

RUN mvn clean package
COPY ${JAR_FILE} application.jar

FROM openjdk:11.0.11-jre-slim
WORKDIR /app/

COPY --from=BUILDER application.jar /app/
CMD java -jar /app/application.jar