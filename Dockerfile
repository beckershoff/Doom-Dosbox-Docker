# Base image
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Install necessary utilities
RUN apk add --no-cache wget

# Download JS-DOS files
RUN wget https://js-dos.com/6.22/current/js-dos.js && \
    wget https://js-dos.com/6.22/current/wdosbox.js && \
    wget https://js-dos.com/6.22/current/wdosbox.wasm.js

# Install serve
RUN npm install -g serve

# Copy game files from local directory
COPY "Doom_v1.9.zip" /app/game.zip
   
# Download emulators-ui.css
RUN wget -O /app/emulators-ui.css https://raw.githubusercontent.com/js-dos/emulators-ui/main/src/emulators-ui.css

# Download emulators-ui.js (assuming you also need this file)
RUN wget -O /app/emulators-ui.js https://raw.githubusercontent.com/js-dos/emulators-ui/main/src/emulators-ui.js

# Copy HTML file
COPY index.html /app

# Set entrypoint
ENTRYPOINT npx serve -l tcp://0.0.0.0:8000

