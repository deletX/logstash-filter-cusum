# encoding: utf-8
# TODO: make tests
require_relative '../spec_helper'
require "logstash/filters/cusum"

describe LogStash::Filters::Cusum do
  describe "Add 1" do
    let(:config) do <<-CONFIG
      filter {
        cusum {
          fields => ["some_field"]
          add_values => {"some_field" => "%{[value]}"}
        }
      }
    CONFIG
    end

    sample("value" => "1") do
      expect(subject).to include("some_field")
      expect(subject.get('some_field')).to eq(1)
    end
  end
end
