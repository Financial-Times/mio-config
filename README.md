# Mio Config

This simple rubygem will allow for a codified build out of mio resources and configuration.

The builders are largely based on [rails migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html) and should contain nothing new to most developers, ruby or not.

## Installation

In your Gemfile:

```ruby
gem 'mio-config', git: 'ssh://git@git.svc.ft.com:7999/video/mio-config.git'
```
### Configuration

`mio-config` relies on the config file: `./config/mio.yml`, which must live in the root of your project. It looks like:

```yaml
----
base_url: https://my-mio.example.com
username: admin
password: passwd
```

**Note:** this may also be templated- it uses [ERB](http://ruby-doc.org/stdlib-2.3.0/libdoc/erb/rdoc/ERB.html) under the hood.

```yaml
----
base_url: <%= ENV.fetch('MIO_URL', 'https://my-mio.example.com' %>
username: admin
password: <%= File.read( "#{ENV.fetch('HOME')}/.passwd" ) %>
```

## Usage

We expose a couple of rake tasks:

```bash
$ bundle exec rake -T
rake mio:migrate                     # Handle migrations (via mio:migrate:up)
rake mio:migrate:create[model,desc]  # Create a new migration
rake mio:migrate:up                  # Run migrations
```

### Create migrations

You're more than welcome to handcraft these- they're pretty cimple. You may, though, use the skeleton we create:

```bash
$ please rake mio:migrate:create[s3,'create an s3 bucket for ingestion']
```

**NOTE:** There is a lack of spaxes around stuff on purpose. Rake gets a bit funny with them in.

This rake taks will look at the model and pre-populate the necessary arguments. From there any *Plain Ol' Ruby* will work. Probably.

## Development

This project was built and tested with ruby 2.3.0.

To install this via rbenv:

### OSX
```bash
$ # Install rbenv if not installed
$ brew install rbenv
$ echo 'eval "$(rbenv init -)" ' >> ~/.bash_proile
$ Install ruby 2.3.0
$ rbenv install 2.3.0
$ # Either set as global version:
$ rbenv global 2.3.0
$ # Or install as local to this project:
$ rbenv local 2.3.0
```

### Other environments

Homebrew may be installed via your package manager or from [github](https://github.com/rbenv/rbenv#basic-github-checkout)


## Building etc

```bash
$ bundle install
```

## Adding models

Any model added to `lib/mio/model` will be autoloaded. The final class name becomes the caller method:

A model called:

```ruby
class Mio
  class Model
    class Foo
    end
  end
end
```

will, then, be accessible by the helper method `foo`.

A migration would look like:

```ruby
migrate 'a simple test` do
  foo do
    #blah
  end
end
```

### Helper methods

Models define a `resource` and a set of `fields`. The resource is the path appended to `base_uri`; with `example.com/api/workflows` `example.com` is the `base_uri` and `workflows` is the `resource`. (The `/api` path is added in the gem).

The `s3` model, for example, looks a little like:

```ruby
class Mio
  class Model
    class S3 < Model
      set_resource :resources
      field :name, String, /^(?!\s*$).+/
# SNIP
```

`#field` has the signature:

```ruby
def field key, type, matcher=nil
```
