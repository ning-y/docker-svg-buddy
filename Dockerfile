FROM openjdk:22
ARG version_svg_buddy="1.2.3"
LABEL org.opencontainers.image.version=$version_svg_buddy

# Install maven, the build tool used here
RUN curl \
    https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz \
    --output apache-maven-3.9.2-bin.tar.gz && \
  tar -xzf apache-maven-3.9.2-bin.tar.gz
ENV PATH="${PATH}:/apache-maven-3.9.2-bin/bin"

# Pull the specific version of svg-buddy 
RUN \
  curl -L --output svg-buddy-$version_svg_buddy \
    https://github.com/phauer/svg-buddy/archive/refs/tags/$version_svg_buddy.tar.gz && \
  tar -zxf svg-buddy-$version_svg_buddy

# Build and install
WORKDIR svg-buddy-$version_svg_buddy
RUN ./mvnw package
ENTRYPOINT ["java", "-jar", "target/svg-buddy-runner.jar"]
