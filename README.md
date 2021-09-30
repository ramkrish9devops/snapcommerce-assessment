# Snapcommerce Infrastructure Engineering Takehome Challenge

## Description

In this challenge, you will take a legacy hello-world HTTP server application, containerize it using Docker, and deploy it to the cloud with Kubernetes.

You do not need any previous experience with Ruby on Rails to complete this challenge, and no modifications or additions to the application code are necessary. You should be able to complete the challenge using a combination of the legacy application README below, previous experience, and online research. There is no time limit, but you should be able to complete it in less than 4 hours.

You must containerize the application yourself and include a Dockerfile. If you incur any expenses during this challenge, we will reimburse you up to CAD$25. Send a receipt / screenshot of the expenses incurred to your recruiter.

## Requirements

1. The application is containerized via a Dockerfile placed in the root of the project. If someone were to run `docker build .` it would complete successfully.
1. The application is deployed to and running inside Kubernetes in the cloud
1. The application is accessible over HTTP over the public internet at an address provided by you at the root path. Eg. `http://some-domain.somewhere.com/` or `http://<someipv4address>/`
1. The message displayed is "Hello world from production!". The last word in the message is controlled via the environment variable RAILS_ENV. Do not hardcode the value "production" into the application code or the built Docker image. Set the environment variable correctly at container run time.

## Bonus objectives

Presented in decreasing order of value. Do not implement all of these, one or two (or zero) is just fine.

- CI/CD the application is automatically tested and deployed when you push your code to your private git repository
- IaC (Infrastructure as Code): as much configuration as possible is stored in the git repo in text files, except for the value of RAILS_ENV
- Zero downtime upgrades: the application is available all throughout the deployment process
- Scalable horizontally and vertically: your deployment can handle arbitrary levels of traffic simply by adjusting configuration and spending more money. Assume for the purposes of this objective that the message is not static (no caches in front of the application are allowed)
- SSL configured correctly, no SSL warnings when accessing the webpage over SSL and a padlock sign is displayed in Chrome
- Local docker development: docker-compose.yaml file that allows developers to develop locally in a container
- Some other feature/improvement over the basic requirements that you'd like to highlight

## Submission details and short-form questions

Your final submission should be committed to the master branch, without erasing or changing the existing commit history.

Then, create a g-zipped tarball (.tar.gz) of the repository root including the .git folder. **Do not submit a pull request or otherwise make a public submission or expose your code to the public**

Follow these instructions to submit your assignment via email using a Google Drive link: https://support.google.com/mail/answer/6590?hl=en#zippy=%2Cmessages-that-have-attachments

You can also send us a Dropbox link, etc.

The application should be available at the URL you provided for 3 days past the date that you submit the solution.

Answer these questions in the README of your submission

1. What is the URL of the hosted application?

1. Briefly describe the technologies/platforms used (besides Docker, Kubernetes, and RoR). Describe where in the git repo these technologies/platforms are configured. If there are technologies/platforms configured manually in a web GUI or similar, include screenshots of all of the configuration.

1. Did you achieve any of the bonus objectives? Which ones and how? Optionally, for any bonus objectives that were not completed, describe in 1-3 sentences how you would complete the objective given more time or money.

# Legacy application README

## Setup / prerequisites

Requires MRI Ruby v2.7.2

Requires bundler 2.1.4: `gem install bundler -v 2.1.4`
 
To install library dependencies: `bundle install`

## Running the test suite

To run the test suite: `bundle exec rspec -fd`

## Running the server

To run the http server bound to all interfaces and listening to port 5000: `bundle exec rails server -b 0.0.0.0 -p 5000`
