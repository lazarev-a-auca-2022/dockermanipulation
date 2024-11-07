FROM mcr.microsoft.com/mssql/server:2019-latest

# Set environment variables
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=MSSQLP@ssword1234567890

# Create directories for persistent storage
RUN mkdir -p /var/opt/mssql/data \
    && mkdir -p /var/opt/mssql/log \
    && mkdir -p /var/opt/mssql/secrets \
    && mkdir -p /var/backups \
    && mkdir -p /tmp/app

# Copy SQL script
COPY sqlscript.sql /tmp/app/
COPY setup.sh /tmp/app/

# Make the setup script executable
RUN chmod +x /tmp/app/setup.sh

# Define volume mount points
VOLUME ["/var/opt/mssql/data", "/var/opt/mssql/log", "/var/opt/mssql/secrets", "/var/backups"]

# Expose SQL Server port
EXPOSE 1433

# Start SQL Server and run the setup script
CMD /bin/bash /tmp/app/setup.sh