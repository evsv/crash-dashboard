class ApplicationController < ActionController::Base

  def hello
    render html: "Hello World!"
  end

  protect_from_forgery with: :exception
end
