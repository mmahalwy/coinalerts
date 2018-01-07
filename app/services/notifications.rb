class Notifications
  def initialize(send_notifications: Rails.env.production?)
    @send_notifications = send_notifications
  end

  def send_twilio_notification(body)
    return Rails.logger.debug "Sent: #{body}" if !@send_notifications

    TwilioClient.api.account.messages.create(
      from: TWILIO_FROM_PHONE_NUMBER,
      to: TWILIO_TO_PHONE_NUMBER,
      body: body
    )
  end
end