class PagesController < ApplicationController
  def homepage
    render html:"This is page controller"
  end
end