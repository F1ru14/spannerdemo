FROM openjdk:8-jdk

# Create directory for app
RUN mkdir -p /app

# Create volume for temporary files
VOLUME /tmp

# Copy the jar file
COPY target/spannerdemo-0.0.1-SNAPSHOT.jar /app/app.jar

# Verify the jar exists
RUN ls -la /app/app.jar
WORKDIR /app
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]