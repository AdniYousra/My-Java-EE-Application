FROM mcr.microsoft.com/java/jdk:8-zulu-windowsservercore

WORKDIR /app

COPY target/my-javaee-app.war /app/

EXPOSE 8080

CMD ["java", "-jar", "my-javaee-app.war"]
