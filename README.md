# Participant Tracking App

The Participant Tracking App is a Ruby on Rails application designed to track participants across multiple registries. It allows coordinators to manage registries, coordinators, and participants efficiently.

## Features

- Create and manage registries, including name, location, and state (open or closed).
- Add and manage coordinators with unique email addresses, including name and phone number.
- Assign multiple coordinators to each registry.
- Register participants with details such as name, gender, and date of birth.
- Enroll participants in multiple open registries.
- Prevent participants from enrolling multiple times in the same registry.
- Capture enrollment information, including date, method of contact (phone or email), remarks, and the enrolling coordinator.
- View a list of participants for a given registry, grouped by the coordinator who enrolled them.

## Installation

To set up the Participant Tracking App locally, follow these steps:


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
Ruby(ruby 3.0.0), Rails(Rails 7.0.6)

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


## Answers to the additional questions in assessment

1. Provide sql for aggregate count of participants by year of birth.
```
birth_year_counts = Participant.group("strftime('%Y', date_of_birth)").count
birth_year_counts = birth_year_counts.sort_by { |year, _count| year.to_i }

birth_year_counts.each do |year, count|
  puts "Year: #{year}, Count: #{count}"
end

OR

Participant.all.group_by{|gb| gb['date_of_birth'].to_date.year}.map{|year, details| [year, details.count]}.to_h

[RAW QUERY]: SELECT COUNT(*) AS "count_all", strftime('%Y', date_of_birth) AS "strftime_y_date_of_birth" FROM "participants" GROUP BY strftime('%Y', date_of_birth)
```

2. Provide sql for aggregate count of participants by coordinator and gender.
```
participants = Participant.joins(enrollments: :coordinator)
                          .select("participants.*, coordinators.name AS coordinator_name")
                          .group("coordinators.name, participants.gender")

participants.each do |participant|
  puts "Participant Name: #{participant.name}, Coordinator: #{participant.coordinator_name}, Gender: #{participant.gender}"
end;0

[RAW QUERY]: SELECT participants.*, coordinators.name AS coordinator_name FROM "participants" INNER JOIN "enrollments" ON "enrollments"."participant_id" = "participants"."id" INNER JOIN "coordinators" ON "coordinators"."id" = "enrollments"."coordinator_id" GROUP BY coordinators.name, participants.gender
```

3. Export participants for each coordinator in a csv format.
```
Export participants functionality provided on coordinator index page
```