class MessagesController < ApplicationController
  # At most 5 messages per visitor every 10 minutes
  rate_limit to: 5, within: 10.minutes, only: :create, with: -> {
    redirect_to root_path(anchor: "contact"), alert: "That's a lot of messages. Try again in a few minutes."
  }

  def create
    # "website" is a hidden field people never see. Bots fill in every field,
    # so if it has a value we pretend it worked and throw the message away.
    if params.dig(:message, :website).present?
      redirect_to root_path(anchor: "contact"), notice: sent_notice
      return
    end

    @message = Message.new(message_params)

    if @message.save
      redirect_to root_path(anchor: "contact"), notice: sent_notice
    else
      load_home_page
      render "pages/home", status: 422
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end

  def sent_notice
    "Message sent. I'll reply by email."
  end
end
