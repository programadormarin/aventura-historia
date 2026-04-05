# Use a Flutter image from a reliable source or build our own
FROM mobiledevops/flutter-sdk-image:3.19.4


# Switch to root to install system dependencies
USER root

# Fix EOL Ubuntu repositories for Mantic (23.10)
RUN sed -i 's|archive.ubuntu.com/ubuntu|old-releases.ubuntu.com/ubuntu|g' /etc/apt/sources.list && \
    sed -i 's|security.ubuntu.com/ubuntu|old-releases.ubuntu.com/ubuntu|g' /etc/apt/sources.list

# Install SQLite dependencies for sqflite_common_ffi
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the non-root user for Flutter operations
# Ensure the mobiledevops user exists (it may be missing in some base image versions)
RUN if ! id -u mobiledevops >/dev/null 2>&1; then \
        groupadd -g 1001 mobiledevops || groupadd mobiledevops; \
        useradd -u 1001 -g mobiledevops -d /home/mobiledevops -s /bin/bash mobiledevops || \
        useradd -g mobiledevops -d /home/mobiledevops -s /bin/bash mobiledevops; \
    fi
RUN chown -R mobiledevops:mobiledevops /home/mobiledevops || true
USER mobiledevops

# Configure Git to trust the Flutter SDK directory (to avoid 0.0.0-unknown version)
RUN git config --global --add safe.directory /home/mobiledevops/.flutter-sdk

# Set the working directory
WORKDIR /app

# Copy the pubspec and fetch dependencies (caching layer)
COPY --chown=mobiledevops:mobiledevops pubspec.yaml pubspec.lock* ./
RUN flutter pub get

# The project files will be mounted via docker-compose for development
# but can be copied for CI
COPY --chown=mobiledevops:mobiledevops . .

# Run tests by default
CMD ["flutter", "test"]
