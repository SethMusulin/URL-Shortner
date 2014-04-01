require 'spec_helper'
require_relative '../lib/link_repo'
require_relative '../lib/link'

describe LinkRepo do
  it "should initialize as an array" do
    expect(LinkRepo.new.links).to eq []
  end

  it "should allow a Link to be added to the links list" do
    repo = LinkRepo.new
    link = Link.new("http://google.com")
    repo.add(link.old_url)
    expect(repo.links).to eq [{ url_to_redirect_to: "http://google.com", id: 1}]
    link = Link.new("http://cnn.com")
    repo.add(link.old_url)
    expect(repo.links.last).to eq ({ url_to_redirect_to: "http://cnn.com", id: 2})
  end
end