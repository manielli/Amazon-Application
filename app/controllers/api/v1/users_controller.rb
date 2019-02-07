class Api::V1::UsersController < Api::ApplicationController
    before_action :authenticate_user!

    def current
        render json: { status: 200 , current_user: ActiveModelSerializers::SerializableResource.new(current_user).as_json }
        # Line below didn't work so steve added the line above to get the current_user in our awesome-answers-react-nov-2018 react app
    end
end
