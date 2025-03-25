# PHP extension : AMQP

This extension can communicate with any AMQP spec 0-9-1 compatible server, such
as RabbitMQ, OpenAMQP and Qpid, giving you the ability to create and delete
exchanges and queues, as well as publish to any exchange and consume from any
queue.

## Installation

First install the rabbitmq-c library using brew:

```bash
brew install rabbitmq-c
```

Install for every PHP version that requires the extension:

```bash
sphp 8.3 && pecl install amqp
sphp 8.4 && pecl install amqp
```

Hit enter to autodetect when it ask for the location of the library:

```
Set the path to librabbitmq install prefix [autodetect] :
```

Reload PHP after installing:

```bash
sphp 8.3
sphp 8.4
```

It should now be in the php info output: https://localhost/phpinfo.php.
