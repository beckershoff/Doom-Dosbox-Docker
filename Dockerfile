# Base image
FROM node:16-alpine

# Set working directory
WORKDIR /site

# Download JS-DOS files
RUN wget https://js-dos.com/6.22/current/js-dos.js && \
    wget https://js-dos.com/6.22/current/wdosbox.js && \
    wget https://js-dos.com/6.22/current/wdosbox.wasm.js

# Install serve
RUN npm install -g serve

# Copy game files from local directory
COPY "Doom_v1.9.zip" /site/game.zip

# Copy HTML file
COPY index.html /site
COPY js-dos.css /site
COPY emulators-ui.js /site
COPY emulators-ui.css /site

# Replace GAME_ARGS in HTML
ARG GAME_ARGS="/DOOM_V1.9/doom.exe"
RUN sed -i s/GAME_ARGS/$GAME_ARGS/ index.html

# Set entrypoint
ENTRYPOINT npx serve -l tcp://0.0.0.0:8000

