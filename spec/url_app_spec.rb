require 'capybara/rspec'
require_relative '../url_app'


Capybara.app = UrlApp

feature "URL Shortener" do
  scenario "user shortenes a URL" do
    visit "/"
    fill_in "Enter the URL you would like to &quot shorten &quot", :with => "http://www.google.com/"
    click_on "Shorten"

    expect(page).to have_content "http://www.google.com/"
    expect(page).to have_content "/1"
    click_on "short_link"
    expect(current_url).to eq "http://www.google.com/"
  end
end