require 'spec_helper'

describe "StaticPages" do
  describe "Homepage" do
    it "should return a HTTP 200 OK status code" do
      get root_path
      response.status.should be(200)
    end
  end
end
