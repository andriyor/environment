# Multi-arch (works on Intel & ARM)
FROM node:20-alpine

# Create app dir and use non-root user
WORKDIR /usr/src/app
RUN addgroup -S elasticsearch-example && adduser -S elasticsearch-example -G elasticsearch-example
COPY package*.json ./

# Install only production deps by default
RUN npm ci --omit=dev

# Copy source
COPY . .

# Drop privileges
USER elasticsearch-example

# Env & runtime
ENV NODE_ENV=production
CMD ["node", "index.js"]
