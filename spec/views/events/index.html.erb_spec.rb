require 'rails_helper'

RSpec.describe "events/index", type: :view do
  it 'renders card partial each event' do
    category = Category.create!(id: 1, name: 'Entertainment')
    venue = Venue.create!(id: 1)
    event_1 = Event.create!(name: 'Vietnam Vs ThaiLan', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    event_2 = Event.create!(name: 'Liveshow Dan Truong', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    assign(:events, [event_1, event_2])
    render
    expect(view).to render_template(:partial => '_card', :count => 2)
  end
end

RSpec.describe 'events/created_events', :type => :view do
  it 'renders table of events' do
    category = Category.create!(id: 1, name: 'Entertainment')
    venue = Venue.create!(id: 1)
    event_1 = Event.create!(name: 'Vietnam Vs ThaiLan', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    event_2 = Event.create!(name: 'Liveshow Dan Truong', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    assign(:events, [event_1, event_2])
    render

    expect(rendered).to include('Vietnam Vs ThaiLan')
    expect(rendered).to include('Liveshow Dan Truong')
  end

  it 'renders message when there is no event' do
    assign(:events, [])
    render
    expect(rendered).to include('You did not create any event')
  end
end