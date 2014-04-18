class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "[#{http://message.to}] #{message.subject}"
    http://message.to = ENV['DEVELOPER_EMAIL']
  end
end