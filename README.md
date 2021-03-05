# Logstash cumulative sum filter
*Was developed and tested with logstash 7.6*

This is a plugin for [Logstash](https://github.com/elastic/logstash). 

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

## Documentation

This plugin is used to do a simple cumulative sum. It has 3 simple parameters:
1. **fields** *[array, required]* this contains the name of the fields that will contain the current cumulative sum value
1. **add_values** *[hash]* a dictionary that indicates the value to add for each field. Defaults to 0
1. **initial_values** *[hash]* a dictionary that indicates the value to use if no stored value is found. Defaults to 0

You can use it in this simple way:
```
filter {
  cusum{
    fields => ["apples","bananas"]
    add_values => {
        "apples"  => "%{apples_to_add}"
        "bananas" => "-2"
      }
    initial_values => {
        "bananas" => "%{[default_bananas]}"
      }
  }
}	
```

## How to install

### 1. From gem file
- Download the latest gemfile from releases

- Install in logstash
```
/bin/logstash-plugin install /path/to/gem/logstash-filter-cumsumm-<version>.gem
```

- Run logstash and have fun

### 2. Build it yourself
- To get started, you'll need JRuby with the Bundler gem installed.

- Clone or download this repo

- Install dependencies
```
bundle install
```

- compile gem file
```
gem build logstash-filter-example.gemspec
```

- Install the plugin as in **1.**