class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters
end
