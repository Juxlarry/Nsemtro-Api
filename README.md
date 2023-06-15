# Nsemtro-Api
A rails only API for a blog application. 

StartUp Process: 
- Clone Repo 
- run bundle install to gems
- rails generate rspec:install to setup rspec
- rails g devise:install && rails g devise user to setup user 
- rails active_storage:install to setup active_storage attachments
- rails db create & rails db:migrate to steup database and db tables

API Setup quite simple: 
 - Blog Model
 - A user model
 - Categories model
 - RSpec Test Bed
 
API Features
- A devise user with jwt auuthentication 
- User avatar upload
- Blog image(s) upload
- A serializer for JSON responses 
- Test Coverage using RSpec 

Test Coverage
- With the help of Simple Cov Gem, this API test coverage is 98.67%
