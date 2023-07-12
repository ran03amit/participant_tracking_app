## Setup

1. Clone the repository:

```
git clone git@github.com:ran03amit/participant_tracking_app.git
```

2. Navigate to rails project folder

```
cd participant_tracking_app
```

3. Install the dependencies

```
rvm list
rvm use ruby-3.0.0
bundle install
rails db:migrate
rails db:seed
```

## Running the Tests using RSpec

To run the tests, execute the following command:

```
rspec spec
```


## Running the Service

To start the service, run the following command:

```
rails server
```

The service will be accessible at http://localhost:3000.
