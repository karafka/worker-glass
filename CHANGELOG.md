# WorkerGlass changelog

## 0.2.5 (2020-04-24)
- drop ruby 2.2 support
- drop ruby 2.3 support
- drop ruby 2.4 support
- Ruby 2.5.5 support
- Ruby 2.6.5 support
- Ruby 2.7.1 support
- Removed rake as one of dependencies
- Replace Travis with GH Actions
- Add certificates support
- Add JRuby support
- Add TruffleRuby support
- Change license to LGPL-3.0

## 0.2.3
- Gem bump
- Ruby 2.4.1 as default
- Coditsu quality hookup
- Readme updates

## 0.2.2
- Gem dump x2
- Ruby 2.1.* support dropped
- ~~Ruby 2.3.3 as default~~
- Ruby 2.4.0 as default
- Ruby 2.2 as minimal version
- Added .rspec for default spec helper require

## 0.2.0
- Renamed from SidekiqGlass to WorkerGlass because if now does not require Sidekiq anymore to work. It will provide additional worker functionalities to any type of backend processing layer as long as it has a #perform method.
- Switched to Mongoid like feature providing by including/prepending functionalities
- WorkerGlass no longer required
- WorkerGlass::Timeout
- WorkerGlass::Reentrancy
- Dev Tools and gems update

## 0.1.4

- New Sidekiq (4.0.1) version dump

## 0.1.3

- Added null-logger gem

## 0.1.2

- SidekiqGlass logger implementation

## 0.1.1

- Celluloid lock due to some Celluloid internal issues

## 0.1.0

- Initial released version
