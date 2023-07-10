FROM tomcat:9

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your Java WAR file to the container
COPY /var/lib/jenkins/workspace/multibranch-pipeline_main/target/onlinebookstore/ /usr/local/tomcat/webapps/ROOT/

# Expose port 8085 for the application
EXPOSE 8085

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
