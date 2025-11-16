# Runtime image (JRE only, we build the jar with Maven)
FROM eclipse-temurin:17-jre-alpine

# Argument to point to the jar created by Maven
ARG JAR_FILE=target/demo-cicd-app-0.0.1-SNAPSHOT.jar

# Copy the jar from the target folder into the image
COPY ${JAR_FILE} app.jar

# Expose the app port (must match server.port)
EXPOSE 8081

# Run the jar
ENTRYPOINT ["java","-jar","/app.jar"]
