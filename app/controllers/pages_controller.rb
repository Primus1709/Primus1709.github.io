class PagesController < ApplicationController
  def home
    load_home_page
    @message = Message.new
  end
end
