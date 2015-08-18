# Sidekiq Glass Worker

 Sidekiq worker wrapper that provides optional timeout and after failure (reentrancy)


## Setup
When creating a worker that inherits from Strike::BaseWorker, the perform_async method provided by Sidekiq is overriden in order to provide
flexibility in the max number of params a background job can be created with and in the time a background job can take to finish.
For this, the following methods can be defined:

| Method           | Arguments | Description                                                                                                   |
|------------------|-----------|---------------------------------------------------------------------------------------------------------------|
| self.timeout=    | Integer   | Set the number of seconds that a job can take to finish (if not defined, Sidekiq timeout will be applied)     |
| execute          | any_args  | Required method that will be invoked when calling Worker::perform_async                                       |
| after_failure    | any_args  | Optional method that will be invoked if the execute method fails                                              |

## Usage

Once you've set the gem, you can start using the Strike::BaseWorker as following:

```ruby
class Worker1 < SidekiqGlass::Worker
    self.timeout = 1.hour # job can run for 3600 seconds maximum

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
