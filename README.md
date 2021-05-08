Test case
=========

To build and run the application:

```docker-compose build && docker-compose run```

For local development, you can run the app directly with

```./src/server.rb```

assuming that the required gems are available in your environment.

Working method
==============

A dockerized application seemed like a good idea. Since I wanted to use Ruby I went to <https://hub.docker.com/_/ruby>, which has a `Dockerfile` example as a good starting point. I needed to read up on [Gemfiles](https://bundler.io/gemfile.html).

The default Ruby web server `WEBrick` is simple enough for this purpose, so creating a Hello world web server went pretty fast. A `docker-compose.yaml` file is a big help since we are going to run `docker build` and `docker run` a lot.

Implementing the backend also went rather quickly with some help from the `HTTParty` gem.

OK, so the backend and frontend are supposed to run on different ports. In the real world I would put the backend and the frontend in different Git repositories, but we are not going to do that. How about running two processes in the same container? That entails having a wrapper script... Ugh. It's documented in the official Docker documentation and it isn't pretty. I considered letting the server listen to multiple ports and serving different contexts on each port which I guess is doable, but I ended up with two server threads started from the same script, which isn't too bad. The backend and frontend parts were split into separate files.

Now for the frontend. It would have been quite easy to generate the page on the server by getting the data directly from the backend service and using `SVG::Graph`. Perhaps an admissible solution, but I considered it cheating. Consequently I spent far too much time on creating the frontend, since my Javascript is a little rusty and my current knowledge of Javascript libraries is pretty non-existent.

I struggled with the documentation for Chart.js but at least the library is contained in a single file, so I stuck with it. I did not want to dabble with NPM or any Javascript frameworks since that would have taken me even longer.

In the real world
=================
  * One repo for backend, one for frontend and perhaps another one to rule them all (to make it into an application).
  * If possible, use a minimal base Docker image such as `docker:alpine` or `docker:slim`.
  * Write test cases. Hard to see any potential unit tests but it should be possible to create integration tests for both backend and frontend.
  * Consider deployment, e.g. Kubernetes Deployment files (depending on target system).
  * Improve the error handling.
  * Add health-check endpoints.
  * Put the Javascript in a separate file.
  * Add CSS.
  * Set fixed versions of gems, ruby image etc. instead of using latest.
