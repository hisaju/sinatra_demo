require 'sinatra'
require 'dotenv'

Dotenv.load
$stdout.sync = true

require './app'
run App
