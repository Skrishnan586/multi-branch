FROM tomcat:9

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/

# Copy your Java WAR file to the container
COPY target/onlinebookstore.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8085

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
