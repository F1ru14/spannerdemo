# Build stage
FROM maven:3.8-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:8-jdk
WORKDIR /app
VOLUME /tmp
COPY --from=builder /app/target/spannerdemo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]