require 'spec_helper'

describe "static_pages" do
  it "routes / to static_pages#index" do
    expect(:get => "/").to route_to(
      :controller => "static_pages",
      :action => "index"
    )
  end

  it "routes / to static_pages#about" do
    expect(:get => "/about").to route_to(
      :controller => "static_pages",
      :action => "about"
    )
  end

  it "routes / to static_pages#submit" do
    expect(:get => "/submit").to route_to(
      :controller => "static_pages",
      :action => "submit"
    )
  end

  it "routes / to static_pages#privacy" do
    expect(:get => "/privacy").to route_to(
      :controller => "static_pages",
      :action => "privacy"
    )
  end
end

describe "categories" do

  it "routes /new to categories#new" do
    expect(:get => "/new").to route_to(
      :controller => "categories",
      :action => "new"
      )
  end

end