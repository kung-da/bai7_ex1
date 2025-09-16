# Sử dụng Maven để build app
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy source vào container
COPY . .

# Build ứng dụng, tạo file .war trong target/
RUN mvn clean package -DskipTests

# =============================
# Stage 2: Run trên Tomcat
# =============================
FROM tomcat:10.1-jdk17
WORKDIR /usr/local/tomcat/webapps/

# Xóa webapp mặc định của Tomcat
RUN rm -rf ROOT

# Copy file WAR đã build sang ROOT.war
COPY --from=build /app/target/*.war ./ch7_ex1.war


# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
