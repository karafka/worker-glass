# Worker Glass [Unmaintained]

**Note**: This library is no longer in use in the Karafka ecosystem. It was developed for Karafka versions prior to `1.0`. If you're using this library and want to take it over, please ping us.

[![Build Status](https://github.com/karafka/worker-glass/workflows/ci/badge.svg)](https://github.com/karafka/worker-glass/actions?query=workflow%3Aci)
[![Gem Version](https://badge.fury.io/rb/worker-glass.svg)](http://badge.fury.io/rb/worker-glass)
[![Join the chat at https://slack.karafka.io](https://raw.githubusercontent.com/karafka/misc/master/slack.svg)](https://slack.karafka.io)

WorkerGlass provides optional timeout and after failure (reentrancy) for background processing worker engines (like Sidekiq, Resque, etc).

## Reentrancy

If you don't know what is reentrancy, you can read about it [here](http://dev.mensfeld.pl/2014/05/ruby-rails-sinatra-background-processing-reentrancy-for-your-workers-is-a-must-be/).

## Setup

If you want to use timeout and/or reentrancy, please add appropriate modules into your worker.

WorkerGlass allows to configure following options:

| Method           | Arguments | Description                                                                              |
|------------------|-----------|------------------------------------------------------------------------------------------|
| self.logger=     | Logger    | Set logger which will be used by Worker Glass (if not defined, null logger will be used) |

## Usage

WorkerGlass has few submodules that you can prepend to your workers to obtain given functionalities:

| Module                  | Description                                                       |
|-------------------------|-------------------------------------------------------------------|
| WorkerGlass::Reentrancy | Provides additional reentrancy layer if anything goes wrong       |
| WorkerGlass::Timeout    | Allows to set a timeout after which a given worker task will fail |


### WorkerGlass::Timeout

If you want to provide timeouts for your workers, just prepend WorkerGlass::Timeout to your worker and set the timeout value:

```ruby
class Worker2
  prepend WorkerGlass::Timeout

  self.timeout = 60 # 1 minute timeout

  def perform(first_param, second_param, third_param)
    SomeService.new.process(first_param, second_param, third_param)
  end
end

Worker2.perform_async(example1, example2, example3)
```

### WorkerGlass::Reentrancy

If you want to provide reentrancy for your workers, just prepend WorkerGlass::Reentrancy to your worker and define **after_failure** method that will be executed upon failure:

```ruby
class Worker3
  prepend WorkerGlass::Reentrancy

  def perform(first_param, second_param, third_param)
    SomeService.new.process(first_param, second_param, third_param)
  end

  def after_failure(first_param, second_param, third_param)
    SomeService.new.reset_state(first_param, second_param, third_param)
  end
end

Worker3.perform_async(example1, example2, example3)
```

## References

* [Karafka framework](https://github.com/karafka/karafka)
* [Worker Glass Actions CI](https://github.com/karafka/worker-glass/actions?query=workflow%3Aci)
* [Worker Glass Coditsu](https://app.coditsu.io/karafka/repositories/worker-glass)

## Note on contributions

First, thank you for considering contributing to the Karafka ecosystem! It's people like you that make the open source community such a great community!

Each pull request must pass all the RSpec specs, integration tests and meet our quality requirements.

Fork it, update and wait for the Github Actions results.
