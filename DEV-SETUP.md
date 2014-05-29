# Development Instructions
 
 Work-in-progress.
 
 Adapted from https://github.com/codeforamerica/honolulu_answers/wiki/Installation-Instructions-for-OS-X-10.8-Mountain-Lion and personal experience.

## Installation

1. Make sure you have Ruby 1.9.3 installed. You can check this by running `ruby -v` in your terminal. [rvm](https://rvm.io/) is a great tool for managing Ruby installations.
1. Obtain API keys for [Searchify](https://www.searchify.com/), [BigHugeThesaurus](http://words.bighugelabs.com/api.php), [Amazon S3](http://aws.amazon.com/s3/), and [KissMetrics](http://support.kissmetrics.com/developers/) (optional).
1. Fork the repo on GitHub
1. Clone it `$ git clone git@github.com:YOUR-GH-USERNAME/answers.git`
1. `$ cd answers`
1. Create a `.env` file (`$ cp .env.example .env`). 
  - There is a sample .env file in the root directory of the application called ".env.sample" (you can see it if you type ls -a).
  - Fill in the blanks with your own API keys. 
  - Minimum keys needed are:
    - `SECRET_TOKEN`: run `rake secret` to generate one.
1. Install qt dependency with Homebrew
  - Install homebrew: `$ ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)`
  - Install qt: `$ brew install qt`
1. Check you have at least 1.2.x of bundler with bundle -v. To upgrade, first remove bundler with gem uninstall -ax bundler and then reinstall with gem install bundler -v 1.2.1
1. Install required gems: `$ bundle`
  - (`gem install bundler` if it's not already installed). You might have to open a new terminal tab after installing.)
1. `$ rake db:prepare`
1. `$ rake db:setup`
1. `$ foreman run rails s` to start the server. Go to http://localhost:3000/articles.

## Testing

Tests are located in the `spec` folder.

1. `$ rake spec`


## Development

This codebase adheres to the [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) model of branching.

1. Develop using [git-flow](http://nvie.com/posts/a-successful-git-branching-model/).
2. Send a pull request when the feature is ready (typically, it shouldn't break any tests). Pull requests should be made against the `dev` branch.
3. Repeat.

## Deployment

See TBD deployment doc.

### Gotchas

- [`capybara-webkit` error after running bundler](https://github.com/18F/answers_take1/issues/11)
- [pg error after running bundler](https://github.com/18F/answers_take1/issues/12)
- [Install GraphViz](https://github.com/18F/answers_take1/issues/13)

