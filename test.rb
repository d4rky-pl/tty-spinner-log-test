require 'bundler/setup'
require "tty-spinner"
require "tty-command"

spinner = TTY::Spinner.new("[:spinner] Running :method", format: :bouncing_ball)
cmd = TTY::Command.new(printer: :null)

spinner.auto_spin

spinner.update(method: "with array buffer")

buffer = []
cmd.run("docker-compose up") do |out, err|
  buffer << out if out
  buffer << err if err
  spinner.log(buffer.join)
end

sleep 1

spinner.update(method: "with array buffer (inside block)")

cmd.run("docker-compose up") do |out, err|
  buffer = []
  buffer << out if out
  buffer << err if err
  spinner.log(buffer.join)
end

spinner.update(method: "just passing err")

cmd.run("docker-compose up") do |out, err|
  spinner.log(err)
end

spinner.stop("Done")
