require 'spec_helper'

describe "routing to homepage" do
  it "routes / to static_pages#index" do
    expect(:get => "/").to route_to(
      :controller => "static_pages",
      :action => "index"
    )
  end
end