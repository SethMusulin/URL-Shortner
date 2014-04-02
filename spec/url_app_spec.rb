require "spec_helper"
require 'capybara/rspec'
require_relative '../url_app'


Capybara.app = UrlApp

feature "URL Shortener" do
  scenario "user shortenes a URL" do
    visit "/"
    domain = current_url
    fill_in "Enter the URL you would like to &quot shorten &quot", :with => "http://google.com"
    click_on "Shorten"
    expect(page).to have_content "http://google.com"
    expect(page).to have_content "#{domain}"
    click_on "short_link"
    expect(current_url).to have_content "http://google.com"
  end

  scenario "User tries to shorten a non-url" do
    visit "/"
    fill_in "Enter the URL you would like to &quot shorten &quot", :with => "blah"
    click_on "Shorten"
    expect(page).to have_content "The text you entered is not a valid URL"
  end

  scenario "User enters nothing into the url field" do
    visit "/"
    fill_in "Enter the URL you would like to &quot shorten &quot", :with => ""
    click_on "Shorten"
    expect(page).to have_content "URL cannot be blank"
  end
end