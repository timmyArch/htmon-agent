# Htmon::Agent

Http Monitoring Agent - Compatible with Htmon ...

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'htmon-agent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install htmon-agent

## Usage

The binary will create a loop, with should started by using systemd or any other kind of init system.

```bash
  htmon-agent --config /tmp/htmon-agent.conf --api http://basic:auth@htmon.to:3000
```

The config could looks like the following snipped.

```ruby
schema = load_schema

check interval: 2.seconds do |url| 
  push url: :keepalive, expires_after: 10.seconds
end

check interval: 10.seconds do |url| 
  push metric: "load",
    value: File.read('/proc/loadavg').split[0..2].join(','), 
    expires_after: 50.seconds
end

check interval: 5.minutes do |url| 
  push metric: "packages::system",
    value: `pacman -Syup | grep 'pkg.tar.xz' -c`.to_i,
    expires_after: 30.minutes
end

check interval: 5.minutes do |url| 
  push metric: "packages::gems",
    value: `gem outdated | wc -l`.to_i,
    expires_after: 30.minutes
end

check interval: 5.minutes do |url| 
  push metric: "filesystemusage::root",
    value: `df -h | grep -P ' /$'`.split[4],
    expires_after: 30.minutes
end

schema["htmon_processes"].to_a.each do |process|
  check interval: 1.minute do |url| 
  push metric: "process::#{process}", 
    expires_after: 2.minutes, 
    value: `pgrep -fla #{process.inspect} | grep -v pgrep | wc -l`.strip
  end 
end
```

Sample service file: 

```bash
>>> systemctl cat htmon-agent

# /etc/systemd/system/htmon-agent.service
[Unit]
Description=Htmon Agent
After=network-online.target

[Service]
User=root
ExecStart=/usr/bin/htmon-agent --config /etc/htmon-agent.conf --api http://test:moo@rails.moo.gl:3000
RestartSec=60
Restart=always

[Install]
WantedBy=multi-user.target
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/timmyArch/htmon-agent.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

