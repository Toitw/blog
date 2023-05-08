# Use the official Ruby 3.1.2 image as the base image
FROM ruby:3.1.2

# Set environment variables for Rails
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

# Install Node.js and Yarn for asset compilation
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn

# Create a directory for the Rails app and set it as the working directory
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock and install the gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install

# Copy the rest of the Rails app files
COPY . .

# Precompile assets
RUN RAILS_ENV=production SECRET_KEY_BASE=placeholder bin/rails assets:precompile

# Expose the port the app will run on
EXPOSE 3000

# Start the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
