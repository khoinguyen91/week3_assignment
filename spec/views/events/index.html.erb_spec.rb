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
