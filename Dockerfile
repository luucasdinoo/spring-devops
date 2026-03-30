FROM maven:3.9.9-eclipse-temurin-21-noble AS builder

COPY src /app/src
COPY pom.xml /app

WORKDIR /app

RUN mvn clean install -DskipTests

FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

COPY --from=builder /app/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]