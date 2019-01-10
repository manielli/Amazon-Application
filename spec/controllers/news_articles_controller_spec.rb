require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do

    let(:current_user) { FactoryBot.create :user }
    
    # let(:current_user) { FactoryBot.create :user }
    # vs.
    # def current_user
    #     @current_user ||= FactoryBot.create(:user)
    # end


    describe "#new" do
        context "without user signed in" do
            it "redirect the user to a new sign in session" do
                get(:new)

                expect(response).to redirect_to(new_session_path)
            end

            it "sets a danger flash message" do
                get(:new)

                expect(flash[:danger]).to be
            end
        end
        
        context "when user signed in" do
            before do
                session[:user_id] = current_user.id
            end

            it "renders a new template" do 
                get(:new)
    
                expect(response).to render_template(:new)
            end
    
            it "sets an instance variable with a new news article" do
                get(:new)
    
                expect(assigns(:news_article)).to(be_a_new(NewsArticle))
            end
        end
    end

    describe "#create" do
        def valid_request
            post(:create, params: { news_article: FactoryBot.attributes_for(:news_article) } )
        end

        context "without user signed in" do
            it "redirects to the new session" do
                valid_request

                expect(response).to redirect_to(new_session_path)
            end
        end
        
        context "with user signed in" do
            before do
                session[:user_id] = current_user.id
            end

            context "with valid paramters" do
                
                it "creates a new news article" do
                    count_before = NewsArticle.count
                    valid_request
                    count_after = NewsArticle.count
    
                    expect(count_after).to eq(count_before + 1)
                end
    
                it "redirects to the show page of that article" do
                    valid_request
                    news_article = NewsArticle.last
                    expect(response).to(redirect_to(news_article_url(news_article.id)))
                end
            end
        
    
            
            context "with invalid parameters" do
                def invalid_request
                    post(:create, params: { news_article: FactoryBot.attributes_for(:news_article, title: nil) } )    
                end
    
                it "doesn't create a news article" do
                    count_before = NewsArticle.count
                    invalid_request
                    count_after = NewsArticle.count
    
                    expect(count_after).to eq(count_before)
                end
    
                it "renders the new template" do
                    invalid_request
                    
                    expect(response).to render_template(:new)
                end
    
                it "assigns an invalid news article as an instance var" do
                    invalid_request
    
                    expect(assigns(:news_article)).to be_a(NewsArticle)
                    expect(assigns(:news_article).valid?).to be(false)
                end
            end
        end
    end

    describe "#show" do
        it "render the show template" do
            news_article = FactoryBot.create(:news_article)
            get(:show, params: { id: news_article.id } )
            expect(response).to render_template(:show)
        end

        it "set @news_article for the shown object" do
            news_article = FactoryBot.create(:news_article)
            get(:show, params: { id: news_article.id } )
            expect(assigns(:news_article)).to (news_article)
        end
    end

    describe "#destroy" do
        context "without signed in user" do
            it "redirects to a new session" do
                news_article = FactoryBot.create(:news_article)
                delete(:destroy, params: { id: news_article.id })

                expect(response).to redirect_to(new_session_path)
            end
        end

        context "with signed in user" do
            before do
                session[:user_id] = current_user.id
            end

            context "as non-owner" do
                it "doesn't remove a news article" do
                    news_article = FactoryBot.create(:news_article)
                    delete(:destroy, params: { id: news_article.id })

                    expect(NewsArticle.find_by(id: news_article.id)).to(eq(news_article))
                end

                it "redirects to the news article show page" do
                    news_article = FactoryBot.create(:news_article)
                    delete(:destroy, params: { id: news_article.id })

                    expect(response).to redirect_to(news_article_url(news_article.id))
                end

                it "flashes a danger message" do
                    news_article = FactoryBot.create(:news_article)
                    delete(:destroy, params: { id: news_article.id })

                    expect(flash[:danger]).to be
                end
            end

            context "as owner" do
                it "removes a news article from the db" do
                    news_article = FactoryBot.create(:news_article)
                    delete(:destroy, params: { id: news_article.id } )
                    expect(NewsArticle.find_by(id: news_article.id)).to be(nil)
                end
        
                it "redirects to the news article index" do
                    news_article = FactoryBot.create(:news_article)
                    delete(:destroy, params: { id: news_article.id } )
                    expect(response).to redirect_to(news_articles_url)
                end
            end
        end


    end

    describe "#index" do
        it "renders the index page" do
            news_article = FactoryBot.create(:news_article)
            get(:index)
            expect(response).to render_template(:index)
        end

        it "sets @news_articles for all shown news articles" do
            news_article_1 = FactoryBot.create(:news_article)
            news_article_2 = FactoryBot.create(:news_article)
            news_article_3 = FactoryBot.create(:news_article)
            news_articles = [news_article_1, news_article_2, news_article_3]
            get(:index)
            expect(assigns(:news_articles)).to eq(news_articles)
        end
    end

    describe "#edit" do
        context "without signed in user" do
            # it "redirects the user to the sign up or sign in page" do
            #     news_article = FactoryBot.create(:news_article)
            #     get(:edit, params: { id: news_article.id })

            #     if 
            #         expect(response).to redirect_to(new_session_path)
            #     else
            #         expect(response).to redirect_to()
            #     end
            # end

        end
        
        context "with signed in user" do
            before do
                session[:user_id] = current_user.id
            end

            context "as non-owner" do
                
                # it "redirects the user to the root page" do
                #     news_article = FactoryBot.create(:news_article)
                #     get(:edit, params: { id: news_article.id })

                #     expect(response).to redirect_to(news_article.id)
                # end

                # it "flashes a danger message" do 
                #     news_article = FactoryBot.create(:news_article)
                #     get(:edit, params: { id: news_article.id })

                #     expect(flash[:danger]).to be
                # end

            end

            context "as owner" do
                it "renders the show page of that news article" do
                    news_article = FactoryBot.create(:news_article)
                    get(:edit, params: { id: news_article.id } )
                    expect(response).to(render_template(:edit))
                end
        
                it "sets an instance variable with an edited news article" do
                    news_article = FactoryBot.create(:news_article)
                    get(:edit, params: { id: news_article.id } )
                    expect(assigns(:news_article)).to eq(news_article)
                end

                # it "renders the edit template" do
                
                # end

                # it "assign an instance variable to the news_article being edited" do

                # end
            end
        end


    end

    describe "#update" do
        before do
            @news_article = FactoryBot.create(:news_article)
        end

        context "with valid parameters" do
            def valid_request
                patch(:update, params: { id: @news_article.id, news_article: { title: @new_title, description: @new_description } } )
            end

            it "updates the news article" do
                # news_article = FactoryBot.create(:news_article) this is taken care of with the before do ... end above

                @new_title = "#{@news_article.title} Updated" # Note this Updated word is capitalized because of titleized method
                @new_description = "#{@news_article.description} Updated"
                valid_request
                # patch(:update, params: { id: @news_article.id, news_article: { title: new_title, description: new_description } } )
                # news_article.reload
                # expect(news_article.title).to eq("anything")
                # expect(news_article.description).to eq("anything else")
                # similar to below

                expect(assigns(:news_article).title).to eq(@new_title)
                expect(assigns(:news_article).description).to eq(@new_description)
            end

            it "redirects to the show page of that news article" do
                # news_article = FactoryBot.create(:news_article)
                @new_title = "#{@news_article.title} Updated" # Note this Updated word is capitalized because of titleized method
                @new_description = "#{@news_article.description} Updated"
                valid_request

                expect(response).to(redirect_to(@news_article))
            end
        end

        context "with invalid paramters" do

            def invalid_request
                patch(:update, params: { id: @news_article.id, news_article: { title: nil, description: nil } } )
            end

            it "doesn't update a news article" do
                # news_article = FactoryBot.create(:news_article) This is taken care of with before do ... end
                
                @new_title = "#{@news_article.title} Updated" # Note this Updated word is capitalized because of titleized method
                @new_description = "#{@news_article.description} Updated"

                invalid_request
                # patch(:update, params: { id: news_article.id, news_article: { title: nil, description: nil } } )
                
                # news_article.reload
                # expect(news_article.title).not_to eq(nil)
                # expect(news_article.description).not_to eq(nil)
                expect(assigns(:news_article).title).not_to eq(@news_title)
                expect(assigns(:news_article).description).not_to eq(@new_description)
            end

            it "renders the edit template" do
                # news_article = FactoryBot.create(:news_article)
                # patch(:update, params: { id: news_article.id, news_article: { title: nil, description: nil } } )
                invalid_request
                expect(response).to render_template(:edit)
            end
        end
    end
end