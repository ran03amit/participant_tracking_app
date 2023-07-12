# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create coordinators
coordinators = Coordinator.create([
  { name: 'John Doe', email: 'john@example.com', phone_number: '1234567890' },
  { name: 'Jane Smith', email: 'jane@example.com', phone_number: '9876543210' }
])

# Create registries
registries = Registry.create([
  { name: 'Registry 1', location: 'Location 1' },
  { name: 'Registry 2', location: 'Location 2' }
])

# Assign coordinators to registries
registries[0].coordinators << coordinators[0]
registries[1].coordinators << coordinators[0]
registries[1].coordinators << coordinators[1]

# Create participants and enrollments
participants = Participant.create([
  { name: 'Participant 1', gender: 'Male', date_of_birth: Date.new(1990, 1, 1) },
  { name: 'Participant 2', gender: 'Female', date_of_birth: Date.new(1985, 3, 15) },
  { name: 'Participant 3', gender: 'Male', date_of_birth: Date.new(1995, 7, 10) },
  { name: 'Participant 4', gender: 'Female', date_of_birth: Date.new(1998, 12, 20) }
])

# Enroll participants into registries
Enrollment.create([
  {
    registry: registries[0],
    coordinator: coordinators[0],
    participant: participants[0],
    date_of_enrollment: Date.today,
    method_of_contact: 'Phone',
    remarks: 'Enrolled in Registry 1'
  },
  {
    registry: registries[0],
    coordinator: coordinators[0],
    participant: participants[1],
    date_of_enrollment: Date.today,
    method_of_contact: 'Email',
    remarks: 'Enrolled in Registry 1'
  },
  {
    registry: registries[1],
    coordinator: coordinators[0],
    participant: participants[0],
    date_of_enrollment: Date.today,
    method_of_contact: 'Phone',
    remarks: 'Enrolled in Registry 2'
  },
  {
    registry: registries[1],
    coordinator: coordinators[1],
    participant: participants[2],
    date_of_enrollment: Date.today,
    method_of_contact: 'Phone',
    remarks: 'Enrolled in Registry 2'
  },
  {
    registry: registries[1],
    coordinator: coordinators[1],
    participant: participants[3],
    date_of_enrollment: Date.today,
    method_of_contact: 'Email',
    remarks: 'Enrolled in Registry 2'
  }
])
