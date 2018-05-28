From tomcat:8-jre8
MAINTAINER "raju.g1233@gmail.com"
EXPOSE 8080
# Copy to images tomcat path
ADD target/RestFrameWorkUtility-1.0.0.war /usr/local/tomcat/webapps/
#ADD target/SpringKube.jar SpringKube.jar
#ENTRYPOINT ["java","-jar","SpringKube.jar"]
CMD ["catalina.sh", "run"]
 

