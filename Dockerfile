FROM maven:3.9.9-eclipse-temurin-21-noble AS builder

COPY src /app/src
COPY pom.xml /app

WORKDIR /app

RUN mvn clean install

FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/devops-0.0.1-SNAPSHOT.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

