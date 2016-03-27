require 'rails_helper'

RSpec.describe Event, type: :model do
	context "validations" do
		it 'Check the presence of extended_html_description' do
			category = Category.create(id: 1)
			venue = Venue.create(id: 1)
			event = Event.new(name: 'event name', starts_at: DateTime.current, ends_at: DateTime.current, category: category, venue: venue, published: true)
			event.save
			error_message = "Extended html description can't be blank"
			expect(event.errors.full_messages).to include error_message
		end
		it 'Check start date should less than end date' do
			category = Category.create!(id: 1, name: 'Entertainment')
			venue = Venue.create!(id: 1)
			event = Event.new(name: 'event', starts_at: DateTime.current, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: true, extended_html_description: 'content')
			event.save
			error_message = "Starts at must be before end time"
			expect(event.errors.full_messages).to include error_message
		end
	end
	context "check search method" do
		it 'Only upcoming event show' do
			category = Category.create!(id: 1, name: 'Entertainment')
			venue = Venue.create!(id: 1)
			event_1 = Event.create!(name: 'Vietnam Vs ThaiLan', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: true, extended_html_description: 'a')
			event_2 = Event.create!(name: 'Liveshow Dan Truong', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: true, extended_html_description: 'b')
			event_3 = Event.create!(name: 'Liveshow My Tam', starts_at: DateTime.current - 3.days, ends_at: DateTime.current + 2.days, category: category, venue: venue, published: true, extended_html_description: 'c')
			event_4 = Event.create!(name: 'blah', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: true, extended_html_description: 'd')
			expect(Event.search(nil)).to match_array([event_2, event_4, event_3])
		end
		it 'Return match search value' do
			category = Category.create!(id: 1, name: 'Entertainment')
			venue = Venue.create!(id: 1)
			event_1 = Event.create!(name: 'Vietnam Vs ThaiLan', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: true, extended_html_description: 'content')
			event_2 = Event.create!(name: 'Liveshow Dan Truong', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: true, extended_html_description: 'content')
			event_3 = Event.create!(name: 'Liveshow My Tam', starts_at: DateTime.current - 3.days, ends_at: DateTime.current + 2.days, category: category, venue: venue, published: true, extended_html_description: 'content')
			event_4 = Event.create!(name: 'blah', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: true, extended_html_description: 'content')
			expect(Event.search('Liveshow')).to match_array([event_2, event_3])
		end
		it 'Return no  no events' do
			category = Category.create!(id: 1, name: 'Entertainment')
			venue = Venue.create!(id: 1)
			event_1 = Event.create!(name: 'Vietnam Vs ThaiLan', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: true, extended_html_description: 'content')
			event_2 = Event.create!(name: 'Liveshow Dan Truong', starts_at: DateTime.current - 1.day, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: true, extended_html_description: 'content')
			event_3 = Event.create!(name: 'Liveshow My Tam', starts_at: DateTime.current - 3.days, ends_at: DateTime.current - 2.days, category: category, venue: venue, published: true, extended_html_description: 'content')
			event_4 = Event.create!(name: 'blah', starts_at: DateTime.current - 1.day, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: true, extended_html_description: 'content')
			expect(Event.search('Liveshow').count).to eq(0)
		end
	end
end
