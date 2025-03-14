# Step 1: Use an official Node.js runtime as the base image
FROM node:16-alpine

# Step 2: Set the working directory in the container
WORKDIR /usr/src/app

# Step 3: Copy the package.json and package-lock.json
COPY package*.json ./

# Step 4: Install the dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Expose the port the app will run on
EXPOSE 3000

# Step 7: Define the command to run the app
CMD ["npm", "start"]
