class Message < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  after_create_commit :broadcast_message

  private

  def broadcast_message
    ActionCable.server.broadcast 'chat_channel', message: render_message(self)
  end

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end
