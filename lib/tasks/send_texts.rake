# task :send_texts => :environment do
#   
#   @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
#         @client.account.messages.create(
#           :from => ENV["TWILIO_NUMBER"],
#           :to => ENV["MY_PHONE_NUMBER"],
#           :body => "WORKING"
#         )
# end
# 
# task :send_texts => :environment do
#   
#   @user = User.find(params[:id])
#   @current_user = current_user.fname
#   
#   @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
#         @client.account.messages.create(
#           :from => ENV["TWILIO_NUMBER"],
#           :to => ("+1" + @user.phone_num),
#           :body => params[:text]
#         )
# end
# 
# # rake send_texts