require 'capybara/rspec'
require_relative '../url_app'

Capybara.app = UrlApp

feature "URL Shortener" do
  scenario "user goes to homepage" do
    visit "/"
    fill_in "Enter URL", :with => "www.google.com"
    click_on "Shorten"

    expect(page).to have_content "www.google.com"
    expect(page).to have_content "/1"
  end
end