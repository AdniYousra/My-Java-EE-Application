FROM openjdk:8-jre-alpine

WORKDIR /app

COPY target/my-javaee-app.war /app/

EXPOSE 8080

CMD ["java", "-jar", "my-javaee-app.war"]
