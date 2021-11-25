class InviteUser
  include Interactor::Organizer

  organize BuildUser, GenerateToken
end
