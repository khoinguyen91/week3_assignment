require 'rails_helper'

RSpec.describe 'routing to signup', :type => :routing do
  it 'routes /sign_up to user#new' do
    expect(:get => '/sign_up').to route_to(
                                      :controller => 'users',
                                      :action => 'new'
                                  )
  end
end

RSpec.describe 'routing to login', :type => :routing do
  it 'routes /login to session#new' do
    expect(:get => '/login').to route_to(
                                      :controller => 'sessions',
                                      :action => 'new'
                                  )
  end
end

