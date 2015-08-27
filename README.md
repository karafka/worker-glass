# Sidekiq Glass

[![Build Status](https://travis-ci.org/karafka/sidekiq-glass.svg?branch=master)](https://travis-ci.org/karafka/sidekiq-glass) [![Code Climate](https://codeclimate.com/github/karafka/sidekiq-glass/badges/gpa.svg)](https://codeclimate.com/github/karafka/sidekiq-glass)

  Sidekiq worker wrapper that provides optional timeout and after failure (reentrancy).

## Reentrancy

If you don't know what is reentrancy, you can read about it [here](http://dev.mensfeld.pl/2014/05/ruby-rails-sinatra-background-processing-reentrancy-for-your-workers-is-a-must-be/).

## Setup
When creating a worker that inherits from SidekiqGlass::Worker, the perform_async method provided by Sidekiq is overriden in order to provide
flexibility in the max number of params a background job can be created with and in the time a background job can take to finish.
For this, the following methods can be defined:

| Method           | Arguments | Description                                                                                                   |
|------------------|-----------|---------------------------------------------------------------------------------------------------------------|
| self.timeout=    | Integer   | Set the number of seconds that a job can take to finish (if not defined, Sidekiq timeout will be applied)     |
| execute          | any_args  | Required method that will be invoked when calling Worker::perform_async                                       |
| after_failure    | any_args  | Optional method that will be invoked if the execute method fails                                              |

## Usage

Once you've set the gem, you can start using the SidekiqGlass::Worker as following:

```ruby
class Worker1 < SidekiqGlass::Worker
  self.timeout = 3600 # job can run for 1 hour max

  def execute(*ids)
    SomeService.new.process(ids)
  end

  def after_failure(*ids)
    SomeService.new.expire!(ids)
  end
end

Worker1.perform_async('id1', 'id2', 'id3')
```

```ruby
class Worker2 < SidekiqGlass::Worker
  def execute(first_param, second_param, third_param)
    SomeService.new.process(first_param, second_param, third_param)
  end
end

Worker2.perform_async(example1, example2, example3)
```

## Note on Patches/Pull Requests

Fork the project.
Make your feature addition or bug fix.
Add tests for it. This is important so I don't break it in a future version unintentionally.
Commit, do not mess with Rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull). Send me a pull request. Bonus points for topic branches.

Each pull request must pass our quality requirements. To check if everything is as it should be, we use [PolishGeeks Dev Tools](https://github.com/polishgeeks/polishgeeks-dev-tools) that combine multiple linters and code analyzers. Please run:

```bash
bundle exec rake
```

to check if everything is in order. After that you can submit a pull request.
