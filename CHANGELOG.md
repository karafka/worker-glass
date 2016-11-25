# WorkerGlass changelog

## 0.2.2
- Gem dump
- Ruby 2.1.* support dropped
- Ruby 2.3.3 as default
- Ruby 2.2 as minimal version

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
