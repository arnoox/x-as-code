# Use the same base image as the devcontainer
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu24.04

# Install necessary packages using a single RUN command to optimize layers
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        default-jre \
        graphviz \
        cmake \
    && rm -rf /var/lib/apt/lists/*


# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"
# Set the default working directory and user
WORKDIR /workspace
USER vscode



