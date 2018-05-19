require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
   let(:title) { RandomData.random_sentence }
   let(:body) { RandomData.random_paragraph }
 # #3
   let(:topic) { Topic.create!(name: name, description: description) }
 # #4
   let(:sponsored_post) { topic.sponsored_posts.create!(title: title, body: body, price: 99) }

   it { is_expected.to belong_to(:topic) }


   describe "attributes" do
     it "has a title, body, and price attribute" do
       expect(sponsored_post).to have_attributes(title: title, body: body, price: 99)
     end
   end
end
