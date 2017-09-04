# Worker Glass

[![Build Status](https://travis-ci.org/karafka/worker-glass.svg?branch=master)](https://travis-ci.org/karafka/worker-glass) 
[![Join the chat at https://gitter.im/karafka/karafka](https://badges.gitter.im/karafka/karafka.svg)](https://gitter.im/karafka/karafka?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

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

If you want to provide reentrancy for your workers, just prepend WorkerGlass::Reentrancy to your worker and define **after_failure** method that will be executed uppon failure:

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
* [Worker Glass Travis CI](https://travis-ci.org/karafka/worker-glass)
* [Worker Glass Coditsu](https://app.coditsu.io/karafka/repositories/worker-glass)

## Note on Patches/Pull Requests

Fork the project.
Make your feature addition or bug fix.
Add tests for it. This is important so we don't break it in a future versions unintentionally.
Commit, do not mess with Rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull). Send me a pull request. Bonus points for topic branches.

[![coditsu](https://coditsu.io/assets/quality_bar.svg)](https://app.coditsu.io/karafka/repositories/worker-glass)

Each pull request must pass our quality requirements. To check if everything is as it should be, we use [Coditsu](https://coditsu.io) that combinse multiple linters and code analyzers for both code and documentation.

Unfortunately, it does not yet support independent forks, however you should be fine by looking at what we require.

Please run:

```bash
bundle exec rake
```

to check if everything is in order. After that you can submit a pull request.
