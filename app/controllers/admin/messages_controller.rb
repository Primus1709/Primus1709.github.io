module Admin
  class MessagesController < BaseController
    before_action :set_message, only: %i[show destroy]

    def index
      @messages = Message.newest_first
    end

    def show
      @message.mark_read!
      @unread_count = Message.unread.count
    end

    def destroy
      @message.destroy!
      redirect_to admin_messages_path, notice: "Deleted the message from #{@message.name}.", status: :see_other
    end

    private

    def set_message
      @message = Message.find(params[:id])
    end
  end
end
