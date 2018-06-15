require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_topic) { create(:topic) }
   let(:my_user) { create(:user) }
   let(:other_user) { create(:user) }
   let(:user_post) { create(:post, topic: my_topic, user: other_user) }
  let(:my_vote) { Vote.create!(value: 1) }

  describe "not signed in" do
 # #1
     let(:factory_user) { create(:vote) }

     before do
       post :create, params: { vote: new_vote_attributes }
     end

 # #2
     it "returns http success" do
       get :show, params: { id: factory_user.id }
       expect(response).to have_http_status(:success)
     end

     it "renders the #show view" do
       get :show, params: { id: factory_vote.id }
       expect(response).to render_template :show
     end

     it "assigns factory_vote to @user" do
       get :show, params: { id: factory_vote.id }
       expect(assigns(:vote)).to eq(factory_vote)
     end
   end

  context "guest" do
    describe "POST up_vote" do
      it "redirects the user to the sign in view" do
        post :up_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST down_vote" do
      it "redirects the user to the sign in view" do
        delete :down_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "signed in user" do
    before do
      create_session(my_user)
      request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
    end

    describe "POST up_vote" do
      it "the users first vote increases number of post votes by one" do
        votes = user_post.votes.count
        post :up_vote, params: { post_id: user_post.id }
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it "the users second vote does not increase the number of votes" do
        post :up_vote, params: { post_id: user_post.id }
        votes = user_post.votes.count
        post :up_vote, params: { post_id: user_post.id }
        expect(user_post.votes.count).to eq(votes)
      end

      it "increases the sum of post votes by one" do
        points = user_post.points
        post :up_vote, params: { post_id: user_post.id }
        expect(user_post.points).to eq(points + 1)
      end

      it ":back redirects to posts topic show" do
        request.env["HTTP_REFERER"] = topic_path(my_topic)
        post :up_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to(my_topic)
      end
    end

      describe "POST down_vote" do
        it "the users first vote increases number of post votes by one" do
          votes = user_post.votes.count
          post :down_vote, params: { post_id: user_post.id }
          expect(user_post.votes.count).to eq(votes + 1)
      end

        it "the users second votes does not increase the number of votes" do
          post :down_vote, params: { post_id: user_post.id }
          votes = user_post.votes.count
          post :down_vote, params: { post_id: user_post.id }
          expect(user_post.votes.count).to eq(votes)
        end

        it "decreases the sum of post votes by one" do
          points = user_post.points
          post :down_vote, params: { post_id: user_post.id }
          expect(user_post.points).to eq(points - 1)
        end

        it ":back redirects to posts show page" do
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
        post :down_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to([my_topic, user_post])
      end

      it ":back redirects to posts topic show" do
        request.env["HTTP_REFERER"] = topic_path(my_topic)
        post :down_vote, params: { post_id: user_post.id }
        expect(response).to redirect_to(my_topic)
      end
    end
  end
end
