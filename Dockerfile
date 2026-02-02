# OpenClaw - Non-configured Docker Image
# Based on: https://docs.openclaw.ai/install

FROM node:22-bookworm
ENV NODE_ENV=production

LABEL maintainer="Mathieu Colmon"
LABEL description="OpenClaw - Non-configured installation"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    btop \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install OpenClaw globally
# CACHE_BUST arg invalidates cache to ensure latest version
ARG CACHE_BUST
RUN npm install -g openclaw@latest

WORKDIR /data

# Set environment variables for non-interactive mode
ENV OPENCLAW_NO_PROMPT=1
ENV OPENCLAW_NO_ONBOARD=1
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV PORT=3000

# Default command - starts a shell for manual configuration
EXPOSE 3000
CMD ["openclaw", "gateway", "--allow-unconfigured", "--bind", "lan"]
