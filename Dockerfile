# Use the official Ruby image as a base
FROM ruby:3.2.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

#  Install rails
Run gem install rails bundler

# Set environment variables
ENV RAILS_ENV='development'
ENV BUNDLE_PATH='/gems'

# Set the working directory in the container
WORKDIR /app

RUN gem install bundler

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (optional, only for production)
# RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port 3000 to the host
EXPOSE 3000

# Start the Rails server/
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]