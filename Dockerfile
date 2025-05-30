# Build stage
FROM node:20-slim AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./
COPY .npmrc ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Set build-time environment variables
ARG DATABASE_URL=postgres://root:mysecretpassword@db:5433/local
ENV DATABASE_URL=${DATABASE_URL}

# Build the application
RUN npm run build

# Production stage
FROM node:20-slim AS production

WORKDIR /app

# Copy built assets from builder
COPY --from=builder /app/build ./build
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/.npmrc ./

# Install production dependencies only
RUN npm ci --production

# Set runtime environment variables
ENV DATABASE_URL=postgres://root:mysecretpassword@db:5432/local
ENV NODE_ENV=production

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["node", "build"] 