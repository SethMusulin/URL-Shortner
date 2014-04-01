require 'spec_helper'
require_relative '../lib/link'


describe Link do
  it "should contain an old url and an id" do
    new_link = Link.new("http://google.com")
    expect(new_link.old_url).to eq "http://google.com"
  end
end
