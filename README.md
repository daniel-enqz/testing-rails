# RSpec workshop

In this exercise repository we will cover the fundamentals of unit testing for our Rails application.
RSpec is a widely used test framework for Ruby. We will use [rspec-rails](https://github.com/rspec/rspec-rails), that provides a straightforward integration with Rails.
We will also cover some basic tools that will help us write more readable tests.

## Setup

1. Add the following gems in your Gemfile and run `bundle`:

```
group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker", require: false
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 6.0.0"
end


group :test do
  gem "rails-controller-testing"
  gem "rspec-retry"
  gem "shoulda-matchers"
end

```

2. Run `rails generate rspec:install`

This will add two configuration files: `rails_helper.rb` and `spec_helper.rb`.

3. Read the content of the `spec_helper.rb` and uncomment the initial settings suggested. You can later turn some of them off as you see fit. 

4. In the `rails_helper.rb`, add the following code at the end of the `RSpec.configure do |config|` block to include methods that we will be using in our tests:
```  
config.include FactoryBot::Syntax::Methods

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

```

Solution on branch `1/setup`

## Factories

Factories allow us to create dummy data to use in our tests. You can find the documentation of `factory_bot_rails` in [this link](https://github.com/thoughtbot/factory_bot_rails).

1. We will use a generator to create our first factory: 

`rails g factory_bot:model author`

This will create the file `authors.rb` inside `spec/factories`.

2. Use the gem's [definition syntax](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#defining-factories) to define the factory.

3. Now we will introduce `faker` methods to use random names, last names and emails in our factory. In order to do this, first add the following line at the top of the `authors.rb` file:
`require "faker"`.

Take a look at [faker's documentation](https://github.com/faker-ruby/faker#usage) to see how to create fake data.

4. Add a factory for the `Book` model. Use `faker` to generate random titles.

Solution on branch `2/factories`


## Model tests

In the MVC pattern, the M represents the models, which are the baseline of our application. If we take a look at our `Author` and `Book` models, we will see several pieces that can be tested in isolation.
Unit testing is the technique used to test small parts of the application in isolation. 

1. Use the following generator to create a spec file for the `Author` model:

`rails generate rspec:model author`

Be careful not to overwrite the factories we just created (answer "n" when prompted).

2. Now create the following specs for the `Book` model. Use [shoulda matchers](https://matchers.shoulda.io/docs/v5.1.0/#activemodel-matchers) to test validations and associations.
  - Validations
  - Associations
  - Scopes

Use your factories to create the data for your tests.

4. Finally, we will add a section to test our methods. Currently the `Book`model contains one public method, so we're gonna test it.
Add [traits](https://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md#traits) to your books factory to create "Non-fiction" and "Fiction" books.
Use these traits to test the `type?` method. 

Solution on branch `3/models`

## Controller tests

In the MVC pattern, the C is for Controller. Controllers in Rails accept HTTP requests as their input and deliver back and HTTP response as an output.
We want to make sure our controller actions are returning the expected response given a certain request. In this exercise we will test the `books_controller.rb`.

In the books controller we have certain actions that requite author authentication. Meaning the author has to log in to do actions such as creating or editing their books.

1. For the author log in we can use some Devise helpers that allow an easy log in. You must include the following lines in the `spec/rails_herlper.rb `file.

* config.include Warden::Test::Helpers

* config.include Devise::Test::ControllerHelpers, type: :controller

2. Once you have this, you can sign in you author by using the method `sign_in(author)`
3. Create the request and test the response. You can use `have_http_status(:ok)` to verify the status is correct.

Solution on branch `4/controllers`

## Additional resources

- [Better specs](https://www.betterspecs.org/): A collection of best practices for testing Ruby code.
- Not sure when to use "describe" and "context"? [This post](http://lmws.net/describe-vs-context-in-rspec) explains the difference.
- [Validations are behavior, associations are structure](http://blog.davidchelimsky.net/blog/2012/02/12/validations-are-behavior-associations-are-structure/): David Chelimsky's (the creator of RSpec) viewpoint about why we should not test associations.
