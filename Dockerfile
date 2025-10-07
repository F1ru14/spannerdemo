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

# Add wait-for-it script to verify application startup
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Set environment variables
ENV PORT=8080

# Health check
HEALTHCHECK --interval=5s --timeout=3s --start-period=30s \
  CMD curl -f http://localhost:$PORT/ || exit 1

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]